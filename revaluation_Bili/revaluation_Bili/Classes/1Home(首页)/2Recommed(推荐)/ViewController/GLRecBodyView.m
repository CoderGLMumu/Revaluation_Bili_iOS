//
//  GLRecBodyView.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecBodyView.h"

@implementation GLRecBodyView

+ (instancetype)GLRecBodyViewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GLRecBodyView" owner:self options:nil] lastObject];
}

@end
