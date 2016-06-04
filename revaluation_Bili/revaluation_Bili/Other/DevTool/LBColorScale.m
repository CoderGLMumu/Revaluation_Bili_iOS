//
//  LBColorScale.m
//  Bili
//
//  Created by 林彬 on 16/4/8.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBColorScale.h"

@implementation LBColorScale

+(void)scaleColor:(UIScrollView *)scrollView withButtonArray:(NSArray *)btnArr
{
    
    NSInteger leftI = scrollView.contentOffset.x / GLScreenW;
    // 获取左边按钮
    UIButton *leftButton = btnArr[leftI];
    
    // 获取右边按钮 6
    NSInteger rightI = leftI + 1;
    UIButton *rightButton;
    if (rightI < btnArr.count) {
        rightButton = btnArr[rightI];
    }
    
    // 获取缩放比例
    // 0 ~ 1 => 1 ~ 1.3
    CGFloat rightScale = scrollView.contentOffset.x / GLScreenW - leftI;
    
    CGFloat leftScale = 1 - rightScale;
    
    // NSLog(@"leftScale--%lf--%@--%zd , rightScale-- %lf--%@--%zd",leftScale,leftButton.titleLabel.text,leftButton.selected,rightScale,rightButton.titleLabel.text,rightButton.selected);
    
    // 左滑,leftScale是 从 1 到 0,再变回1 ;rightScale 是从 0 到 1,再变回0
    
    // 右滑,leftScale是 从 0 到 1,       ;rightScale 是从 1 到 0
    /*
     左滑的时候,leftButton 是从 红到灰 ,rightButton是从灰到红.
     右滑的时候,leftButton 是从 灰到红 ,rightButton是从红到灰.
     */
    CGFloat redR = (213 + 29 *(1 - leftScale)) / 255.0 ;
    CGFloat greenR = (213 - 115 * (1 - leftScale)) / 255.0;
    CGFloat blueR = (213 - 73 * (1 - leftScale)) / 255.0 ;
    UIColor *rightColor = [UIColor colorWithRed:redR green:greenR blue:blueR alpha:1];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
    CGFloat redL = (242 - 29 *(rightScale)) / 255.0 ;
    CGFloat greenL = (98 + 115 *(rightScale)) / 255.0;
    CGFloat blueL = (140 + 73 * (rightScale)) / 255.0 ;
    UIColor *leftColor = [UIColor colorWithRed:redL green:greenL blue:blueL alpha:1];
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    
}


+(void)scaleTitle:(UIScrollView *)scrollView withButtonArray:(NSArray *)btnArr
{
    NSInteger leftI = scrollView.contentOffset.x / GLScreenW;
    // 获取左边按钮
    UIButton *leftButton = btnArr[leftI];
    
    // 获取右边按钮 6
    NSInteger rightI = leftI + 1;
    UIButton *rightButton;
    if (rightI < btnArr.count) {
        rightButton = btnArr[rightI];
    }
    
    // 获取缩放比例
    // 0 ~ 1 => 1 ~ 1.3
    CGFloat rightScale = scrollView.contentOffset.x / GLScreenW - leftI;
    
    CGFloat leftScale = 1 - rightScale;
    
    // 对标题按钮进行缩放 1 ~ 1.3
    leftButton.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3 + 1);
    rightButton.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3 + 1);
}

@end
