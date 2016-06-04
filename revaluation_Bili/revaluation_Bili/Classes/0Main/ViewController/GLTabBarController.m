//
//  GLTabBarController.m
//  revaluation_Bili
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLTabBarController.h"

#import "GLTabBarViewModel.h"

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



@end
