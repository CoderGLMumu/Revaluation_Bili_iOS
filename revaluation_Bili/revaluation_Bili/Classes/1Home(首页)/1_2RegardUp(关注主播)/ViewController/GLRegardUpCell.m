//
//  GLRegardUpCell.m
//  revaluation_Bili
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRegardUpCell.h"
#import "GLRegardUpModel.h"

@interface GLRegardUpCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UIView *live_statusView;
@property (weak, nonatomic) IBOutlet UILabel *areaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansNumLabel;
@property (weak, nonatomic) IBOutlet UIView *tagsView;

/** 根据返回的标签数组-数量 动态添加 标签 */
@property (nonatomic, strong) NSArray *roomTags;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsHeightConstraint;


@end

@implementation GLRegardUpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(GLRegardUpModel *)model
{
    _model = model;
    self.nameLabel.text = model.name;
    [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    if (model.live_status.intValue == 0) {
        self.live_statusView.backgroundColor = GLColorA(170, 170, 170, 1);
        [(UILabel *)self.live_statusView.subviews[0] setText:@"闲置中"];
    }else{
        self.live_statusView.backgroundColor = GLColorA(255, 29, 174, 1);
        [(UILabel *)self.live_statusView.subviews[0] setText:@"直播中"];
    }
    self.areaNameLabel.text = model.areaName;
    self.fansNumLabel.text = [NSString stringWithFormat:@"%ld",(long)model.fansNum.integerValue];
    
    if (model.roomTags.count == 0) {
        self.tagsView.hidden = YES;
        self.tagsView.alpha = 0;
//        self.tagsHeightConstraint.multiplier = 0;
    }else{
        self.tagsView.hidden = NO;
        self.tagsView.alpha = 1;
//        self.tagsHeightConstraint.constant = 0;
    }
}

@end
