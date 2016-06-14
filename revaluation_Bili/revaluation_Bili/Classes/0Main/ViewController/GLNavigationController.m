//
//  GLNavigationController.m
//  revaluation_Bili
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLNavigationController.h"
#import "GLNavigationViewModel.h"

@interface GLNavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic , weak)UINavigationBar *navBar;

/** NavigationViewModel */
@property (nonatomic, strong) GLNavigationViewModel *navigationViewModel;

@end

@implementation GLNavigationController

- (GLNavigationViewModel *)navigationViewModel
{
    if (!_navigationViewModel) {
        _navigationViewModel = [GLNavigationViewModel viewModel];
    }
    return _navigationViewModel;
}

+ (void)load
{
    // 获取当前类下的导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // bug:
    // iOS7,iOS8 bug:把短信界面导航条改了,联系人界面会出现黑
    
    // 设置标题字体
    // 设置导航条标题字体 => 拿到导航条去设置
//    [UINavigationBar appearance];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    
    navBar.titleTextAttributes = attr;
    navBar.barStyle = UIBarStyleDefault;
    navBar.backgroundColor = [UIColor whiteColor];
    
    
    // 设置导航条背景图片
//    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 滑动功能
    //    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    //    [self.view addGestureRecognizer:pan];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 控制器手势什么时候触发
    //    pan.delegate = self;
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    // 清空手势代理,恢复滑动返回功能
    //    self.interactivePopGestureRecognizer.enabled = self;
    
}

#pragma mark - UIGestureRecognizerDelegate
// 是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 在根控制器下 不要 触发手势
    return self.childViewControllers.count > 1;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 非根控制器才需要设置返回按钮
        // 设置返回按钮
        
        __weak typeof(self) weakSelf = self;
        
        [self.navigationViewModel setUpBackBtn:^(UIButton *backButton) {
            // 设置返回按钮
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
            
            [backButton addTarget:weakSelf action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        }];
    }
    
    // 这个方法才是真正执行跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}



@end
