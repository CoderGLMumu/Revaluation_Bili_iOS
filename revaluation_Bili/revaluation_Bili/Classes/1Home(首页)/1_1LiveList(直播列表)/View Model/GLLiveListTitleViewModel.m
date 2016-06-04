//
//  GLLiveTitleViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveListTitleViewModel.h"

@implementation GLLiveListTitleViewModel

static GLLiveListTitleViewModel *_instance;

//类方法，返回一个单例对象
+ (instancetype)viewModel
{
    //注意：这里建议使用self
    
    return [[self alloc]init];
}

//保证永远只分配一次存储空间
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
//    使用GCD中的一次性代码
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [super allocWithZone:zone];
        });
    
    return _instance;
}

@end
