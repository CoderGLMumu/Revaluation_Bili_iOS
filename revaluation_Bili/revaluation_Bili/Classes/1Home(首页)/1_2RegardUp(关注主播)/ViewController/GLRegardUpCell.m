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
@property (weak, nonatomic) IBOutlet UIView *infoView;

/** pretag_btn */
@property (nonatomic, weak) UIButton *pretag_btn;

/** 根据返回的标签数组-数量 动态添加 标签 */
@property (nonatomic, strong) NSArray *roomTags;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagsHeightConstraint;


@end

@implementation GLRegardUpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.faceImageView.layer.cornerRadius = self.faceImageView.glh_height * 0.5;
    self.faceImageView.clipsToBounds = YES;
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
        [self.tagsView removeFromSuperview];
    }else{
        
        self.pretag_btn = nil;
        
        for (UIView *btn in self.tagsView.subviews) {
            [btn removeFromSuperview];
        }
        [self addSubview:self.tagsView];
        
        CGFloat left = 0;
        
        int margin = 10;
        
        for (int i = 0; i < model.roomTags.count; ++i) {
            NSString *tag_str =  model.roomTags[i];
            UIButton *tag_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.tagsView addSubview:tag_btn];
            [tag_btn setTitle:tag_str forState:UIControlStateNormal];
            [tag_btn setTitleColor:GLColor(55, 55, 55) forState:UIControlStateNormal];
            
            tag_btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
            
            [tag_btn setFont:[UIFont systemFontOfSize:13]];
            [tag_btn sizeToFit];
            
            tag_btn.layer.cornerRadius = 8;
            tag_btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
            tag_btn.layer.borderWidth = 1;
            
            left += self.pretag_btn.glw_width;
            
//            CGFloat left = i * tag_btn.glw_width;
//            NSLog(@"leftleft%f===%f==%@",left,self.pretag_btn.glw_width,tag_btn.currentTitle);
//            tag_btn.backgroundColor = GLColor(0, 255, 255);
            [tag_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(tag_btn.superview);
                make.left.equalTo(@(left + i * margin));
                make.width.equalTo(@(tag_btn.glw_width));
            }];
            self.pretag_btn = tag_btn;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.model.roomTags.count == 0) {
        
    }else{
        [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.infoView);
            make.top.equalTo(self.infoView.mas_bottom).offset(5);
            make.bottom.equalTo(self.faceImageView.mas_bottom);
            make.height.equalTo(@(self.faceImageView.glh_height * 0.3)).priority(500);
        }];
    }
}

- (void)setFrame:(CGRect)frame  //【后调用】
{   //在返回cell高度的情况下给cell高度减一,tableView得到消息后高度减一
    frame.size.height -= 1;
    // 给cellframe赋值
    [super setFrame:frame];
}

@end
