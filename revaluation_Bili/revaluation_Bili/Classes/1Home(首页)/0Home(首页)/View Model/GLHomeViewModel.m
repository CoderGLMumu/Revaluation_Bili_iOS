//
//  GLHomeViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLHomeViewModel.h"
#import "GLDarmaViewController.h"
#import "GLPartitionViewController.h"
//#import "GLRecommedViewController.h"
#import "LBLiveViewController.h"
//#import "LBRecommedViewController.h"

#import "GLRecommedViewController.h"

#define titleH 45

@implementation GLHomeViewModel

+ (instancetype)viewModel
{
    return [[GLHomeViewModel alloc]init];
}

#pragma mark -  设置子控制器
+ (void)setUpChildViewController:(void(^)(UIViewController *))complete
{
    // 添加直播子控制器
    LBLiveViewController *liveVC = [[LBLiveViewController alloc] init];
    liveVC.title = @"直播";
    liveVC.view.backgroundColor = [UIColor lightGrayColor];
    //liveVC.navigationController.navigationBarHidden = NO;
    complete(liveVC);
    
    
    // 添加推荐子控制器
    
    GLRecommedViewController *recommedVC = [[UIStoryboard storyboardWithName:NSStringFromClass([GLRecommedViewController class]) bundle:nil]instantiateInitialViewController];
    recommedVC.title = @"推荐";
//    recommedVC.view.backgroundColor = [UIColor redColor];
    complete(recommedVC);
    
    // 添加番剧子控制器
    GLDarmaViewController *darmaVC = [[GLDarmaViewController alloc] init];
    darmaVC.title = @"番剧";
    darmaVC.view.backgroundColor = [UIColor purpleColor];
    complete(darmaVC);
    
    // 添加分区子控制器
    GLPartitionViewController *subareaVC = [[GLPartitionViewController alloc] init];
    subareaVC.title = @"分区";
    subareaVC.view.backgroundColor = [UIColor orangeColor];
    complete(subareaVC);
}

#pragma mark -  设置标题滚动条
+ (void)setUpTitleScrollView:(CGFloat)y_Point complete:(void(^)(UIScrollView *scrollView))complete
{
    
    UIScrollView *titleSCV = [[UIScrollView alloc] init];
    // 判断有没有隐藏导航栏,如果隐藏了导航栏,那么高度就是20.如果没有,那就是64.
    
    titleSCV.frame = CGRectMake(0, y_Point, GLScreenW, titleH);
    titleSCV.backgroundColor = [UIColor whiteColor];
    complete(titleSCV);
}

#pragma mark -  设置内容滚动条
+ (void)setUpMainScrollView:(CGFloat)y_Point complete:(void(^)(UIScrollView *scrollView))complete
{
    
    UIScrollView *mainSCV = [[UIScrollView alloc] init];
    
    // 内容的y值是标题滚动条y值的最大值
    
    
    // 设置内容滚动条的位置,再减49是底部tableBar
    mainSCV.frame = CGRectMake(0, y_Point, GLScreenW, GLScreenH - y_Point - 49);
    
    mainSCV.backgroundColor = [UIColor yellowColor];
    mainSCV.showsHorizontalScrollIndicator = NO;
    mainSCV.showsVerticalScrollIndicator = NO;
    complete(mainSCV);
    
}

#pragma mark -  添加所有子控制器的View到内容滚动区域
+ (void)addCurrentChildView:(NSInteger)index vc:(UIViewController *)vc height:(CGFloat)height complete:(void(^)(UIView *view))complete
{
//    // 根据角标获得对应的子控制器
//    UIViewController *vc = self.childViewControllers[index];
    // 判断下有没有父控件,防止重复调用这个方法.
    if (vc.view.superview) return;
    
    // 设置frame
    CGFloat x = index * GLScreenW;
    vc.view.frame = CGRectMake(x, 0, GLScreenW, height);
    
    complete(vc.view);
}


@end
