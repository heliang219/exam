//
//  ExamErrorViewController.m
//  exam
//
//  Created by zdy on 15/9/10.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "ExamErrorViewController.h"
#import "ExamViewController.h"
#import "ZNavigationDelegate.h"
#import "PureLayout.h"

@interface ExamErrorViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *paperIds;
@property (nonatomic, strong) ZNavigationDelegate *navDelegate;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

static NSString * const reuseIdentifier = @"ErrorCell";

@implementation ExamErrorViewController

- (id)initWithExamPaperIds:(NSArray *)array
{
    self = [super init];
    if (self) {
        self.paperIds = array;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navDelegate = [[ZNavigationDelegate alloc] initWithNavController:self.navigationController];
    self.navigationController.delegate = self.navDelegate;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"试炼场";
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, 0, 46, 30);
    cancel.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitle:@"取消" forState:UIControlStateHighlighted];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [cancel addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc ] init];
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    [collectionView autoPinEdgesToSuperviewEdges];
    collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    collectionView.backgroundColor =[UIColor whiteColor];
    collectionView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 40*([self.paperIds count]/3 + 1)+20);
    [collectionView registerClass :[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    collectionView.alwaysBounceVertical = YES;
    collectionView.delegate = self ;
    collectionView.dataSource = self ;
    self.collectionView = collectionView;
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    [self.collectionView reloadData];
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == [self.paperIds count]/3) {
        return [self.paperIds count]%3;
    }
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ([self.paperIds count]/3+1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    for (UIView *v in cell.contentView.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            [v removeFromSuperview];
            break;
        }
    }
    
    NSInteger i = indexPath.section*3 + indexPath.row;
    NSString *title = [NSString stringWithFormat:@"%d",(int)i+1];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(sectionBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [[UIImage imageNamed:@"btn-green.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    UIImage *imageHight = [[UIImage imageNamed:@"btn-green-pressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:imageHight forState:UIControlStateHighlighted];
    [cell.contentView addSubview:btn];
    
    [btn autoPinEdgesToSuperviewEdges];
    btn.tag = i;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(floorf((CGRectGetWidth(collectionView.bounds)-50)/3), 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (void)sectionBtnPressed:(UIButton *)btn
{
    NSString *paperId = self.paperIds[btn.tag];
    ExamViewController *vc = [[ExamViewController alloc] initWithTitle:@"答案解析" withPaperId:paperId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelBtnPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
