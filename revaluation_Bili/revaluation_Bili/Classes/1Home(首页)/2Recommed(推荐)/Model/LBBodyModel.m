





//
//  LBBodyModel.m
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBBodyModel.h"

@implementation LBBodyModel

-(CGFloat)bodyHeight
{
    // 如果已经计算过，就直接返回
    if (_bodyHeight) return _bodyHeight;
    
    _bodyHeight = ((GLScreenW - 30) * 0.5) * 128/ 234 + 60;
    
    
    return _bodyHeight;
    
}
@end
