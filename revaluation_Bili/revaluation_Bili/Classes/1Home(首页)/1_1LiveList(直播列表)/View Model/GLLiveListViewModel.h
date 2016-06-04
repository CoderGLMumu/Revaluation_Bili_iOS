//
//  GLLiveListViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLLiveListViewModel : NSObject

+ (instancetype)viewModel;

- (void)handleLiveViewDataWithListID:(int)listID success:(void (^)(NSArray *btn_titles))success Failure:(void (^)(NSArray *btn_titles))failure;

@end
