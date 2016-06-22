//
//  LBLatestUpdateCell.m
//  Bili
//
//  Created by 林彬 on 16/5/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBLatestUpdateCell.h"
#import "LBLUBodayView.h"
#import "LBDarmaLatestUpdateModel.h"

@interface LBLatestUpdateCell()

@property (weak, nonatomic) IBOutlet UIView *middleView;

@end

@implementation LBLatestUpdateCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModels:(NSMutableArray *)models{
    _models = models;
    
    
    // 列
    NSInteger col = 2;
    // 列间距
    NSInteger colSpace = 10;
    // 行间距
    NSInteger rowSpace = 15;
    
    for (int i = 0; i < 6; i ++) {
        LBLUBodayView *bodyView = [LBLUBodayView BodayViewFromNib];
        bodyView.model = _models[i];
        
        CGFloat bodyW = (GLScreenW - 30) * 0.5;
        CGFloat bodyH = ((GLScreenW - 30) * 0.5) * 128/ 234 + 45;
        
        // 动态计算中间view的高度
        CGFloat middleVH = rowSpace * 3 + bodyH * 3;
        self.middleView.frame = CGRectMake(0, 40, GLScreenW, middleVH);
        

        CGFloat bodyX = i % col * bodyW + (i % col + 1) * colSpace;
        CGFloat bodyY = i / col * bodyH + (i / col + 1) * rowSpace;
        bodyView.frame = CGRectMake(bodyX, bodyY, bodyW, bodyH);
        [self.middleView addSubview:bodyView];
        
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
   
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
