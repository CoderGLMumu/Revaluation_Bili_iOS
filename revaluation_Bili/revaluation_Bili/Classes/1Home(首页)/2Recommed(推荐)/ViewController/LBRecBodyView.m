//
//  LBRecBodyView.m
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBRecBodyView.h"
#import "LBBodyModel.h"
@interface LBRecBodyView()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageV;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIButton *playCount;

@property (weak, nonatomic) IBOutlet UIButton *danmaku;

@end

@implementation LBRecBodyView

+(instancetype)LBRecBodyViewFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LBRecBodyView" owner:self options:nil] lastObject];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat bodyW = (GLScreenW - 30) * 0.5;
    CGFloat bodyH = ((GLScreenW - 30) * 0.5) * 128/ 234 + 35 + 17;

    self.bounds = CGRectMake(0, 0, bodyW, bodyH);
}

-(void)setBodyItem:(LBBodyModel *)bodyItem
{
    _bodyItem = bodyItem;
    NSURL *url = [NSURL URLWithString:_bodyItem.cover];
    [self.coverImageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderImageX"]];
    self.title.text = _bodyItem.title;
    [self.playCount setTitle:_bodyItem.play forState:UIControlStateNormal];
    [self.danmaku setTitle:_bodyItem.danmaku forState:UIControlStateNormal];
    
    
}

@end
