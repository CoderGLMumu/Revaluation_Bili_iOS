//
//  WYLScanViewController.m
//  Bili
//
//  Created by 王亚龙 on 16/5/6.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLScanViewController.h"
#import "revaluation_Bili-Swift.h"

@interface WYLScanViewController ()
/** 背景view*/
@property (weak, nonatomic) IBOutlet UIView *backView;
/** 底部的约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toBottom;

@end

@implementation WYLScanViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置标题
    self.title = @"二维码扫描";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置导航条隐藏
    // 注意:这里只能用这个方法设置,不能利用属性
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startAnimation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [QRCodeTool shareInstance].isGetQR = false;
    [[QRCodeTool shareInstance] scanQRCode_stop];
}

// 开始执行动画
-(void)startAnimation
{
    self.toBottom.constant = self.backView.frame.size.height;
    self.toBottom.constant = -self.backView.frame.size.height;
    
    [UIView animateWithDuration:2 animations:^{
        // 设置动画执行次数
        [UIView setAnimationRepeatCount:MAXFLOAT];
        
        [self.view layoutIfNeeded];
    }];
    
}

@end
