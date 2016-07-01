//
//  GLTabBarController.m
//  revaluation_Bili
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLTabBarController.h"

#import "GLTabBarViewModel.h"

#import "GLVideoRoomViewController.h"
#import "GLNavigationController.h"
#import "IJKMoviePlayerViewController.h"

@interface GLTabBarController ()

/** tabBarViewModel */
@property (nonatomic, strong) GLTabBarViewModel *tabBarViewModel;

@end

@implementation GLTabBarController

- (GLTabBarViewModel *)tabBarViewModel
{
    if (_tabBarViewModel == nil) {
        _tabBarViewModel = [GLTabBarViewModel ViewModel];
    }
    return _tabBarViewModel;
}

+ (void)load
{
    // 获取全局的tabbaritem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    [GLTabBarViewModel setupTabBarItem:item];    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置自己的所有子控制器.
    [self setUpAllChildVC];
    
    // 设置自己身上的按钮
    [self setUpButtons];
    
}

#pragma mark -  设置子控制器
- (void)setUpAllChildVC
{
    [GLTabBarViewModel setUpAllChildVC:^(UIViewController *ViewController) {
        [self addChildViewController:ViewController];
    }];
    
}

#pragma mark -  设置按钮
- (void)setUpButtons
{
    
    for (int i = 0; i < self.childViewControllers.count; ++i) {
        [GLTabBarViewModel setUpButtons:i :self.childViewControllers[i]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)shouldAutorotate{
    BOOL __block isPlayerView = NO;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSArray *navVCs = self.childViewControllers;
    [navVCs.rac_sequence.signal subscribeNext:^(UINavigationController *navVC) {
        if ([navVC.topViewController.childViewControllers.firstObject isKindOfClass:[IJKMoviePlayerViewController class]]) {
            isPlayerView = YES;
        }
        //发出已完成的信号
        dispatch_semaphore_signal(semaphore);
    }];
    
    //等待执行，不会占用资源
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return isPlayerView;
    
//    NSLog(@"%d",[self.childViewControllers isKindOfClass:[IJKMoviePlayerViewController class]]);
}
// 更新下目标,下个问题解决直播列表的内存管理


@end
