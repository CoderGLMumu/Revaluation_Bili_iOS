//
//  GLButtonBeautification.h
//  Bili
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLButtonBeautification : NSObject


+ (void)ButtonBeautification:(UIButton *)button AndColor:(UIColor *)color AndCornerRadius:(CGFloat)cornerRadius Completion:(void(^)(UIButton *Beautif_button))Completion;

@end
