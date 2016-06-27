//
//  GLRecBodyView.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecBodyView.h"

@interface GLRecBodyView ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *danmakuButton;


@end

@implementation GLRecBodyView

+ (instancetype)GLRecBodyViewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GLRecBodyView" owner:self options:nil] lastObject];
}

- (void)setBody:(NSDictionary *)body
{
    _body = body;
    
//    NSNumber *onlineText = body[@"online"];
    
    [self.danmakuButton setTitle:body[@"danmaku"] forState:UIControlStateNormal];
    [self.playButton setTitle:body[@"play"] forState:UIControlStateNormal];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:body[@"cover"]] placeholderImage:[UIImage imageNamed:@"placeholderImage1"]];
    self.titleLabel.text = body[@"title"];
}

@end
