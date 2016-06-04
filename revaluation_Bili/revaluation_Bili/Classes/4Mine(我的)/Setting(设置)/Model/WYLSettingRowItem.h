//
//  WYLSettingRowItem.h
//  Lottery
//
//  Created by 王亚龙 on 16/3/11.
//  Copyright © 2016年 王亚龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYLSettingRowItem : NSObject

/** 标题*/
@property (nonatomic ,strong) NSString *title;

/** 子标题*/
@property (nonatomic ,strong) NSString *detailText;


//快速构造方法
+(instancetype)settingRowItemWithTitle:(NSString *)title detailText:(NSString *)detailText;

@end
