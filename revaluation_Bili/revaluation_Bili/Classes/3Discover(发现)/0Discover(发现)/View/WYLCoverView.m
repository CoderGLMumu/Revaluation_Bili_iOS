//
//  WYLCoverView.m
//  Bili
//
//  Created by 王亚龙 on 16/4/21.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLCoverView.h"

@implementation WYLCoverView

+(instancetype)show
{
    WYLCoverView *view = [[WYLCoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    return view;
}


@end
