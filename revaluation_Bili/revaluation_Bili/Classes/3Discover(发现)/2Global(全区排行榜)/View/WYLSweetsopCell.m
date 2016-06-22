//
//  WYLSweetsopCell.m
//  Bili
//
//  Created by 王亚龙 on 16/4/8.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLSweetsopCell.h"
//#import <UIImageView+WebCache.h>

#import "WYLSweetsopItem.h"
@interface WYLSweetsopCell()

//图片
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

//标题
@property (weak, nonatomic) IBOutlet UILabel *title;

//UP主
@property (weak, nonatomic) IBOutlet UILabel *UP;

//播放数
@property (weak, nonatomic) IBOutlet UILabel *play;

//弹幕
@property (weak, nonatomic) IBOutlet UILabel *barrage;
@end

@implementation WYLSweetsopCell

- (void)awakeFromNib {
    // Initialization code
//    NSLog(@"%@",NSStringFromCGRect(self.frame));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(WYLSweetsopItem *)item
{
    _item = item;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.pic] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    self.title.text = item.title;
    self.UP.text = item.author;
    //播放数
    if (item.play.floatValue > 10000.0) {
        self.play.text = [NSString stringWithFormat:@"%.1f万", item.play.floatValue / 10000.0];
    }else
    {
        self.play.text = [NSString stringWithFormat:@"%@", item.play];
    }
    //弹幕
    if (item.comment.floatValue > 10000.0) {
        self.barrage.text = [NSString stringWithFormat:@"%.1f万", item.comment.floatValue / 10000.0];
    }else
    {
        self.barrage.text = [NSString stringWithFormat:@"%@", item.comment];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10,10,116,75);
    float limgW =  self.imageView.image.size.width;
    if(limgW > 0) {
        self.textLabel.frame = CGRectMake(136,self.textLabel.frame.origin.y,self.textLabel.frame.size.width,self.textLabel.frame.size.height);
        self.detailTextLabel.frame = CGRectMake(136,self.detailTextLabel.frame.origin.y,self.detailTextLabel.frame.size.width,self.detailTextLabel.frame.size.height);
    }
    
//    NSLog(@"----------------%@",NSStringFromCGRect(self.frame));
}

@end
