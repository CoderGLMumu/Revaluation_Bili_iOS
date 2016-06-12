//
//  GLLiveContentShowViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveContentShowViewModel.h"
#import "BiLiTwoLevelAllPlayingItem.h"

@interface GLLiveContentShowViewModel ()

@end

@implementation GLLiveContentShowViewModel

- (NSMutableArray *)itemArray
{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

#warning 需要ID ?, 最新/最热 ?, tag[全部]

#pragma mark - 网络请求数据
- (void)loadLiveViewDataWithTag:(NSString *)tag Sort:(NSString *)sort Area_id:(int)area_id Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure
{
    @weakify(self);
    [self netWorkReachabilityWithcomolete:^(BOOL netState) {
        if (netState) {
            // 使用请求参数 发送网络请求
            @strongify(self);
            /** 以下步骤 因为 没有密钥 无法请求网络数据,在手机上抓取的请求路径 解析 */
            
            __block NSString *url = @"";
            NSString *path = [[NSBundle mainBundle]pathForResource:@"LiveContentShow.plist" ofType:nil];
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            
            [dict.allKeys.rac_sequence.signal subscribeNext:^(NSString *area_id_value) {
                if (area_id == area_id_value.intValue) {
                    area_id_value = (NSString *)area_id_value;
                    NSDictionary *dictSort = dict[area_id_value];
                    [dictSort.rac_keySequence.signal subscribeNext:^(NSString *sort_value) {
                        if ([sort isEqualToString:sort_value]) {
                            sort_value = (NSString *)sort_value;
                            
                            NSDictionary *dictTag = dictSort[sort_value];
                            [dictTag.rac_keySequence.signal subscribeNext:^(NSString *tag_value) {
                                if ([tag isEqualToString:tag_value]) {
                                    tag_value = (NSString *)tag_value;
                                    url = dictTag[tag_value];
//                                    NSLog(@"url = %@",url);
                                    /** 以上步骤 因为 没有密钥 无法请求网络数据,在手机上抓取的请求路径 解析 */
                                    
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
                            }];
                        }
                    }];
                }
                
            }];
        }else{
            NSLog(@"2netState = %d",netState);
        }
    }];
}

#pragma mark - 处理网络请求数据
- (void)handleLiveViewDataWithTag:(NSString *)tag Sort:(NSString *)sort Area_id:(int)area_id Success:(void (^)())success Failure:(void (^)())failure
{
    @weakify(self);
    [self loadLiveViewDataWithTag:tag Sort:sort Area_id:area_id Success:^(id json) {
        @strongify(self);
        self.itemArray = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[BiLiTwoLevelAllPlayingItem class] json:json[@"data"]];
        
        if (self.itemArray.count == 0) {
            self.notData();
        }
        success();
    } Failure:^(NSError *error) {
        @strongify(self);
        if (error.code == -1001) {
            self.notReachable(YES);
        }
        failure();
        
    }];
     
}

# warning 为什么 setReachabilityStatusChangeBlock 是在主线程中执行,却是异步执行而且要等待方法执行完毕【这个方法封装到HttpTools里】


- (BOOL)netWorkReachabilityWithcomolete:(void(^)(BOOL netState))Comolete
{
    __block BOOL netState = NO;
    
    //1.通过网络监测管理者监听状态的改变
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            /*
             AFNetworkReachabilityStatusUnknown          = -1,  未知
             AFNetworkReachabilityStatusNotReachable     = 0,   没有网络
             AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G|4G
             AFNetworkReachabilityStatusReachableViaWiFi = 2,   WIFI
             */
            @strongify(self);
            switch (status) {
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
//                    NSLog(@"WIFI");
                    netState = YES;
                    if (self.Reachable) {
                        self.Reachable();
                    }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"3G&4G");
                    netState = YES;
                    if (self.Reachable) {
                        self.Reachable();
                    }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"没有网络");
                    netState = NO;
                    if (self.notReachable) {
                        self.notReachable(NO);
                    }
                    break;
                case AFNetworkReachabilityStatusUnknown:
                    NSLog(@"未知");
                    netState = NO;
                    break;
                default:
                    break;
            }
            Comolete(netState);
        }];
    });
    
    //2.开始监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    return netState;
}

+ (void)cancelloadLiveViewDataAtComplete:(void(^)())complete
{
    [HttpToolSDK cancelAllRequest];
    complete();
}

//类方法，返回一个viewModel
+ (instancetype)viewModel
{
    //注意：这里建议使用self
    return [[self alloc]init];
}

@end
