//
//  ExamViewController.m
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "ExamViewController.h"
#import "DBManager.h"
#import "MBProgressHUD.h"
#import "ExamErrorViewController.h"
#import "PureLayout.h"

typedef enum : NSUInteger {
    kExamSite,      // 练习
    kExamRegret,    // 错题集
    kExamAnswer,    // 答案解析
} ExamType;

@interface ExamViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *questionTitle;
@property (strong, nonatomic) IBOutlet UIImageView *questionImageView;

@property (strong, nonatomic) IBOutlet UIButton *optionA;
@property (strong, nonatomic) IBOutlet UIButton *optionB;
@property (strong, nonatomic) IBOutlet UIButton *optionC;
@property (strong, nonatomic) IBOutlet UIButton *optionD;
@property (strong, nonatomic) IBOutlet UIButton *optionE;

@property (strong, nonatomic) IBOutlet UILabel *optionALabel;
@property (strong, nonatomic) IBOutlet UILabel *optionBLabel;
@property (strong, nonatomic) IBOutlet UILabel *optionCLabel;
@property (strong, nonatomic) IBOutlet UILabel *optionDLabel;
@property (strong, nonatomic) IBOutlet UILabel *optionELabel;

@property (strong, nonatomic) IBOutlet UIView *answerView;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;
@property (strong, nonatomic) IBOutlet UILabel *selectedLabel;
@property (strong, nonatomic) IBOutlet UILabel *desLabel;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidth;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *answerViewHeight;

@property (nonatomic, strong) NSArray *questinIds;

@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) ExamPaper *currentPaper;
@property (nonatomic, strong) NSString *paperId;

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSMutableArray *errorPaperIds;

@property (nonatomic,assign) ExamType examType;
@end

@implementation ExamViewController

// 一组试题
- (id)initWithSectionTitle:(NSString *)title withSectionPaperIds:(NSArray *)array
{
    if (self = [super init]) {
        self.title = title;
        self.questinIds = array;
        self.currentIndex = 0;
        self.titleStr = title;
        self.examType = kExamSite;
    }
    return self;
}

// 答案解析
- (id)initWithTitle:(NSString *)title withPaperId:(NSString *)paperId
{
    if (self = [super init]) {
        self.title = title;
        self.paperId = paperId;
        self.currentIndex = 0;
        self.titleStr = title;
        self.examType = kExamAnswer;
    }
    return self;
}

