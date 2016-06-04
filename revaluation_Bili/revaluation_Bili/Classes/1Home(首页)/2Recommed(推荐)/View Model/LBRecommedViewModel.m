//
//  LBRecommedViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LBRecommedViewModel.h"
// cell的模型
#import "LBRecommedModel.h"

@implementation LBRecommedViewModel

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
- (void)handleLiveViewDataSuccess:(void (^)())success Failure:(void (^)())failure
{
    [self loadLiveViewDataSuccess:^(id json) {
       
        self.cellArr = [NSArray yy_modelArrayWithClass:[LBRecommedModel class] json:json[@"result"]];
        
        success();
        
    } failure:^(NSError *error) {
        failure();
    }];
}

//提供一个static修饰的全局变量，强引用着已经实例化的单例对象实例
static LBRecommedViewModel *_instance;

//类方法，返回一个单例对象
+ (instancetype)viewModel
{
    //注意：这里建议使用self
    
    return [[self alloc]init];
}

//保证永远只分配一次存储空间
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

@end
