//
//  GLLiveRoomViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLLiveRoomModel.h"

@interface GLLiveRoomViewModel : NSObject

/** liveRoomDataModel */
@property (nonatomic, strong) GLLiveRoomModel *liveRoomDataModel;

+ (void)setUpHeaderView:(UIView *)headerView complete:(void(^)())complete;

+ (void)setUpFooterView:(UIView *)footerView complete:(void(^)())complete;

+ (instancetype)viewModel;

- (void)handleVCToVMDataonline:(NSString *)online face:(NSString *)face;

- (void)handleLiveViewDataWithRoom_id:(NSString *)room_id Success:(void (^)())success Failure:(void (^)())failure;

+ (void)cancelloadLiveViewDataAtComplete:(void(^)())complete;

@end
