//
//  GLRecommedCell.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecommedCell.h"
#import "LBRecommedModel.h"
#import "GLRecommedCellViewModel.h"

#import "GLRecBodyView.h"
#import "GLLiveBodyView.h"
#import "GLBangumiBodyView.h"


@interface GLRecommedCell ()

@property (nonatomic , strong)NSArray *bodyArr;

@property (nonatomic, weak) IBOutlet UIView *middleView;

@property (nonatomic, weak) IBOutlet UIView *bottomView;

@property (nonatomic, weak) UIView *bodyView;

/** cell的高度 */
@property(nonatomic , assign)CGFloat middleVH;

@end

@implementation GLRecommedCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setViewModel:(GLRecommedCellViewModel *)viewModel
{
    _viewModel = viewModel;
    [RACObserve(self.viewModel, middleVH) subscribeNext:^(NSNumber *middleVH) {
        self.middleVH = middleVH.floatValue;
    }];
    
    [RACObserve(self.viewModel, title) subscribeNext:^(NSString *title) {
        // 创建/布局子视图
        [self setupView];
    }];
    
//    NSLog(@"wtewte%@",self.viewModel.body);
    
//    [self.viewModel gaolintest];
}

- (void)setupView
{
    if ([self.viewModel.type isEqual: @"recommend"] || [self.viewModel.type isEqual: @"live"] || [self.viewModel.type isEqual: @"bangumi_2"] || [self.viewModel.type isEqual: @"region"]) {
    // 设置热门推荐的middleView和bottomView
    // 列
    NSInteger col = 2;
    // 列间距
    NSInteger colSpace = 10;
    // 行间距
    NSInteger rowSpace = 10;
    
    if (self.middleView.subviews) {
        for (UIView *view in self.middleView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < 4; i ++) {
        if ([self.viewModel.type isEqualToString:@"recommend"]) {
            self.bodyView = [GLRecBodyView GLRecBodyViewFromNib];
        }else if ([self.viewModel.type isEqualToString:@"live"])
        {
        self.bodyView = [GLLiveBodyView GLLiveBodyViewFromNib];
        }else if ([self.viewModel.type isEqualToString:@"bangumi_2"])
        {
            self.bodyView = [GLBangumiBodyView GLBangumiBodyViewFromNib];
        }else if ([self.viewModel.type isEqualToString:@"region"])
        {
            self.bodyView = [GLRecBodyView GLRecBodyViewFromNib];
        }
        
//        GLLiveBodyView
//        bodyView.bodyItem = _bodyArr[i];
        
        CGFloat bodyW = (GLScreenW - 30) * 0.5;
        CGFloat bodyH = ((GLScreenW - 30) * 0.5) * 128/ 234 + 35 + 17;
        
        // 动态计算中间view的高度
        CGFloat middleVH = rowSpace * 2 + bodyH * 2;
        self.middleView.frame = CGRectMake(0, 40, GLScreenW, middleVH);
        
        self.bottomView.gly_y = CGRectGetMaxY(self.middleView.frame) + 10;

        CGFloat bodyX = i % col * bodyW + (i % col + 1) * colSpace;
        CGFloat bodyY = i / col * bodyH + (i / col + 1) * rowSpace;
        self.bodyView.frame = CGRectMake(bodyX, bodyY, bodyW, bodyH);
        
        [self.middleView addSubview:self.bodyView];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
