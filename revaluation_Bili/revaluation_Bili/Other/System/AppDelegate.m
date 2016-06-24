//
//  AppDelegate.m
//  revaluation_Bili
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "GLTabBarController.h"

#import "GLFMDBToolSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setUpFMDB];
    
    // 新建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 新建LBTabBarController
    GLTabBarController *tabbarVC = [[GLTabBarController alloc] init];
    
    // 设置根控制器
    self.window.rootViewController = tabbarVC;
    
    // 显示控制器
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setUpFMDB
{
    [GLFMDBToolSDK shareToolsWithCreateDDL:@"create table if not exists t_LBLiveBannerItem (img text,link TEXT,title TEXT,remark TEXT,bannerHeight integer);"];
    [GLFMDBToolSDK shareToolsWithCreateDDL:@"CREATE TABLE t_LBLiveItem (lives blob, partition blob);"];
    [GLFMDBToolSDK shareToolsWithCreateDDL:@"CREATE TABLE t_LBEntranceButtonItem ( entrance_icon blob, name text, ID blob );"];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
