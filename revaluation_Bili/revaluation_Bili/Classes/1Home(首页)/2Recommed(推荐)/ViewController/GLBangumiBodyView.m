//
//  GLBangumiBodyView.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLBangumiBodyView.h"

@implementation GLBangumiBodyView

+ (instancetype)GLBangumiBodyViewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GLBangumiBodyView" owner:self options:nil] lastObject];
}

@end
