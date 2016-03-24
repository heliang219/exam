//
//  KitsViewController.m
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "KitsViewController.h"
#import <QuickLook/QuickLook.h>

@interface KitsViewController ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>
@property (nonatomic, strong) NSString *fileName;
@end

@implementation KitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"妙锦囊";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 预览界面
    self.navigationController.navigationBar.translucent = NO;
}

// 护士
- (IBAction)nurseBtnPressed:(id)sender {
    self.fileName = @"护士锦囊";
    
    QLPreviewController *preview = [[QLPreviewController alloc] init];
    preview.delegate = self;
    preview.dataSource = self;
    [self.navigationController pushViewController:preview animated:YES];
}

// 护师
- (IBAction)SeniorNurseBtnPressed:(id)sender {
    self.fileName = @"护师锦囊";
    
    QLPreviewController *preview = [[QLPreviewController alloc] init];
    preview.delegate = self;
    preview.dataSource = self;
    [self.navigationController pushViewController:preview animated:YES];
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller;
{
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.fileName withExtension:@"pdf"];
    return url;
}

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item;
{
    return YES;
}

- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id<QLPreviewItem>)item inSourceView:(UIView *__autoreleasing *)view
{
    return self.view.bounds;
}

@end
