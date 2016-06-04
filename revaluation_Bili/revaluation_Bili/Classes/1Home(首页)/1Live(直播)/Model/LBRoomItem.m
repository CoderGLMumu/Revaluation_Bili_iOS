


//
//  LBRoomItem.m
//  Bili
//
//  Created by 林彬 on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBRoomItem.h"

@implementation LBRoomItem
-(CGFloat)collectionCellHeight
{
    CGFloat coverImageW = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
    CGFloat coverImageH = coverImageW *[self.cover[@"height"] floatValue] / [self.cover[@"width"] floatValue];
    // 35是coverView距离在线人数label的距离,17是在线人数label的高度
    _collectionCellHeight = coverImageH + 35 + 17;
    return _collectionCellHeight;
}

-(CGFloat)collectionCellWidth
{
    _collectionCellWidth = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
    return _collectionCellWidth;
}
@end
