//
//  ExamPaper.h
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamPaper : NSObject
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *sectionId;
@property (nonatomic, strong) NSString *noInPaper;
@property (nonatomic, assign) NSInteger rightAnswer;
@property (nonatomic, assign) NSInteger selectAnswer;
@property (nonatomic, strong) NSString *subjectTitle;

@property (nonatomic, strong) NSString *optionA;
@property (nonatomic, strong) NSString *optionB;
@property (nonatomic, strong) NSString *optionC;
@property (nonatomic, strong) NSString *optionD;
@property (nonatomic, strong) NSString *optionE;

@property (nonatomic, strong) NSString *des;

@property (nonatomic, strong) NSString *fileName;
@end
