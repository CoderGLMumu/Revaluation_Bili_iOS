




//
//  LBDarmaLatestUpdateModel.m
//  Bili
//
//  Created by 林彬 on 16/5/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBDarmaLatestUpdateModel.h"

@implementation LBDarmaLatestUpdateModel
-(CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    
    return (((GLScreenW - 30) * 0.5) * 128/ 234 + 45) * 3 + 90;
}
@end
