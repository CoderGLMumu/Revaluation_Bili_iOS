//
//  WYLPopView.m
//  Bili
//
//  Created by 王亚龙 on 16/4/21.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLPopView.h"

@implementation WYLPopView

+(void)show
{
    WYLPopView *view = [[NSBundle mainBundle] loadNibNamed:@"WYLPopView" owner:nil options:nil][0];
    view.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}
- (IBAction)closeButtonClick:(id)sender {
    [self removeFromSuperview];
    
    //发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"miss" object:nil];
}


@end
