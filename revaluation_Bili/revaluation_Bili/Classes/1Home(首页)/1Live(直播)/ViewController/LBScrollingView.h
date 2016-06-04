//
//  scrollingView.h
//  scrollingImage
//
//  Created by 林彬 on 16/4/22.
//  Copyright © 2016年 linbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBScrollingView;
@protocol LBScrollingViewDelegate <NSObject>
@optional
- (void)infiniteScrollView:(LBScrollingView *)infiniteScrollView didClickImageAtIndex:(NSInteger)index;
@end


@interface LBScrollingView : UIView
/** 需要显示的图片数据(要求里面存放UIImage\NSURL对象) */
@property (nonatomic, strong) NSArray *images;
/** 下载远程图片时的占位图片 */
@property (nonatomic, strong) UIImage *placeholderImage;
/** 用来监听框架内部事件的代理 */
@property (nonatomic, weak) id delegate;
@end
