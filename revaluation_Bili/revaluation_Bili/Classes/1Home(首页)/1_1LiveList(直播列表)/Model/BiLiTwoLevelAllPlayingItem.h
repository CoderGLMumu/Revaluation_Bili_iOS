//
//  BiLiTwoLevelAllPlayingItem.h
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/4/16.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BiLiTwoLevelOwnerItem.h"
#import "BiLiTwoLevelCoverItem.h"
@interface BiLiTwoLevelAllPlayingItem : NSObject

/** 内容 */
@property (nonatomic,strong)NSString *title;

/** 下一个页面 直播房间 请求需要的参数 ID */
@property (nonatomic,strong)NSString *room_id;

/** 数量 */
@property (nonatomic,assign)NSInteger online;

@property (nonatomic,strong)BiLiTwoLevelOwnerItem *owner;

@property (nonatomic,strong)BiLiTwoLevelCoverItem *cover;
@end
