//
//  LBRecommedCell.m
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBRecommedCell.h"
#import "LBRecommedModel.h"
#import "LBBodyModel.h"
#import "LBRecBodyView.h"
#import "LBLiveBodyView.h"
#import "LBBangumiBodyView.h"

#import "GLRecommedCellViewModel.h"

@interface LBRecommedCell()


@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (nonatomic , strong)NSArray *bodyArr;

@end

@implementation LBRecommedCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setViewModel:(GLRecommedCellViewModel *)viewModel
{
    _viewModel = viewModel;
}

- (void)setCellItem:(LBRecommedModel *)cellItem
{
    _cellItem = cellItem;
    
    self.bodyArr = [NSArray yy_modelArrayWithClass:[LBBodyModel class] json:self.cellItem.body];
    
    NSString *name = self.cellItem.head[@"title"];
    [self.titleButton setTitle:name forState:UIControlStateNormal];
    
    NSString *type =_cellItem.type;
    
  
    if ([type  isEqual: @"live"]) {
        // 设置正在直播的middleView和bottoView
        // 列
        NSInteger col = 2;
        // 列间距
        NSInteger colSpace = 10;
        // 行间距
        NSInteger rowSpace = 10;
        
        for (int i = 0; i < 4; i ++) {
            LBLiveBodyView *bodyView = [LBLiveBodyView LBLiveBodyViewFromNib];
            bodyView.bodyItem = self.bodyArr[i];
            
            CGFloat bodyW = (GLScreenW - 30) * 0.5;
            CGFloat bodyH = ((GLScreenW - 30) * 0.5) * 128/ 234 + 35 + 17;
            
            // 动态计算中间view的高度
            CGFloat middleVH = rowSpace * 2 + bodyH * 2;
            self.middleView.frame = CGRectMake(0, 40, GLScreenW, middleVH);
            
            self.bottomView.gly_y = CGRectGetMaxY(self.middleView.frame) + 10;
            
            
            CGFloat bodyX = i % col * bodyW + (i % col + 1) * colSpace;
            CGFloat bodyY = i / col * bodyH + (i / col + 1) * rowSpace;
            bodyView.frame = CGRectMake(bodyX, bodyY, bodyW, bodyH);
            [self.middleView addSubview:bodyView];
        }
        
        
    }else if ([type  isEqual: @"bangumi_2"] || [type  isEqual: @"bangumi_3"]) {
        // 设置番剧推荐的middleView和bottoView
        // 列
        NSInteger col = 2;
        // 列间距
        NSInteger colSpace = 10;
        // 行间距
        NSInteger rowSpace = 10;
        
        for (int i = 0; i < 4; i ++) {
            LBBangumiBodyView *bodyView = [LBBangumiBodyView LBBangumiBodyViewFromNib];
            bodyView.bodyItem = _bodyArr[i];
            
            CGFloat bodyW = (GLScreenW - 30) * 0.5;
            CGFloat bodyH = ((GLScreenW - 30) * 0.5) * 128/ 234 + 35 + 17;
            
            // 动态计算中间view的高度
            CGFloat middleVH = rowSpace * 2 + bodyH * 2;
            self.middleView.frame = CGRectMake(0, 40, GLScreenW, middleVH);
            
            self.bottomView.gly_y = CGRectGetMaxY(self.middleView.frame) + 10;
            
            CGFloat bodyX = i % col * bodyW + (i % col + 1) * colSpace;
            CGFloat bodyY = i / col * bodyH + (i / col + 1) * rowSpace;
            bodyView.frame = CGRectMake(bodyX, bodyY, bodyW, bodyH);
            [self.middleView addSubview:bodyView];
        }
        
    }else if (type == nil || [type isEqualToString:@"weblink"]) {
        // 设置广告的cell
        UIImageView *adView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, GLScreenW - 20, (GLScreenW - 20) * 211 / 714)];
        NSString *path = _cellItem.body[0][@"cover"];
        NSURL *url = [NSURL URLWithString:path];
        [adView sd_setImageWithURL:url placeholderImage:nil];
        
        [self.contentView addSubview:adView];
        
        [self layoutIfNeeded];
        
    }else{
        
        // 设置热门推荐的middleView和bottomView
        // 列
        NSInteger col = 2;
        // 列间距
        NSInteger colSpace = 10;
        // 行间距
        NSInteger rowSpace = 10;
        
        for (int i = 0; i < 4; i ++) {
            LBRecBodyView *bodyView = [LBRecBodyView LBRecBodyViewFromNib];
            bodyView.bodyItem = _bodyArr[i];
            
            CGFloat bodyW = (GLScreenW - 30) * 0.5;
            CGFloat bodyH = ((GLScreenW - 30) * 0.5) * 128/ 234 + 35 + 17;
            
            // 动态计算中间view的高度
            CGFloat middleVH = rowSpace * 2 + bodyH * 2;
            self.middleView.frame = CGRectMake(0, 40, GLScreenW, middleVH);
            
            self.bottomView.gly_y = CGRectGetMaxY(self.middleView.frame) + 10;
            
            
            CGFloat bodyX = i % col * bodyW + (i % col + 1) * colSpace;
            CGFloat bodyY = i / col * bodyH + (i / col + 1) * rowSpace;
            bodyView.frame = CGRectMake(bodyX, bodyY, bodyW, bodyH);
            [self.middleView addSubview:bodyView];
            
        }
        
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (_cellItem.type == nil || [_cellItem.type isEqualToString:@"weblink"]) {
        
        self.glh_height = (GLScreenW - 20) * 211 / 714 + 30;
        
    }
    return;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
