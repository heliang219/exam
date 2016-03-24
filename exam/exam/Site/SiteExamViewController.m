//
//  SiteExamViewController.m
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "SiteExamViewController.h"
#import "ExamViewController.h"
#import "PureLayout.h"
#import "Define.h"
#import "DBManager.h"

@interface SiteExamViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *sectionArray;
@end

static NSString * const reuseIdentifier = @"Cell";

@implementation SiteExamViewController
- (id)initWithSectionArray:(NSArray *)sectionArray
{
    self = [super init];
    if (self) {
        self.sectionArray = sectionArray;
    }
    return self;
}

- (id)initWithStartSectionId:(NSInteger)startSectionId withSectionNumber:(NSInteger)sectionNumber
{
    self = [super init];
    if (self) {
//        self.startSectionId = startSectionId;
//        self.sectionNumber = sectionNumber;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.

    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc ] init];
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    [collectionView autoPinEdgesToSuperviewEdges];
    collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    collectionView.backgroundColor =[UIColor whiteColor];
    collectionView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), 40*([self.sectionArray count]/3 + 1)+20);
    [collectionView registerClass :[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    collectionView.alwaysBounceVertical = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
    
    self.title = @"试炼场";
    self.titles = @[@"练一",@"练二",@"练三",@"练四",
                    @"练五",@"练六",@"练七",@"练八",
                    @"练九",@"练十",@"练十一",@"练十二",
                    @"练十三",@"练十四",@"练十五",@"练十六",
                    @"练十七",@"练十八",@"练十九",@"练二十",
                    @"练二十一",@"练二十二",@"练二十三",@"练二十四",
                    @"练二十五",@"练二十六",@"练二十七",@"练二十八",
                    @"练二十九",@"练三十",@"练三十一",@"练三十二",
                    @"练三十三",@"练三十四",@"练三十五",@"练三十六",
                    @"练三十七",@"练三十八",@"练三十九",@"练四十"];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    [self.collectionView reloadData];
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == [self.sectionArray count]/3) {
        return [self.sectionArray count]%3;
    }
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([self.sectionArray count]%3 == 0) {
        return [self.sectionArray count]/3;
    }
    else {
        return [self.sectionArray count]/3+1;
    }
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
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:self.titles[i] forState:UIControlStateNormal];
    [btn setTitle:self.titles[i] forState:UIControlStateHighlighted];
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
    NSString *sectionId = self.sectionArray[btn.tag];
    NSArray *array = [[DBManager shareManager] getExamPaperIdsWithSectionId:sectionId];
    ExamViewController *vc = [[ExamViewController alloc] initWithSectionTitle:btn.titleLabel.text withSectionPaperIds:array];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)shouldAutorotate
{
    [self.view setNeedsLayout];
    return YES;
}
@end
