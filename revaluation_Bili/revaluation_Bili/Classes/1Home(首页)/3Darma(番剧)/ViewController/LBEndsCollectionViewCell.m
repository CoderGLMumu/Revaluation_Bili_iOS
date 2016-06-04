//
//  LBEndsCollectionViewCell.m
//  Bili
//
//  Created by 林彬 on 16/5/18.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBEndsCollectionViewCell.h"
#import "LBDarmaEndsModel.h"
@interface LBEndsCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation LBEndsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(LBDarmaEndsModel *)model{
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.cover]placeholderImage:[UIImage imageNamed:@"placeholderImage1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return ;
        
        //        self.coverView.layer.cornerRadius = 10;
        //        self.coverView.layer.masksToBounds = YES;
        
        self.imageView.image = image;
    }];
    
    self.title.text = _model.title;
    self.subTitle.text = [NSString stringWithFormat:@"%@话全",_model.total_count];
    
}

@end
