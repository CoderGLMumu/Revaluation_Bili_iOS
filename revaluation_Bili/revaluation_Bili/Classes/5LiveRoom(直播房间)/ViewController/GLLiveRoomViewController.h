//
//  GLLiveRoomViewController.h
//  revaluation_Bili
//
//  Created by mac on 16/5/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLLiveRoomViewController : UITableViewController

/** 请求的房间号码 */
@property (nonatomic, strong) NSString *room_id;

/** 小头像 */
@property (nonatomic, strong) NSString *face;

/** 在线人数 */
@property (nonatomic, strong) NSString *online;

@end
