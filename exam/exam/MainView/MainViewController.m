//
//  MainViewController.m
//  exam
//
//  Created by zdy on 15/9/8.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "MainViewController.h"
#import "KitsViewController.h"
#import "SiteViewController.h"
#import "ExamViewController.h"
#import "ZNavigationDelegate.h"
#import "DBManager.h"
#import "Define.h"

@interface MainViewController ()
@property (nonatomic,strong) ZNavigationDelegate *navDelegate;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navDelegate = [[ZNavigationDelegate alloc] initWithNavController:self.navigationController];
    self.navigationController.delegate = self.navDelegate;
    
    self.title = @"考试达人";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 考试场
- (IBAction)exemSiteBtnPressed:(id)sender {
    SiteViewController *siteVC = [[SiteViewController alloc] init];
    [self.navigationController pushViewController:siteVC animated:YES];
}

// 悔过山
- (IBAction)regretBtnPressed:(id)sender {
    NSArray *array = [[DBManager shareManager] getAllErrorExamPaperIds];
    if ([array count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有错误题目！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        ExamViewController *vc = [[ExamViewController alloc] initWithTitle:@"悔过山" withAllErroExamPaperIds:array];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 秒锦囊
- (IBAction)kitsBtnPressed:(id)sender {
    KitsViewController *kitVC = [[KitsViewController alloc] init];
    [self.navigationController pushViewController:kitVC animated:YES];
}

// 退出
- (IBAction)exitBtnPressed:(id)sender {
}

- (BOOL)shouldAutorotate
{
    return NO;
}
@end
