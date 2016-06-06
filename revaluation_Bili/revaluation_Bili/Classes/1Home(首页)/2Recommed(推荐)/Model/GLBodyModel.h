//
//  GLBodyModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLBodyModel : NSObject

/* 图片URL **/
@property(nonatomic , strong)NSString *cover;

/* 评论 **/
@property(nonatomic , strong)NSString *danmaku;

///* 未知 **/
//@property(nonatomic , strong)NSString *param;

/* 播放量 **/
@property(nonatomic , strong)NSString *play;

/* 番剧更新日期 **/
@property(nonatomic , strong)NSString *desc1;

/* 类型 **/
@property(nonatomic , strong)NSString *style;

/* 标题 **/
@property(nonatomic , strong)NSString *title;

/* up主 **/
@property(nonatomic , strong)NSString *up;

/* up主头像 **/
@property(nonatomic , strong)NSString *up_face;

/* 高度 **/
@property(nonatomic , assign)NSNumber *height;

/* 在线人数 **/
@property(nonatomic , assign)NSNumber *online;

/* 宽度 **/
@property(nonatomic , assign)NSNumber *width;

@property(nonatomic , assign) CGFloat bodyHeight;

@end
