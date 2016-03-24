//
//  AdViewController.m
//  exam
//
//  Created by zdy on 15/9/24.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "AdViewController.h"

@interface AdViewController ()


@end

@implementation AdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showAd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAd
{
    CGFloat p = 480;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        p = [UIScreen mainScreen].bounds.size.width;
    }
    else {
        p = [UIScreen mainScreen].bounds.size.height;
    }
    
    NSString *tag = @"4.png";
    if (p == 480) {
        tag = @"4.png";
    }
    else if(p == 568){
        tag = @"5.png";
    }
    else if(p == 667){
        tag = @"6.png";
    }
    else if(p == 736){
        // 貌似6plus 下没有优先加载@3x图片
        tag = @"6@3x.png";
    }
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ad2_%@",tag]];
    [self setImage:image];
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_time_t endTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2*delayInSeconds * NSEC_PER_SEC));
    
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ad2_%@",tag]];
//        [self setImage:image];
//    });
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.finish();
    });
}

- (void)setImage:(UIImage *)image{
    if (image == nil) {
        return;
    }
    
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        if (image.imageOrientation == UIImageOrientationUp ||
            image.imageOrientation == UIImageOrientationDown) {
            UIImage *pImage = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationLeft];
            self.imageView.image = pImage;
        }
        else {
            self.imageView.image = image;
        }
    }
    else {
        if (image.imageOrientation == UIImageOrientationLeft ||
            image.imageOrientation == UIImageOrientationRight) {
            UIImage *pImage = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUp];
            self.imageView.image = pImage;
        }
        else {
            self.imageView.image = image;
        }
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)updateViewConstraints
{
    UIImage *image = self.imageView.image;
    [self setImage:image];
    [super updateViewConstraints];
}
@end
