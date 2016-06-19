//
//  GLRegardUpViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRegardUpViewModel : NSObject

/** 装有model的数组 */
@property (nonatomic, strong) NSArray *listModels;

- (void)handleLiveViewDataSuccess:(void (^)())success Failure:(void (^)())failure;

@end
