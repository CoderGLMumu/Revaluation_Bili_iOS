//
//  WYLSettingGroupItem.m
//  Lottery
//
//  Created by 王亚龙 on 16/3/12.
//  Copyright © 2016年 王亚龙. All rights reserved.
//

#import "WYLSettingGroupItem.h"

@implementation WYLSettingGroupItem


+(instancetype)settingGroupItemWithrowArray:(NSArray *)rowArray header:(NSString *)header footer:(NSString *)footer
{
    WYLSettingGroupItem *item = [[WYLSettingGroupItem alloc] init];
    item.header = header;
    item.footer = footer;
    item.rowArray = rowArray;
    return item;
    
}
@end
