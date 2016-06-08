//
//  GLBangumiBodyView.m
//  revaluation_Bili
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLBangumiBodyView.h"

@interface GLBangumiBodyView ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desc1Label;

@end

@implementation GLBangumiBodyView

+ (instancetype)GLBangumiBodyViewFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"GLBangumiBodyView" owner:self options:nil] lastObject];
}

- (void)setBody:(NSDictionary *)body
{
    _body = body;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:body[@"cover"]] placeholderImage:[UIImage imageNamed:@"placeholderImage1"]];
    self.titleLabel.text = body[@"title"];
    self.desc1Label.text = body[@"desc1"];
}

@end
