//
//  LBRecommedViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBRecommedViewModel : NSObject

// 保存cell的模型数组
@property (nonatomic ,strong)NSArray *cellArr;
// 保存cell中每个body的模型数组
//@property (nonatomic ,strong)NSArray *bodyArr;

+ (instancetype)viewModel;

- (void)handleLiveViewDataSuccess:(void (^)())success Failure:(void (^)())failure;

@end
