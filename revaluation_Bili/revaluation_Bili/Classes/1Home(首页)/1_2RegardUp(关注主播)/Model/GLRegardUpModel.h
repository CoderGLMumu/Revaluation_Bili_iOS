//
//  GLRegardUpModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRegardUpModel : NSObject
/** up用户名称 */
@property (nonatomic, copy) NSString *name;
/** up用户头像 */
@property (nonatomic, copy) NSString *face;
/** 分区 */
@property (nonatomic, copy) NSString *areaName;
/** 跳转直播房间id */
@property (nonatomic, copy) NSNumber *roomid;
/** 在线状态 */
@property (nonatomic, copy) NSNumber *live_status;
/** 粉丝数量 */
@property (nonatomic, copy) NSNumber *fansNum;
/** 房间描述标签数组 */
@property (nonatomic, copy) NSArray *roomTags;

@end
