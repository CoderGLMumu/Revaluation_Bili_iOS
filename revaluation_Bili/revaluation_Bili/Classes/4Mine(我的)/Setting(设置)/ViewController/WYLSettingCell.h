//
//  WYLSettingCell.h
//  Lottery
//
//  Created by 王亚龙 on 16/3/12.
//  Copyright © 2016年 王亚龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYLSettingRowItem;

@interface WYLSettingCell : UITableViewCell

/** 组模型*/
@property (nonatomic ,strong) WYLSettingRowItem *rowItem;

+(WYLSettingCell *)settingCellWithRowItem:(WYLSettingRowItem *)rowItem tableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end
