//
//  WYLSettingRowItem.m
//  Lottery
//
//  Created by 王亚龙 on 16/3/11.
//  Copyright © 2016年 王亚龙. All rights reserved.
//

#import "WYLSettingRowItem.h"

@implementation WYLSettingRowItem


+(instancetype)settingRowItemWithTitle:(NSString *)title detailText:(NSString *)detailText
{
    WYLSettingRowItem *item = [[self alloc] init];
    item.title = title;
    item.detailText = detailText;
    return item;
}
@end
