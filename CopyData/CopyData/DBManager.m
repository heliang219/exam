//
//  DBManager.m
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "DBManager.h"
#import "FMDB.h"


@interface DBManager ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation DBManager
+ (DBManager *)shareManager
{
    static DBManager *share = nil;
    static dispatch_once_t pre;
    dispatch_once(&pre, ^{
        share = [[DBManager alloc] init];
    });
    return share;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString*dbPath =[docDir stringByAppendingPathComponent:@"examdata.db"];
        
        NSFileManager*fileManager =[NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:dbPath]== NO){
            // 拷贝到document目录下
            NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"examdata" ofType:@"db"];
            [fileManager copyItemAtPath:resourcePath toPath:dbPath error:nil];
        }

        self.db = [FMDatabase databaseWithPath:dbPath];
        [self.db open];
    }
    return self;
}

- (NSArray *)getExamPaperIdsWithSectionId:(NSInteger)sectionId
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    NSString *sql = [NSString stringWithFormat:@"select id from subject where sectionId = %ld",(long)sectionId];

    FMResultSet *set = [self.db executeQuery:sql];
    while ([set next]) {
        NSString *paperId = [set stringForColumn:@"id"];
        [array addObject:paperId];
    }
    
    return array;
}

- (void)updateExamWithID:(NSString *)Id withSelectedAnswer:(NSInteger)selectedAnswer
{
    NSString *sql = [NSString stringWithFormat:@"update subject set selectAnswer = %ld where id = %@",(long)selectedAnswer,Id];
    [self.db executeUpdate:sql];
}


- (NSArray *)getErrorExamPaperIdsWithSectionId:(NSInteger)sectionId
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    NSString *sql = [NSString stringWithFormat:@"select id from subject where sectionId = %ld and subject.selectAnswer != 0 and subject.selectAnswer != subject.rightAnswer",(long)sectionId];
    
    FMResultSet *set = [self.db executeQuery:sql];
    while ([set next]) {
        
        NSString *paperId = [set stringForColumn:@"id"];
        [array addObject:paperId];
    }
    
    return array;
}

- (NSArray *)getAllErrorExamPaperIds
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    NSString *sql = [NSString stringWithFormat:@"select id from subject where subject.selectAnswer != 0 and subject.selectAnswer != subject.rightAnswer"];
    
    FMResultSet *set = [self.db executeQuery:sql];
    while ([set next]) {
        
        NSString *paperId = [set stringForColumn:@"id"];
        [array addObject:paperId];
    }
    
    return array;
}

- (void)addExamPaper:(ExamPaper *)paper
{
    NSString *sql = [NSString stringWithFormat:@"insert into subject(sectionId,NOInPaper,rightAnswer,selectAnswer,sujbectTitle,selectionA,selectionB,selectionC,selectionD,selectionE,description) values(%@,%@,%d,0,'%@','%@','%@','%@','%@','%@','%@')",paper.sectionId,paper.noInPaper,(int)paper.rightAnswer,
                     paper.subjectTitle,paper.optionA,paper.optionB,paper.optionC,paper.optionD,paper.optionE,paper.des];
    [self.db executeUpdate:sql];
}

- (ExamPaper *)getPaperWithId:(NSString *)paperId
{
    NSString *sql = [NSString stringWithFormat:@"select * from subject where id = %@",paperId];
    
    ExamPaper *paper;
    FMResultSet *set = [self.db executeQuery:sql];
    while ([set next]) {
        
        paper = [self paperWithResultSet:set];
        break;
    }
    
    return paper;
}

- (ExamPaper *)paperWithResultSet:(FMResultSet *)set
{
    ExamPaper *paper = [[ExamPaper alloc] init];
    paper.Id = [set stringForColumn:@"id"];
    paper.sectionId = [set stringForColumn:@"sectionId"];
    paper.noInPaper = [set stringForColumn:@"NOInPaper"];
    paper.rightAnswer = [set intForColumn:@"rightAnswer"];
    paper.selectAnswer = [set intForColumn:@"selectAnswer"];
    
    paper.subjectTitle = [set stringForColumn:@"sujbectTitle"];
    paper.optionA = [set stringForColumn:@"selectionA"];
    paper.optionB = [set stringForColumn:@"selectionB"];
    paper.optionC = [set stringForColumn:@"selectionC"];
    paper.optionD = [set stringForColumn:@"selectionD"];
    paper.optionE = [set stringForColumn:@"selectionE"];
    
    paper.des = [set stringForColumn:@"description"];
    paper.fileName = [set stringForColumn:@"subjectImage"];
    
    return paper;
}
@end
