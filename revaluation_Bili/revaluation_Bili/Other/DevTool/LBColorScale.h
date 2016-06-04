//
//  LBColorScale.h
//  Bili
//
//  Created by 林彬 on 16/4/8.
//  Copyright © 2016年 gl. All rights reserved.
//
/**
 *  本工具类必须要求scrollView的子View对应btnArr的一个按钮,
 *  且确保scrollView.subviews 与 btnArr 中的元素通过脚标一一对应.
 *  适用于按btnArr第一个按钮,跳转到scrollView的第一个子控制器,第二个按钮对应第二个,依次类推.
 */

/**
 *  待扩展:如何实现只输入 标题滚动视图和内容滚动视图,就自动返回已完成的界面?
 *
 *
 */

#import <Foundation/Foundation.h>

@interface LBColorScale : NSObject
/**
 *  根据传入的scrollView,来改变btnArr中对应按钮的颜色和字体实现渐变
 *
 *  @param scrollView 传入的btnArr
 *  @param btnArr     与scrollView中的子View一一对应的按钮数组
 */
+(void)scaleColor:(UIScrollView *)scrollView withButtonArray:(NSArray *)btnArr;

+(void)scaleTitle:(UIScrollView *)scrollView withButtonArray:(NSArray *)btnArr;
@end
