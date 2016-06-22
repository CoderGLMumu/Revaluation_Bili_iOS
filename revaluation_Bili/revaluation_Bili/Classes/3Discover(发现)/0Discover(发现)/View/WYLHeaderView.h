//
//  WYLHeaderView.h
//  Bili
//
//  Created by 王亚龙 on 16/4/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYLButtonItem;

@interface WYLHeaderView : UIView

// 快速创建headerView
+(WYLHeaderView *)headerView;


@property (nonatomic ,assign) CGFloat height;

@property (nonatomic ,strong) NSArray *itemArray;

/** valueBlock */
@property (nonatomic, strong) void(^valueBlock)();
/** 跳转到搜索控制器的Block */
@property (nonatomic, strong) void(^searchBlock)();

@end
