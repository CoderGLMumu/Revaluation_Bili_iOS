//
//  GLRecomBannerViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRecomBannerViewModel : NSObject
/** 【装有图片链接的数组】 */
@property (nonatomic, copy) NSArray *imageArr;
/** 【装有图片跳转链接的数组】 */
@property (nonatomic, copy) NSArray *imageValueArr;

+ (instancetype)viewModel;

- (void)handleRecomData;

- (void)loadPhoneDataSourceToComplete:(void (^)())complete;

@end
