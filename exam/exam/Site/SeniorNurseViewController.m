//
//  SeniorNurseViewController.m
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "SeniorNurseViewController.h"
#import "SiteExamViewController.h"

@interface SeniorNurseViewController ()

@end

@implementation SeniorNurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"护师";
}

- (IBAction)part1Pressed:(id)sender {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:30];
    for (int i=31; i<=40; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=97; i<=116; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    SiteExamViewController *vc = [[SiteExamViewController alloc] initWithSectionArray:array];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)part2Pressed:(id)sender {
//    SiteExamViewController *vc = [[SiteExamViewController alloc] initWithStartSectionId:41 withSectionNumber:10];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:30];
    for (int i=41; i<=50; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=117; i<=136; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    SiteExamViewController *vc = [[SiteExamViewController alloc] initWithSectionArray:array];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)part3Pressed:(id)sender {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:30];
    for (int i=51; i<=60; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=157; i<=176; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    SiteExamViewController *vc = [[SiteExamViewController alloc] initWithSectionArray:array];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)part4Pressed:(id)sender {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:30];
    for (int i=61; i<=70; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=137; i<=156; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    SiteExamViewController *vc = [[SiteExamViewController alloc] initWithSectionArray:array];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
