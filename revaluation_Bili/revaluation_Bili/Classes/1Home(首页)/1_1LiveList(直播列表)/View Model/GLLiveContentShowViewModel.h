//
//  GLLiveContentShowViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLLiveContentShowViewModel : NSObject

/** 模型数组 */
@property (nonatomic,strong)NSMutableArray *itemArray;

/** 没有网络更新占位图片回调 */
@property (nonatomic, strong) void(^notReachable)(BOOL isTimeOut);

/** 有网络更新占位图片回调 */
@property (nonatomic, strong) void(^Reachable)();

/** 网络请求后返回的数据为什么空占位图片回调 */
@property (nonatomic, strong) void(^notData)();

+ (instancetype)viewModel;

- (void)handleLiveViewDataWithTag:(NSString *)tag Sort:(NSString *)sort Area_id:(int)area_id Success:(void (^)())success Failure:(void (^)())failure;

+ (void)cancelloadLiveViewDataAtComplete:(void(^)())complete;

//tag

@end
