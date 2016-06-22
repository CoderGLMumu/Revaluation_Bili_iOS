//
//  WYLTravelViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/5/11.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLTravelViewController.h"

@interface WYLTravelViewController ()
/** topView*/
@property (nonatomic ,weak) UIView *topView;


@end

const CGFloat topViewHeight = 35;
const CGFloat margin = 10;

@implementation WYLTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加webView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, topViewHeight, GLScreenW, GLScreenH - topViewHeight)];
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"http://yoo.bilibili.com/html/indexm.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // 添加topView
    [self setUpTopView];
}

// 添加topView
-(void)setUpTopView
{
    // 添加topView
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, GLScreenW, topViewHeight)];
    self.topView = topView;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    // 添加返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(margin, 0, topViewHeight, topViewHeight);
    [backButton sizeToFit];
    [topView addSubview:backButton];
    
    // 添加分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    shareButton.frame = CGRectMake(GLScreenW - margin - topViewHeight, 0, topViewHeight, topViewHeight);
    [shareButton sizeToFit];
    [topView addSubview:shareButton];
    
    // 添加topTitle
    UILabel *topTitleLabel = [[UILabel alloc] init];
    topTitleLabel.font = [UIFont systemFontOfSize:14];
    topTitleLabel.text = @"哔哩哔哩旅行，专为二次元用户打造的ACG旅行网站 - bilibiliyoo";
    [self.topView addSubview:topTitleLabel];
    topTitleLabel.frame = CGRectMake(margin + margin + backButton.glw_width, 0, GLScreenW - 4 * margin - shareButton.glw_width - backButton.glw_width, topViewHeight);
    
}

// 点击返回按钮
-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 点击分享按钮
-(void)shareButtonClick
{

    // 添加遮盖的CoverView
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GLScreenW, GLScreenH)];
    coverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.view addSubview:coverView];
    
    // 添加bottomView
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 667, GLScreenW, 250)];
    bottomView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomView];
    
    bottomView.frame = CGRectMake(0, 417, GLScreenW, 250);
    [UIView animateWithDuration:1 animations:^{
        
        
        [self.view layoutIfNeeded];
    }];
}

@end






