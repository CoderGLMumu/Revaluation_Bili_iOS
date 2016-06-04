


//
//  LBLiveButton.m
//  Bili
//
//  Created by 林彬 on 16/4/19.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBLiveButton.h"

@implementation LBLiveButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.imageView.gls_size = CGSizeMake(20, 20);
    }
    return self;
}

/**
 *  不让按钮达到高亮状态
 */
- (void)setHighlighted:(BOOL)highlighted {}
@end
