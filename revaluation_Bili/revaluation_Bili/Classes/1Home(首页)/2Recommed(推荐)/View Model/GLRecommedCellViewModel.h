//
//  GLRecommedCellViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLRecommedCellModel;
@class LBRecBodyView;

/**
 *  cell的视图模型.
 */
@interface GLRecommedCellViewModel : NSObject

/** 存储/传递cell_body的viewModel数组 */
@property (nonatomic, strong)NSArray *cellbodyItemViewModels;
/* 标题 **/
@property(nonatomic , strong)NSString *title;

@property(nonatomic , strong)NSString *style;

@property(nonatomic , strong)NSArray *body;

@property(nonatomic , strong)NSString *type;

/** cell的高度 */
@property(nonatomic , assign)CGFloat middleVH;

@property(nonatomic , strong)LBRecBodyView *bodyView;

/** cell的高度 */
@property(nonatomic , assign)CGFloat cellHeight;


- (instancetype)initWithModel:(GLRecommedCellModel *)model;

- (void)setCellBodyData;

@end
