//
//  LBBangumiBodyView.m
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBBangumiBodyView.h"
#import "LBBodyModel.h"
@interface LBBangumiBodyView()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageV;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *desc1;

@end
@implementation LBBangumiBodyView


+(instancetype)LBBangumiBodyViewFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LBBangumiBodyView" owner:self options:nil] lastObject];
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
    NSURL *cover = [NSURL URLWithString:_bodyItem.cover];
    
    [self.coverImageV sd_setImageWithURL:cover placeholderImage:[UIImage imageNamed:@"placeholderImageX"]];

    
    self.title.text = _bodyItem.title;
    
    self.desc1.text = _bodyItem.desc1;
    
}
@end
