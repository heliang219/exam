//
//  SiteExamViewController.h
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteExamViewController : UIViewController
- (id)initWithStartSectionId:(NSInteger)startSectionId withSectionNumber:(NSInteger)sectionNumber;
- (id)initWithSectionArray:(NSArray *)sectionArray;

@end
