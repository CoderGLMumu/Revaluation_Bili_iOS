//
//  GLLiveTitleViewModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLLiveListTitleViewModel : NSObject

/** 确定用户点击的最新/最热按钮,传递给ContentView请求对应数据 */
@property (nonatomic, strong) NSString *sort_value;


+ (instancetype)viewModel;

@end
