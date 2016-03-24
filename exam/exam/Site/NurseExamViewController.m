//
//  NurseExamViewController.m
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "NurseExamViewController.h"
#import "SiteExamViewController.h"

@interface NurseExamViewController ()

@end

@implementation NurseExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"护士";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)part1Pressed:(id)sender {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:40];
    for (int i=1; i<=15; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=84; i<=96; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    SiteExamViewController *vc = [[SiteExamViewController alloc] initWithSectionArray:array];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)part2Pressed:(id)sender {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:40];
    for (int i=16; i<=30; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=71; i<=83; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    SiteExamViewController *vc = [[SiteExamViewController alloc] initWithSectionArray:array];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