// 全部错题
- (id)initWithTitle:(NSString *)title withAllErroExamPaperIds:(NSArray *)array
{
    if (self = [super init]) {
        self.title = title;
        self.questinIds = array;
        self.currentIndex = 0;
        self.titleStr = title;
        self.examType = kExamRegret;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.errorPaperIds = [NSMutableArray arrayWithCapacity:self.questinIds.count];
    
    if (self.examType == kExamAnswer) {
        self.currentPaper = [[DBManager shareManager] getPaperWithId:self.paperId];
    }
    else {
        NSString *paperId = self.questinIds[self.currentIndex];
        self.currentPaper = [[DBManager shareManager] getPaperWithId:paperId];
    }
    
    [self showCurrentQuestion:self.currentPaper];
    [self setLabel];
}

- (void)backBtnPressed:(id)sender
{
    if (self.examType == kExamSite) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"加油，请坚持练完！练完这一组就可以看到答案了哟~" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(self.examType == kExamRegret) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"是否返回主界面?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setLabel
{
    self.questionTitle.numberOfLines = 0;
    self.optionALabel.numberOfLines = 0;
    self.optionBLabel.numberOfLines = 0;
    self.optionCLabel.numberOfLines = 0;
    self.optionDLabel.numberOfLines = 0;
    self.optionELabel.numberOfLines = 0;
    self.desLabel.numberOfLines = 0;
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];

    // ios6以下需要
    if([[UIDevice currentDevice].systemVersion doubleValue] < 7.0)
    {
        self.questionTitle.preferredMaxLayoutWidth = self.questionTitle.bounds.size.width;
        self.optionALabel.preferredMaxLayoutWidth = self.optionALabel.bounds.size.width;
        self.optionBLabel.preferredMaxLayoutWidth = self.optionBLabel.bounds.size.width;
        self.optionCLabel.preferredMaxLayoutWidth = self.optionCLabel.bounds.size.width;
        self.optionDLabel.preferredMaxLayoutWidth = self.optionDLabel.bounds.size.width;
        self.optionELabel.preferredMaxLayoutWidth = self.optionELabel.bounds.size.width;
        self.desLabel.preferredMaxLayoutWidth = self.desLabel.bounds.size.width;
    }
}

- (void)showCurrentQuestion:(ExamPaper *)paper
{
   self.questionTitle.text = paper.subjectTitle;

    // 是否有图片
    if (paper.fileName.length) {
        self.questionImageView.hidden = NO;
        
        UIImage *image = [UIImage imageNamed:paper.fileName];
        self.questionImageView.image = image;
        self.imageViewWidth.constant = MIN(image.size.width, CGRectGetWidth(self.view.bounds)-30);
        self.imageViewHeight.constant = MIN(image.size.height, 360);
    }
    else{
        self.questionImageView.hidden = YES;
        self.imageViewHeight.constant = 0;
    }

    self.optionALabel.text = paper.optionA;
    self.optionBLabel.text = paper.optionB;
    self.optionCLabel.text = paper.optionC;
    self.optionDLabel.text = paper.optionD;
    self.optionELabel.text = paper.optionE;
    
    self.currentPaper = paper;
    
    if (self.examType == kExamAnswer) {
        self.optionA.enabled = NO;
        self.optionB.enabled = NO;
        self.optionC.enabled = NO;
        self.optionD.enabled = NO;
        self.optionE.enabled = NO;
        
        self.answerView.hidden = NO;
        self.answerViewHeight.constant = 126;
        [self loadComments];
    }
    else {
        self.answerView.hidden = YES;
        self.answerViewHeight.constant = 0;
        self.title = [NSString stringWithFormat:@"%@(%d/%d)",self.titleStr,self.currentIndex+1,(int)self.questinIds.count];
    }
}

- (void)loadComments
{
    NSArray *options = @[@"",@"A",@"B",@"C",@"D",@"E"];
    self.rightLabel.text = [NSString stringWithFormat:@"正确答案：%@",options[self.currentPaper.rightAnswer]];
    self.selectedLabel.text = [NSString stringWithFormat:@"你的答案：%@",options[self.currentPaper.selectAnswer]];

    if (self.currentPaper.des.length) {
        self.desLabel.text = [NSString stringWithFormat:@"解释：%@",self.currentPaper.des];
    }
}

- (IBAction)selectedBtnPressed:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    
    [[DBManager shareManager] updateExamWithID:self.currentPaper.Id withSelectedAnswer:btn.tag];
    [self.errorPaperIds addObject:self.currentPaper.Id];
    
    [self performSelector:@selector(showTipView:) withObject:btn afterDelay:0.2];
}

- (void)showTipView:(UIButton *)btn
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIImage *image = nil;
    if (btn.tag == self.currentPaper.rightAnswer) {
        image = [UIImage imageNamed:@"right"];
    }
    else {
        image = [UIImage imageNamed:@"error"];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [view addSubview:imageView];
    [imageView autoSetDimensionsToSize:image.size];
    [imageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [imageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    btn.selected = NO;
    self.navigationItem.leftBarButtonItem.enabled = NO;
    [self performSelector:@selector(showNextQuestion:) withObject:view afterDelay:0.5];
}

- (void)showNextQuestion:(UIView *)view
{
    self.navigationItem.leftBarButtonItem.enabled = YES;
    [view removeFromSuperview];
    
    self.currentIndex ++;
    
    if (self.currentIndex >= [self.questinIds count]) {
        ExamErrorViewController *vc = [[ExamErrorViewController alloc] initWithExamPaperIds:self.errorPaperIds];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:^{
            [self.navigationController popViewControllerAnimated:NO];}];
    }
    else {
        NSString *paperId = self.questinIds[self.currentIndex];
        self.currentPaper = [[DBManager shareManager] getPaperWithId:paperId];
        [self showCurrentQuestion:self.currentPaper];
    }
}
@end
