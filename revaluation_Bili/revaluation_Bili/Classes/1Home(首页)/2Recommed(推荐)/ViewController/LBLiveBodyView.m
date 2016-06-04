

//
//  LBLiveBodyView.m
//  Bili
//
//  Created by 林彬 on 16/5/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBLiveBodyView.h"
#import "LBBodyModel.h"
@interface LBLiveBodyView()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageV;

@property (weak, nonatomic) IBOutlet UIImageView *upfaceImageV;

@property (weak, nonatomic) IBOutlet UILabel *up;


@property (weak, nonatomic) IBOutlet UILabel *online;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation LBLiveBodyView

+(instancetype)LBLiveBodyViewFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LBLiveBodyView" owner:self options:nil] lastObject];
}

-(void)layoutSubviews{
    [super layoutSubviews];

}

-(void)setBodyItem:(LBBodyModel *)bodyItem
{
    _bodyItem = bodyItem;
    NSURL *cover = [NSURL URLWithString:_bodyItem.cover];
    NSURL *upFace = [NSURL URLWithString:_bodyItem.up_face];
    [self.coverImageV sd_setImageWithURL:cover placeholderImage:[UIImage imageNamed:@"placeholderImageX"]];
    [self.upfaceImageV sd_setImageWithURL:upFace placeholderImage:[UIImage imageNamed:@"placeholderImageX"]];
    
    self.title.text = _bodyItem.title;
    
    self.up.text = _bodyItem.up;
    
    self.online.text = _bodyItem.online.stringValue;
    
}
@end
