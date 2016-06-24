//
//  LBLiveItem.h
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LBRoomItem;
@interface LBLiveItem : NSObject
/*
@property(nonatomic , assign)NSNumber *count;

@property(nonatomic , strong)NSString *name;

@property(nonatomic , strong)NSString *height;

@property(nonatomic , strong)NSString *width;

@property(nonatomic , strong)NSString *src;
*/

/** 包含了各个房间的数据的字典数组,需要转成模型 */
@property(nonatomic ,strong)NSArray *lives;

/** 包含了每个cell外部数据的字典 */
@property(nonatomic ,strong)NSDictionary *partition;

// 怎么求?
@property(nonatomic , assign)CGFloat cellHeight;

@end
