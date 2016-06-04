//
//  GLNavigationViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLNavigationViewModel.h"

@implementation GLNavigationViewModel

+ (instancetype)viewModel
{
    return [[self alloc]init];
}
- (void)setUpBackBtn:(void(^)(UIButton *backButton))complete
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icnav_back_dark"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icnav_back_light"] forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [backButton sizeToFit];
    
    // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    
    complete(backButton);
}


@end
