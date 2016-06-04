//
//  LBLiveItem.m
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBLiveItem.h"
//#import <MJExtension.h>
#import "LBRoomItem.h"

@interface LBLiveItem()
@property(nonatomic , weak)NSArray *roomArr;
@end

@implementation LBLiveItem
-(NSArray *)roomArr
{
    if (_roomArr == nil) {
//        _roomArr =
        
        _roomArr = [NSArray yy_modelArrayWithClass:[LBRoomItem class] json:self.lives];
//        [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[LBRoomItem class] json:self.lives]];
//        [LBRoomItem mj_objectArrayWithKeyValuesArray:self.lives]
    }
    
    return _roomArr;
}
-(CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    CGFloat topH = 40;

   
    CGFloat itemH = [self.roomArr[0] collectionCellHeight];
    
    
    CGFloat middleH = ( itemH + 10 ) *2;
    CGFloat bottomH = 60;
   
    return topH + middleH + bottomH ;
    
}
@end
