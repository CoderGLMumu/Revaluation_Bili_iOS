//
//  GLDynamicCellItem.h
//  Bili
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 gl. All rights reserved.
//

/** 头像avatar  用户名author  时间ctime 简缩图片pic  标题title  播放量play
 video_review 弹幕数量    description介绍  create创建时间
 */
#import <Foundation/Foundation.h>

@interface GLDynamicCellItem : NSObject

/** 视频详情界面标识参数 */
@property (nonatomic, strong) NSString* aid;

/** 时间 */
@property (nonatomic, strong) NSString* create;

/** 播放量 */
@property (nonatomic, strong) NSString* play;

/** 弹幕数量 */
@property (nonatomic, strong) NSString* video_review;

/** 头像 */
@property (nonatomic, strong) NSString *avatar;

/** 用户名 */
@property (nonatomic, strong) NSString *author;

/** 标题 */
@property (nonatomic, strong) NSString *title;

/** 介绍 */
//@property (nonatomic, strong) NSString *description;

/** 简缩图片 */
@property (nonatomic, strong) NSString *pic;

@end


