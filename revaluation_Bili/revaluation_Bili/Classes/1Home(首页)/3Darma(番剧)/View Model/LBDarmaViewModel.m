//
//  LBDarmaViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LBDarmaViewModel.h"

@implementation LBDarmaViewModel

#pragma mark - 网络请求数据
- (void)loadLiveViewDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = @"http://live.bilibili.com/AppIndex/home";
    NSDictionary *dictM = @{
                            @"actionKey":@"appkey",
                            @"appkey":@"27eb53fc9058f8c3",
                            @"build":@"3060",
                            @"device":@"phone",
                            @"platform":@"ios",
                            @"scale":@"2",
                            @"sign":@"13f053baf875521b0d1958c812a0f110",
                            @"ts":@"1460106665"
                            };
    // 调用网络请求工具类
    [HttpToolSDK getWithURL:url parameters:dictM success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 处理网络请求数据
- (void)handleLiveViewDataSuccess:(void (^)())success Failure:(void (^)())failure
{
    [self loadLiveViewDataSuccess:^(id json) {
        
        
        
        success();
    } failure:^(NSError *error) {
        failure();
    }];
}

@end
