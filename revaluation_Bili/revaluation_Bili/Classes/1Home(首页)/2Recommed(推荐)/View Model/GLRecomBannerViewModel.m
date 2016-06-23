//
//  GLRecomBannerViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecomBannerViewModel.h"

#import "GLRecomBannerModel.h"

@interface GLRecomBannerViewModel ()

/** 轮播图模型 */
@property (nonatomic, strong) GLRecomBannerModel *model;

@end

@implementation GLRecomBannerViewModel

- (GLRecomBannerModel *)model
{
    if (_model == nil) {
        _model = [[GLRecomBannerModel alloc] init];
    }
    return _model;
}

+ (instancetype)viewModel
{
    return [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化 和模型的关系 并且做网络请求
        [self linkModel];
        [self handleRecomData];
    }
    return self;
}

- (void)linkModel
{

}

/**
 *  和数据模型无关的初始化设置,放到独立的方法中.
 */

#pragma mark - 网络请求数据
- (void)loadRecomDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = @"http://app.bilibili.com/x/banner?build=3220&channel=appstore&plat=2";
    
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
- (void)handleRecomData
{
    [self loadRecomDataSuccess:^(id json) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        NSArray *test = [NSArray yy_modelArrayWithClass:[GLRecomBannerModel class] json:json[@"data"]];
        
        for (GLRecomBannerModel *model in test) {
            [arrM addObject:model.image];
        }
        self.imageArr = arrM;
        
    } failure:^(NSError *error) {
        
    }];
}

@end
