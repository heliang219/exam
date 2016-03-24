//
//  DBManager.h
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExamPaper.h"

@interface DBManager : NSObject
+ (DBManager *)shareManager;

- (NSArray *)getExamPaperIdsWithSectionId:(NSString *)sectionId;
- (void)updateExamWithID:(NSString *)Id withSelectedAnswer:(NSInteger)selectedAnswer;

- (NSArray *)getErrorExamPaperIdsWithSectionId:(NSInteger)sectionId;
- (NSArray *)getAllErrorExamPaperIds;
- (ExamPaper *)getPaperWithId:(NSString *)paperId;
@end
