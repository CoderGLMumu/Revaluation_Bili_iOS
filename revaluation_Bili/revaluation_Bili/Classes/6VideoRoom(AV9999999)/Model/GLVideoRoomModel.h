//
//  GLVideoRoomModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLVideoRoomModel : NSObject

/**** 页面数据 ****/
/** 当前视频页面请求id */
@property (nonatomic, strong) NSNumber *aid;
/** 视频标题 */
@property (nonatomic, strong) NSString *title;
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
/** 发布的时间-距离1970年 */
@property (nonatomic, strong) NSNumber *pubdate;
/** 视频相关-标签 */
@property (nonatomic, strong) NSArray *tags;
@end

@interface GLVideoRoomcellItemModel : NSObject
/**** cellItem数据 ****/
/** 下一个视频页面请求id */
@property (nonatomic, strong) NSNumber *aid;
/** 视频页面请求id */
@property (nonatomic, strong) NSDictionary *owner;
/** 占位图片 */
@property (nonatomic, strong) NSString *pic;
/** 一些展示信息 up主,播放数量,弹幕数量 */
@property (nonatomic, strong) NSDictionary *stat;
/** 展示的标题 */
@property (nonatomic, strong) NSString *title;


@end
