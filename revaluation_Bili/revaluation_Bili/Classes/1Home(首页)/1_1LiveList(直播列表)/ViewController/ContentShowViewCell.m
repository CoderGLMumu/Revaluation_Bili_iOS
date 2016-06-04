//
//  CleverCollectionViewCell.m
//  BiLiBil 二级展示界面
//
//  Created by sunny on 16/3/28.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "ContentShowViewCell.h"
#import "BiLiTwoLevelAllPlayingItem.h"
#import "BiLiTwoLevelCoverItem.h"
#import "BiLiTwoLevelOwnerItem.h"
@interface ContentShowViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UIImageView *srcImageView;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;


@end

@implementation ContentShowViewCell

- (void)setAllPlayingItem:(BiLiTwoLevelAllPlayingItem *)allPlayingItem
{
    _allPlayingItem = allPlayingItem;
    
    [self.faceImageView sd_setImageWithURL:[NSURL URLWithString:allPlayingItem.owner.face] placeholderImage:[UIImage imageNamed:@"avatar_default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return ;//图片下载失败
        
//        开启图形上下文
        UIGraphicsBeginImageContext(self.faceImageView.gls_size);
//        设置裁剪路径
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.faceImageView.bounds];
        [path addClip];
//        画图
        [self.faceImageView.image drawInRect:self.faceImageView.bounds];
//       获取新图片
        self.faceImageView.image = UIGraphicsGetImageFromCurrentImageContext();
//        关闭图形上下文
        UIGraphicsEndImageContext();
        
    }];
    
    self.nameLabel.text = allPlayingItem.owner.name;
    self.title_label.text = allPlayingItem.title;
    [self.srcImageView sd_setImageWithURL:[NSURL URLWithString:allPlayingItem.cover.src] placeholderImage:[UIImage imageNamed:@"default_img"]];
    
    if (allPlayingItem.online > 10000) {
        self.onlineLabel.text = [NSString stringWithFormat:@"%.1f万",allPlayingItem.online / 10000.0];
    } else {
        self.onlineLabel.text = [NSString stringWithFormat:@"%zd",allPlayingItem.online];
    }
}

@end
