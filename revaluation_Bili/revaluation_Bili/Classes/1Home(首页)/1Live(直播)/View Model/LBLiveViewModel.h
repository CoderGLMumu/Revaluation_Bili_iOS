//
//  LBLiveViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBLiveViewModel : NSObject

// 每个cell的模型数组
@property(nonatomic ,strong)NSArray *cellItemArr;

// headerView的button模型数组
@property(nonatomic ,strong)NSArray *entranceButtomItems;

// headerView的banner模型数组
@property(nonatomic ,strong)NSArray *headerBannerArr;

+ (void)setUpHeaderViewComplete:(void(^)(UIView *buttonView))complete;

- (void)handleLiveViewDataSuccess:(void (^)())success Failure:(void (^)())failure;

+ (instancetype)viewModel;

+ (void)cancelloadLiveViewDataAtComplete:(void(^)())complete;

@end
