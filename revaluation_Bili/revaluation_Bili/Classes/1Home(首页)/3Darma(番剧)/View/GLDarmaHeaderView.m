//
//  GLDarmaHeaderView.m
//  revaluation_Bili
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLDarmaHeaderView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface GLDarmaHeaderView () <SDCycleScrollViewDelegate>
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
    [headerView layoutIfNeeded];
    headerView.frame = CGRectMake(0, 0, GLScreenW, imageH + headerView.button_4.glh_height + headerView.button_3.glh_height + 10);
    return headerView;
}

- (void)setBannerImages:(NSArray *)bannerImages
{
    _bannerImages = bannerImages;
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:self.bannerView.bounds delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    NSLog(@"self.topView.bounds ==%@",NSStringFromCGRect(self.bannerView.bounds));
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.currentPageDotColor = GLColor(255, 30, 175);
    cycleScrollView2.pageDotColor = GLColor(255, 255, 255);
    
    cycleScrollView2.clickItemOperationBlock = ^(NSInteger currentIndex){
        if (self.ClickBanner) {
            self.ClickBanner(currentIndex);
        }
    };
    
    // 自定义分页控件小圆标颜色
    for (UIView *view in self.bannerView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.bannerView addSubview:cycleScrollView2];
    
    cycleScrollView2.imageURLStringsGroup = self.bannerImages;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.glh_height = self.bannerView.glh_height + self.button_4.glh_height + self.button_3.glh_height + (5 * 3);
}

@end
