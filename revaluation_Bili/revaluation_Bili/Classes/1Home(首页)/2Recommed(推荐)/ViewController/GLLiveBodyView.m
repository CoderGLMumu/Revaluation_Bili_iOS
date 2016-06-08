//
//  GLLiveBodyView.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveBodyView.h"

@implementation GLLiveBodyView

+ (instancetype)GLLiveBodyViewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GLLiveBodyView" owner:self options:nil] lastObject];
}

@end
