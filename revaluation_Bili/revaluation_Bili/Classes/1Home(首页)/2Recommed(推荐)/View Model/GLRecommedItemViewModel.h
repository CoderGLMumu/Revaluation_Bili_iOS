//
//  GLRecommedItemViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GLRecommedModel;

@interface GLRecommedItemViewModel : NSObject

/** 头部标题 */
@property(nonatomic , strong)NSString *title;
/** 头部标题 */
@property(nonatomic , strong)NSString *style;
/** 用于判断cell类型 */
@property(nonatomic , strong)NSString *type;
/** title【头部标题】 */
//@property(nonatomic , strong)NSDictionary *head;
/** 4个collectionView的cell或者是其他数据 */
@property(nonatomic , strong)NSArray *body;

/** 当前多少人在直播 */
@property(nonatomic , assign) NSString *count;

/** cell的高度 */
@property(nonatomic , assign) CGFloat cellHeight;

/** 里面的数据 */
//@property(nonatomic , strong)GLBodyModel *bodyItem;

- (instancetype)initWithArticleModel: (GLRecommedModel *) model;

@end
