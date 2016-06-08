//
//  GLRecommedViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecommedViewModel.h"
#import "GLRecommedItemViewModel.h"

#import "GLRecommedModel.h"

@interface GLRecommedViewModel ()

/** 用于判断cell类型 */
@property (nonatomic, strong) NSString *head;

//@property (strong, nonatomic) AFHTTPRequestOperationManager * httpClient;

// 保存cell的模型数组
@property (nonatomic ,strong)NSArray *cellArr;


@end

@implementation GLRecommedViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self handleLiveViewData];
    }
    return self;
}

/**
 *  和数据模型无关的初始化设置,放到独立的方法中.
 */

#pragma mark - 网络请求数据
- (void)loadLiveViewDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = @"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=index&platform=android&screen=xxhdpi&test=0&ts=1450884356000";
    //    NSDictionary *dictM = @{
    //                            @"actionKey":@"appkey",
    //                            @"appkey":@"27eb53fc9058f8c3",
    //                            @"build":@"3060",
    //                            @"device":@"phone",
    //                            @"platform":@"ios",
    //                            @"scale":@"2",
    //                            @"sign":@"13f053baf875521b0d1958c812a0f110",
    //                            @"ts":@"1460106665"
    //                            };
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
- (void)handleLiveViewData
{
    [self loadLiveViewDataSuccess:^(id json) {
        
        NSMutableArray * cellItemViewModels = [NSMutableArray array];
        
        self.cellArr = [NSArray yy_modelArrayWithClass:[GLRecommedModel class] json:json[@"result"]];
        
        RACSequence * newblogViewModels = [self.cellArr.rac_sequence
                                           map:^(GLRecommedModel * model) {
                                                  GLRecommedItemViewModel * vm = [[GLRecommedItemViewModel alloc] initWithArticleModel: model];
                                               
                                               return vm;
                                           }];
        
        
        [cellItemViewModels addObjectsFromArray: newblogViewModels.array];
        
        self.cellItemViewModels = cellItemViewModels;
        
    } failure:^(NSError *error) {

    }];
}

- (void)first
{
    [self handleLiveViewData];
}



@end
