//
//  WYLSettingGroupItem.h
//  Lottery
//
//  Created by 王亚龙 on 16/3/12.
//  Copyright © 2016年 王亚龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYLSettingGroupItem : NSObject

/** 头部标题*/
@property (nonatomic ,strong) NSString *header;

/** 尾部标题*/
@property (nonatomic ,strong) NSString *footer;

/** 数组*/
@property (nonatomic ,strong) NSArray *rowArray;



//构造方法
+(instancetype)settingGroupItemWithrowArray:(NSArray *)rowArray header:(NSString *)header footer:(NSString *)footer;


@end
