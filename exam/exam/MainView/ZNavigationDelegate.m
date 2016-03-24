//
//  ZNavigationDelegate.m
//  exam
//
//  Created by zdy on 15/9/12.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "ZNavigationDelegate.h"


@implementation ZNavigationDelegate

- (id)initWithNavController:(UINavigationController *)navController
{
    self = [super init];
    if (self) {
        self.navController = navController;
        navController.interactivePopGestureRecognizer.delegate = self;
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.navController.topViewController isKindOfClass:NSClassFromString(@"ExamViewController")]) {
        return NO;
    }
    return [self.navController.viewControllers count]>1?YES:NO;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([navigationController.viewControllers count] == 1) {
        return;
    }
    
    if (viewController.navigationItem.leftBarButtonItem == nil) {
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        back.frame = CGRectMake(0, 0, 46, 30);
        back.titleLabel.font = [UIFont systemFontOfSize:14];
        [back setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
        [back setImage:[UIImage imageNamed:@"nav_back_pressed"] forState:UIControlStateHighlighted];
        [back addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    }
}

- (void)backPressed:(id)sender
{
    UIViewController *vc = [self.navController topViewController];
    if ([vc respondsToSelector:@selector(backBtnPressed:)] == NO) {
        [self.navController popViewControllerAnimated:YES];
    }
    else {
        [vc performSelector:@selector(backBtnPressed:) withObject:sender];
    }
}
@end
