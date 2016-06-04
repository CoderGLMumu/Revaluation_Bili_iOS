//
//  LBDarmaBottomModel.m
//  Bili
//
//  Created by 林彬 on 16/5/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBDarmaBottomModel.h"

@implementation LBDarmaBottomModel
-(CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    return ( GLScreenW - 20 ) / 3 + 60;
}
@end
