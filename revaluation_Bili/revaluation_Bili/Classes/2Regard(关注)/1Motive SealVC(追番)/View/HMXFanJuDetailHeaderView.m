//
//  HMXFanJuDetailHeaderView.m
//  Bili
//
//  Created by hemengxiang on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "HMXFanJuDetailHeaderView.h"
#import "GLMotiveSealCellItem.h"

//#import <UIImageView+WebCache.h>

@interface HMXFanJuDetailHeaderView()
/** 视频图片 */
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
/** 视频标题 */
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
/** 上次观看的到多少集 */
@property (weak, nonatomic) IBOutlet UILabel *last_ep_countLabel;
/** 总集数 */
@property (weak, nonatomic) IBOutlet UILabel *total_countLabel;
/** 选集 */
@property (weak, nonatomic) IBOutlet UILabel *select_total_countLabel;
/** 背景图片 */
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property(nonatomic,weak)UIToolbar *toolBar;


@end
@implementation HMXFanJuDetailHeaderView


-(void)awakeFromNib
{
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    
    toolBar.barStyle = UIBarStyleBlack;
    
    self.toolBar = toolBar;
    
    [self.backImageView insertSubview:toolBar atIndex:0];
}

//布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.toolBar.frame = self.backImageView.bounds;
}

-(void)setMotiveSealItem:(GLMotiveSealCellItem *)motiveSealItem
{
    _motiveSealItem = motiveSealItem;
    
    //图片
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:motiveSealItem.cover] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //裁剪原始图片的尺寸
        UIImage *scaledImage = [UIImage originImage:image scaleToSize:self.coverImageView.gls_size];
        self.coverImageView.image = scaledImage;
        
        //设置背景图片
        self.backImageView.image = scaledImage;
        
    }];
    
    
    
    //标题
    [self.titleButton setTitle:motiveSealItem.title forState:UIControlStateNormal];
    
    //上次观看到多少集
    NSInteger last_ep_count = self.motiveSealItem.last_ep_index.integerValue;
    self.last_ep_countLabel.text = [NSString stringWithFormat:@"第 %zd 话",last_ep_count];
    
    //总集数
    NSInteger total_count = self.motiveSealItem.total_count.integerValue;
    self.total_countLabel.text = [NSString stringWithFormat:@"全 %zd 话",total_count];
    //选集
    self.select_total_countLabel.text = [NSString stringWithFormat:@"选集(%zd)",total_count];
}

@end