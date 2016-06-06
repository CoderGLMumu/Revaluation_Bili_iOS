//
//  GLTabBarViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLTabBarViewModel.h"
#import "GLHomeViewController.h"
#import "GLMineViewController.h"
#import "GLNavigationController.h"

@implementation GLTabBarViewModel

+ (void)setupTabBarItem:(UITabBarItem *)item
{
    
    // 设置字体颜色(在UIKIT框架中的NSAttributedString.h文件中找字典的key值)
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    // 设置字体大小,只能通过nomal状态来设置.
    NSMutableDictionary *attrNomal = [NSMutableDictionary dictionary];
    attrNomal[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrNomal forState:UIControlStateNormal];
}

#pragma mark -  设置子控制器
+ (void)setUpAllChildVC:(void(^)(UIViewController *ViewController))complete
{
    // 首页  (林彬)
    GLHomeViewController *homeVC = [[GLHomeViewController alloc] init];
    UINavigationController *homeNAV = [[UINavigationController alloc] initWithRootViewController:homeVC];
    complete(homeNAV);
    
#pragma mark -  高林
    // 关注  (高林修改)
    UIViewController *regardVC = [[UIViewController alloc] init];
    UINavigationController *regardNAV = [[UINavigationController alloc] initWithRootViewController:regardVC];
    complete(regardNAV);
    
#pragma mark -  王亚龙
    // 发现 (要不要用UINavigationController?)  (王亚龙修改)
    
    UIViewController *discoverVc = [[UIViewController alloc] init];
    UINavigationController *disNav = [[UINavigationController alloc] initWithRootViewController:discoverVc];
    complete(disNav);

    
#pragma mark -  王亚龙
    // 我的  (王亚龙修改)
    
    UIStoryboard *stroryboard = [UIStoryboard storyboardWithName:@"GLMineViewController" bundle:nil];
    GLMineViewController *mineVC = [stroryboard instantiateInitialViewController];
    UINavigationController *mineNAV = [[UINavigationController alloc] initWithRootViewController:mineVC];
    complete(mineNAV);
}

#pragma mark -  设置按钮
+ (void)setUpButtons:(NSUInteger)index :(UINavigationController *)nav
{
    
    switch (index) {
        case 0:
            // 设置"首页"按钮样式
            nav.tabBarItem.title = @"首页";
            nav.tabBarItem.image = [UIImage imageOriRenderNamed:@"hd_home"];
            nav.tabBarItem.selectedImage = [UIImage imageOriRenderNamed:@"hd_home_hover"];
            break;
            // 设置"关注"按钮样式
        case 1:
            nav.tabBarItem.title = @"关注";
            nav.tabBarItem.image = [UIImage imageOriRenderNamed:@"hd_attention"];
            nav.tabBarItem.selectedImage = [UIImage imageOriRenderNamed:@"hd_attention_hover"];
            break;
        case 2:
            // 设置"发现"按钮样式
            nav.tabBarItem.title = @"发现";
            nav.tabBarItem.image = [UIImage imageOriRenderNamed:@"hd_search"];
            nav.tabBarItem.selectedImage = [UIImage imageOriRenderNamed:@"hd_search_hover"];
            break;
            // 设置"我的"按钮样式
        case 3:
            nav.tabBarItem.title = @"我的";
            nav.tabBarItem.image = [UIImage imageOriRenderNamed:@"hd_mine"];
            nav.tabBarItem.selectedImage = [UIImage imageOriRenderNamed:@"hd_mine_hover"];
            break;
            
        default:
            break;
    }
}

//类方法，返回一个单例对象
+(instancetype)ViewModel
{
    //注意：这里建议使用self）
    
    return [[self alloc]init];
}




@end
