//
//  GLRecommedCell.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecommedCell.h"
#import "LBRecommedModel.h"
#import "GLRecommedCellModel.h"

#import "GLRecommedCellViewModel.h"

#import "GLRecBodyView.h"
#import "GLLiveBodyView.h"
#import "GLBangumiBodyView.h"


@interface GLRecommedCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ScrollContentWidth;

@property (nonatomic , strong)NSArray *bodyArr;

@property (nonatomic, weak) IBOutlet UIView *middleView;

@property (nonatomic, weak) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIView *contentSizeView;


@property (nonatomic, weak) UIControl *bodyView;

/** cell的高度 */
@property(nonatomic , assign)CGFloat middleVH;


@end

@implementation GLRecommedCell

static int margin = 10;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setViewModel:(GLRecommedCellViewModel *)viewModel
{
    _viewModel = viewModel;
    [RACObserve(self.viewModel, middleVH) subscribeNext:^(NSNumber *middleVH) {
        self.middleVH = middleVH.floatValue;
    }];
    [RACObserve(self.viewModel, type) subscribeNext:^(NSString *type) {
        // 创建/布局子视图
        [self setupView];
    }];
    
//    NSLog(@"wtewte%@",self.viewModel.body);
    
//    [self.viewModel gaolintest];
}

- (void)setupView
{
    if (![self.viewModel.type isEqual: @"bangumi_3"]){
        if (self.middleView.subviews) {
            for (UIView *view in self.middleView.subviews) {
                [view removeFromSuperview];
            }
        }
    }else{
        if (self.middleView.subviews) {
            for (UIView *view in self.contentSizeView.subviews) {
                [view removeFromSuperview];
            }
        }
    }
    
//    NSLog(@"%@---",self.viewModel.type);
//    NSLog(@"%@-2--",self.viewModel.style);
    if ([self.viewModel.type isEqual: @"recommend"] || [self.viewModel.type isEqual: @"live"] || [self.viewModel.type isEqual: @"bangumi_2"] || [self.viewModel.type isEqual: @"region"]) {
    // 设置热门推荐的middleView和bottomView
    // 列
    NSInteger col = 2;
    // 列间距
    NSInteger colSpace = 10;
    // 行间距
    NSInteger rowSpace = 10;
        
    for (int i = 0; i < self.viewModel.body.count; i ++) {
        if ([self.viewModel.type isEqualToString:@"recommend"]) {
            GLRecBodyView *bodyview = [GLRecBodyView GLRecBodyViewFromNib];
            bodyview.body = self.viewModel.body[i];
            self.bodyView = bodyview;
        }else if ([self.viewModel.type isEqualToString:@"live"])
        {
        GLLiveBodyView *bodyview = [GLLiveBodyView GLLiveBodyViewFromNib];
            bodyview.body = self.viewModel.body[i];
            self.bodyView = bodyview;
        }else if ([self.viewModel.type isEqualToString:@"bangumi_2"])
        {
            GLBangumiBodyView *bodyview = [GLBangumiBodyView GLBangumiBodyViewFromNib];
            bodyview.body = self.viewModel.body[i];
            self.bodyView = bodyview;
        }else if ([self.viewModel.type isEqualToString:@"region"])
        {
            GLRecBodyView *bodyview = [GLRecBodyView GLRecBodyViewFromNib];
            bodyview.body = self.viewModel.body[i];
            self.bodyView = bodyview;
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
        
        [[self.bodyView rac_signalForControlEvents:UIControlEventTouchUpInside ]subscribeNext:^(id x) {
            // 传到控制器push视频播放页面
            
            if (self.Videodata) {
                GLRecommedCellModel *cellM = self.viewModel.cellbodyItemViewModels[i];
                self.Videodata(cellM);
            }
        }];
        
        }
    }else if ([self.viewModel.style isEqual: @"gl_pic"] || [self.viewModel.type isEqual: @"weblink"]){

        UIImageView *bodyView = [[UIImageView alloc]init];
        [bodyView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.body[0][@"cover"]] placeholderImage:[UIImage imageNamed:@"placeholderImage1"]];
        NSNumber *height =  self.viewModel.body.firstObject[@"height"];
        NSNumber *width = self.viewModel.body.firstObject[@"width"];
        bodyView.frame = CGRectMake(0, 0, GLScreenW - 20, height.floatValue / width.floatValue * (GLScreenW - 20));

        [self.middleView addSubview:bodyView];

    }else if ([self.viewModel.type isEqual: @"bangumi_3"]){
        for (int i = 0; i < self.viewModel.body.count; ++i) {
            // 电视剧
            GLBangumiBodyView *bodyview = [GLBangumiBodyView GLBangumiBodyViewFromNib];
            bodyview.body = self.viewModel.body[i];
            self.bodyView = bodyview;
            
            NSString *width_str = bodyview.body[@"width"];
            NSString *height_str = bodyview.body[@"height"];
            
            CGFloat width = width_str.doubleValue / height_str.doubleValue * (bodyview.glh_height - bodyview.titleLabel.glh_height - bodyview.desc1Label.glh_height);
            CGFloat left = i * width;
            
             // 设置scrollView的contentSize
            if (i == 0) {
                self.ScrollContentWidth.constant = self.viewModel.body.count * width + margin * (self.viewModel.body.count - 1);
            }
            [self layoutIfNeeded];
            ((UIScrollView *)self.contentSizeView.superview).showsHorizontalScrollIndicator = NO;
            [self.contentSizeView addSubview:bodyview];
            
            [bodyview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(bodyview.superview);
                make.width.equalTo(@(width));
                make.left.equalTo(@(left + margin * i));
            }];
            
            [[self.bodyView rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
                GLRecommedCellModel *cellM = self.viewModel.cellbodyItemViewModels[i];
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"点击了%@\n跳转%@",cellM.title,cellM.param]];
            }];
            
//            NSLog(@"~~~~~~%f===%f",width,left);
//            NSLog(@"????%f",width);
            
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
