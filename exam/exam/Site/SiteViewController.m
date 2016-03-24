//
//  SiteViewController.m
//  exam
//
//  Created by zdy on 15/9/8.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "SiteViewController.h"
#import "NurseExamViewController.h"
#import "SeniorNurseViewController.h"

@interface SiteViewController ()

@end

@implementation SiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我要考";
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nurseBtnPressed:(id)sender {
    NurseExamViewController *vc = [[NurseExamViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 护师
- (IBAction)seniorNurseBtnPressed:(id)sender {
    SeniorNurseViewController *vc = [[SeniorNurseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
