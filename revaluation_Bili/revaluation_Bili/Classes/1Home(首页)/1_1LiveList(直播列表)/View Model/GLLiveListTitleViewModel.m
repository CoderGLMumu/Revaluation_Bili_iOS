//
//  GLLiveTitleViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveListTitleViewModel.h"

@implementation GLLiveListTitleViewModel

//类方法，返回viewModel
+ (instancetype)viewModel
{
    //注意：这里建议使用self
    
    return [[self alloc]init];
}

-(void)dealloc
{
    NSLog(@"titleVMdeinit");
}

@end
