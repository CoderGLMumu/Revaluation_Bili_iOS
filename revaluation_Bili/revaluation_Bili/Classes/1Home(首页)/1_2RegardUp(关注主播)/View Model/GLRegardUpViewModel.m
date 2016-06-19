//
//  GLRegardUpViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRegardUpViewModel.h"
#import "GLRegardUpModel.h"

@implementation GLRegardUpViewModel


#pragma mark - 网络请求数据
- (void)loadLiveViewDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = @"http://live.bilibili.com/AppFeed/index?access_key=aa769b7fbfadf8a43d209a567792b1f7&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3220&device=phone&page=1&pagesize=30&platform=ios&sign=106f36c727db40e82c79d5b4a6e9a3e1&ts=1466340617";
    // 调用网络请求工具类
    [HttpToolSDK getWithURL:url parameters:nil success:^(id json) {
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
        self.listModels = [NSArray yy_modelArrayWithClass:[GLRegardUpModel class] json:json[@"data"][@"list"]];
        //获得直播cell的数组
//        NSArray *partitions = json[@"data"][@"partitions"];
//        
//        self.cellItemArr = [NSArray yy_modelArrayWithClass:[LBLiveItem class] json:partitions];
//        
//        // 获得headerView按钮字典数组
//        NSArray *entranceIcons = json[@"data"][@"entranceIcons"];
//        
//        self.entranceButtomItems = [NSArray yy_modelArrayWithClass:[LBEntranceButtonItem class] json:entranceIcons];
//        
//        // 获得headerView的滚动条图片数组
//        NSArray *banners = json[@"data"][@"banner"];
//        
//        self.headerBannerArr = [NSArray yy_modelArrayWithClass:[LBLiveBannerItem class] json:banners];
        success();
    } failure:^(NSError *error) {
        failure();
    }];
}

@end
