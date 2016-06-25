//
//  GLRecommedViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GLRecommedModel;

@interface GLRecommedViewModel : NSObject

/** 存储/传递cell的viewModel数组 */
@property (nonatomic, strong) NSArray *cellItemViewModels;

//- (instancetype)initWithRecommedModel:(GLRecommedModel *)modal;

- (void)loadPhoneDataSourceToComplete:(void (^)())complete;

/** 上拉刷新 */
- (void)first;

@end
