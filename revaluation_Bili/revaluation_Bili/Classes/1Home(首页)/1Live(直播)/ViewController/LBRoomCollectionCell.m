//
//  LBRoomCollectionCell.m
//  Bili
//
//  Created by 林彬 on 16/4/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBRoomCollectionCell.h"
#import "LBRoomItem.h"

@interface LBRoomCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverView;

@property (weak, nonatomic) IBOutlet UIImageView *faceView;

@property (weak, nonatomic) IBOutlet UILabel *onlineNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation LBRoomCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.onlineNumberLabel.text = [self.roomItem.online stringValue];
        self.nameLabel.text = self.roomItem.owner[@"name"];
        self.titleLabel.text = self.roomItem.title;
        
        [self.coverView sd_setImageWithURL:[NSURL URLWithString:self.roomItem.cover[@"src"]]placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image == nil) return ;
            
            //        self.coverView.layer.cornerRadius = 10;
            //        self.coverView.layer.masksToBounds = YES;
            
            self.coverView.image = image;
        }];
        
        [self.faceView sd_setImageWithURL:[NSURL URLWithString:self.roomItem.owner[@"face"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image == nil) return ;
            
            // 带边框的图片裁剪
            UIImage *newImage = [UIImage imageWithBorder:5 color:[UIColor whiteColor] image:image];
            
            self.faceView.image = newImage;
        }];
    });
}

@end
