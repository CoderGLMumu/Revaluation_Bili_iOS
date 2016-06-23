//
//  LBLiveViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LBLiveViewModel.h"
#import "LBLiveBannerItem.h"
#import "LBLiveItem.h"
#import "LBEntranceButtonItem.h"
#import "LBHeaderView.h"

@interface LBLiveViewModel ()

@end

@implementation LBLiveViewModel


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
        //获得直播cell的数组
        NSArray *partitions = json[@"data"][@"partitions"];
        
        self.cellItemArr = [NSArray yy_modelArrayWithClass:[LBLiveItem class] json:partitions];
        
        // 获得headerView按钮字典数组
        NSArray *entranceIcons = json[@"data"][@"entranceIcons"];
        
        self.entranceButtomItems = [NSArray yy_modelArrayWithClass:[LBEntranceButtonItem class] json:entranceIcons];
        
        // 获得headerView的滚动条图片数组
        NSArray *banners = json[@"data"][@"banner"];
        
        self.headerBannerArr = [NSArray yy_modelArrayWithClass:[LBLiveBannerItem class] json:banners];
        success();
    } failure:^(NSError *error) {
        failure();
    }];
}

+ (void)setUpHeaderViewComplete:(void(^)(UIView *buttonView))complete
{
//    UIButton *footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    CGFloat buttonH = 40;
//    CGFloat buttonW = [UIScreen mainScreen].bounds.size.width - 30;
//    footerButton.frame = CGRectMake(15, 0, buttonW, buttonH);
//    footerButton.backgroundColor = [UIColor redColor];
//    [footerButton setTitle:@"全部直播" forState:UIControlStateNormal];
//    [footerButton setTitle:@"全部直播" forState:UIControlStateHighlighted];
//    [footerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [footerButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    //    buttonView.layer.cornerRadius = 10;
    //    buttonView.layer.masksToBounds = YES;
    
//    [buttonView addSubview:footerButton];

    complete(buttonView);
}

//类方法，viewModel
+ (instancetype)viewModel
{
    //注意：这里建议使用self
    
    return [[self alloc]init];
}

+ (void)cancelloadLiveViewDataAtComplete:(void(^)())complete
{
    [HttpToolSDK cancelAllRequest];
    complete();
}

@end
