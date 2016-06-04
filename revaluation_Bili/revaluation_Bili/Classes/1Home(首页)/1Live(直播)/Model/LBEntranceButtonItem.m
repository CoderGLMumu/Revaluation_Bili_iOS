//
//  LBEntranceButtonItem.m
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBEntranceButtonItem.h"

@implementation LBEntranceButtonItem

// 在plist文件里遇到和系统关键字重名的属性,将它重命名.
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

@end
