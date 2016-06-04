//
//  GLHomeViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLHomeViewModel : NSObject

+ (instancetype)viewModel;

+ (void)setUpChildViewController:(void(^)(UIViewController *childViewController))complete;

+ (void)setUpTitleScrollView:(CGFloat)y_Point complete:(void(^)(UIScrollView *scrollView))complete;

+ (void)setUpMainScrollView:(CGFloat)y_Point complete:(void(^)(UIScrollView *scrollView))complete;

+ (void)addCurrentChildView:(NSInteger)index vc:(UIViewController *)vc height:(CGFloat)height complete:(void(^)(UIView *view))complete;

@end
