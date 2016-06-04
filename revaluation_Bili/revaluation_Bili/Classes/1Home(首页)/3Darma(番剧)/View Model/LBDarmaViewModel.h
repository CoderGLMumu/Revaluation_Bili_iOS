//
//  LBDarmaViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBDarmaViewModel : NSObject

// 保存底部cell的模型数组
@property (nonatomic ,strong)NSMutableArray *bottomCellArr;

// 滚动条的模型数组
@property (nonatomic ,strong)NSMutableArray *banners;
// row1完结动画的模型数组
@property (nonatomic ,strong)NSMutableArray *ends;
// row0新番连载的模型数组
@property (nonatomic ,strong)NSMutableArray *latestUpdate;

- (void)handleLiveViewDataSuccess:(void (^)())success Failure:(void (^)())failure;

@end
