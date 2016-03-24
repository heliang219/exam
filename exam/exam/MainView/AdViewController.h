//
//  AdViewController.h
//  exam
//
//  Created by zdy on 15/9/24.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AdFinish)(void);

@interface AdViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, copy) AdFinish finish;

- (void)setImage:(UIImage *)image;

@end
