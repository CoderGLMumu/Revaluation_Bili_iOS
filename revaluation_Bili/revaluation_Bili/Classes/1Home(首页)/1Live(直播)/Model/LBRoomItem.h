//
//  LBRoomItem.h
//  Bili
//
//  Created by 林彬 on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//


// 直播界面每个cell中的直播room.

#import <Foundation/Foundation.h>

@interface LBRoomItem : NSObject
/** 内容 */
@property(nonatomic , strong)NSDictionary *cover;

/** 在线人数 */
@property(nonatomic , assign)NSNumber *online;

/** up主,含有头像 owner[@"face"] */
@property(nonatomic , strong)NSDictionary *owner;

/** 房间ID */
@property(nonatomic , assign)NSNumber *room_id;

/** 标题 */
@property(nonatomic , strong)NSString *title;




/******  以下是自定义属性,和服务器返回数据无关  *******/
@property(nonatomic , assign)CGFloat collectionCellHeight;
@property(nonatomic , assign)CGFloat collectionCellWidth;

@end
