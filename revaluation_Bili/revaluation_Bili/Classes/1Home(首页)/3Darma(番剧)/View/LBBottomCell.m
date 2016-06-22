//
//  LBBottomCell.m
//  Bili
//
//  Created by 林彬 on 16/5/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBBottomCell.h"
#import "LBDarmaBottomModel.h"
@interface LBBottomCell()

@property (weak, nonatomic) IBOutlet UIImageView *BottomImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@end

@implementation LBBottomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(LBDarmaBottomModel *)model{
    _model = model;
    NSURL *url = [NSURL URLWithString:model.cover];
    [self.BottomImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholderImageX"] completed:nil];
    self.title.text = model.title;
    self.subtitle.text = model.desc;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    self.BottomImageView.height = ( ScreenW - 20 ) / 3; 
}


-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}



@end
