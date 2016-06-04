//
//  WYLSettingArrowItem.h
//  Lottery
//
//  Created by 王亚龙 on 16/3/12.
//  Copyright © 2016年 王亚龙. All rights reserved.
//

#import "WYLSettingRowItem.h"

@interface WYLSettingArrowItem : WYLSettingRowItem

/** 目标类*/
@property (nonatomic ,assign) Class desClass;

/** block*/
@property (nonatomic ,strong) void(^myBlock)();

@end
