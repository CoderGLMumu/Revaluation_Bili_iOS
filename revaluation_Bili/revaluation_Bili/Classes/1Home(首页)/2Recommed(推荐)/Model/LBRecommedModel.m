


//
//  LBRecommedModel.m
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBRecommedModel.h"
#import "LBBodyModel.h"
@implementation LBRecommedModel

-(CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    if (_type == nil || [_type isEqualToString:@"weblink"]) return (GLScreenW - 20) * 211 / 714 + 30;
    
    LBBodyModel *item = [NSArray yy_modelArrayWithClass:[LBBodyModel class] json:self.body][0];
    
//    LBBodyModel *item = [LBBodyModel mj_objectArrayWithKeyValuesArray:_body][0];
    
    return item.bodyHeight * 2 + 110;
    
}
@end
