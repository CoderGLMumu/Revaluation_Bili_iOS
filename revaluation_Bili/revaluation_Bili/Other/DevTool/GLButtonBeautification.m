//
//  GLButtonBeautification.m
//  Bili
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLButtonBeautification.h"
@implementation GLButtonBeautification

+ (void)ButtonBeautification:(UIButton *)button AndColor:(UIColor *)color AndCornerRadius:(CGFloat)cornerRadius Completion:(void(^)(UIButton *Beautif_button))Completion
{
    if (color) {
        button.layer.borderColor = color.CGColor;
    }

    if (cornerRadius) {
        button.layer.cornerRadius = cornerRadius;
    }
    
    button.lineBreakMode = NSLineBreakByTruncatingTail;
    
    button.layer.borderWidth = 1;

    button.layer.masksToBounds = YES;
    
    Completion(button);
    
}

@end
