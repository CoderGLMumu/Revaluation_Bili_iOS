//
//  GLDarmaHeaderView.m
//  revaluation_Bili
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLDarmaHeaderView.h"

@interface GLDarmaHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *button_4;
@property (weak, nonatomic) IBOutlet UIView *button_3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerConstraintH;

@end

@implementation GLDarmaHeaderView

+ (instancetype)darmaHeaderView
{
    GLDarmaHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
    CGFloat imageH = GLScreenW * 200 / 640;
    headerView.bannerConstraintH.constant = imageH;
    headerView.frame = CGRectMake(0, 0, GLScreenW, imageH + headerView.button_4.glh_height + headerView.button_3.glh_height + (5 * 5));
    return headerView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.glh_height = self.bannerView.glh_height + self.button_4.glh_height + self.button_3.glh_height + (5 * 3);
}

@end
