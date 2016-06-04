//
//  LBLUBodayView.m
//  Bili
//
//  Created by 林彬 on 16/5/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBLUBodayView.h"
#import "LBDarmaLatestUpdateModel.h"

@interface LBLUBodayView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation LBLUBodayView

- (IBAction)pushClick:(id)sender {
    
}

+(instancetype)BodayViewFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"LBLUBodayView" owner:self options:nil] lastObject];
}

-(void)setModel:(LBDarmaLatestUpdateModel *)model
{
    _model = model;
    NSURL *url = [NSURL URLWithString:_model.cover];
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderImageX"]];
    self.mainTitle.text = model.title;
    // 时间还没做.
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat bodyW = (GLScreenW - 30) * 0.5;
    CGFloat bodyH = ((GLScreenW - 30) * 0.5) * 128/ 234 + 45;
    
    self.bounds = CGRectMake(0, 0, bodyW, bodyH);
}

@end
