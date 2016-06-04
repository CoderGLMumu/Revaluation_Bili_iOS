//
//  LBDarmaEndsModel.m
//  Bili
//
//  Created by 林彬 on 16/5/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBDarmaEndsModel.h"

@implementation LBDarmaEndsModel
- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    
    return  GLScreenW / 3 * 4 / 3 + 145 ;
}
@end
