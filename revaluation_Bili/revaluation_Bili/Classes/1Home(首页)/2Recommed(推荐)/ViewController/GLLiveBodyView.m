//
//  GLLiveBodyView.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveBodyView.h"

@interface GLLiveBodyView ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *up_faceImageView;
@property (weak, nonatomic) IBOutlet UILabel *upLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation GLLiveBodyView

+ (instancetype)GLLiveBodyViewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GLLiveBodyView" owner:self options:nil] lastObject];
}

- (void)setBody:(NSDictionary *)body
{
    _body = body;
    
    NSNumber *onlineText =body[@"online"];
    
    [self.up_faceImageView sd_setImageWithURL:[NSURL URLWithString:body[@"up_face"]] placeholderImage:[UIImage imageNamed:@"placeholderImage1"]];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:body[@"cover"]] placeholderImage:[UIImage imageNamed:@"placeholderImage1"]];
    self.titleLabel.text = body[@"title"];
    self.onlineLabel.text = onlineText.stringValue;
    self.upLabel.text = body[@"up"];
}

@end
