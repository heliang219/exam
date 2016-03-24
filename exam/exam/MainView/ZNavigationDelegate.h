//
//  ZNavigationDelegate.h
//  exam
//
//  Created by zdy on 15/9/12.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZNavigationDelegate : NSObject<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,weak) UINavigationController *navController;

- (id)initWithNavController:(UINavigationController *)navController;
@end

@protocol NavigationBackProtocol <NSObject>
@optional
- (void)backBtnPressed:(id)sender;

@end

@interface UIViewController()<NavigationBackProtocol>

@end