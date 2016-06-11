//
//  GLVideoRoomViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLVideoRoomViewModel : NSObject

/**** 传递模型数据 ****/
/** 用于请求页面数据的唯一id */
@property (nonatomic, strong) NSString *aid;

/** 下拉描述 */
@property (nonatomic, strong) NSString *desc;
/** 充电相关 count 、list、show、total*/
@property (nonatomic, strong) NSDictionary *elec;
/** up信息 face、mid、name、pendant*/
@property (nonatomic, strong) NSDictionary *owner;
/** cid、page*/
@property (nonatomic, strong) NSArray *pages;
/** 播放占位图片 */
@property (nonatomic, strong) NSString *pic;
/** 视频一些要展示使用的信息coin投硬币、danmaku发送的弹幕数量、favorite收藏、reply评论数量、share分享数量、view观看次数46294	显示4万*/
@property (nonatomic, strong) NSDictionary *stat;
/** 视频相关-标签 */
@property (nonatomic, strong) NSArray *tags;


/** 存储/传递cell的viewModel数组 【relates】相关视频*/
@property (nonatomic, strong) NSArray *cellItemViewModels;

- (void)handleLiveViewData;

- (instancetype)initWithAid:(NSString *)aid;

@end
