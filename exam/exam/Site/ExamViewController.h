//
//  ExamViewController.h
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamViewController : UIViewController

- (id)initWithSectionTitle:(NSString *)title withSectionPaperIds:(NSArray *)array;

- (id)initWithTitle:(NSString *)title withPaperId:(NSString *)paperId;

- (id)initWithTitle:(NSString *)title withAllErroExamPaperIds:(NSArray *)array;
@end
