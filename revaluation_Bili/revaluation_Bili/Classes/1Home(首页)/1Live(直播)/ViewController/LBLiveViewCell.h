//
//  LBLiveViewCell.h
//  Bili
//
//  Created by 林彬 on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBRoomItem,LBLiveItem;

@interface LBLiveViewCell : UITableViewCell
//@property(nonatomic , strong)LBRoomItem *roomItem;
@property(nonatomic , strong)LBLiveItem *cellItem;

// 创建模型数组
@property(nonatomic , strong)NSArray <LBRoomItem *>*roomItemArr;

@property (nonatomic, assign) CGFloat itemW;
@property (nonatomic, assign) CGFloat itemH;

- (void)setUpCellData;

//@property (nonatomic, assign) CGFloat middleViewheight;

/** 首页点击了直播房间 */
@property (nonatomic, strong) void(^didSelectLiveRoom)(LBRoomItem *roomItem);

@end
