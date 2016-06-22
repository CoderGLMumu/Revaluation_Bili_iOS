//
//  GLPartitionViewCell.m
//  Bili
//
//  Created by mac on 16/4/23.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLPartitionViewCell.h"
#import "GLPartitionItem.h"

@interface GLPartitionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pic_ImageView;
@property (weak, nonatomic) IBOutlet UILabel *name_Label;

@end

@implementation GLPartitionViewCell

- (void)setItem:(GLPartitionItem *)item
{
    _item = item;
    
    UIImage *image = [UIImage originImage:item.image scaleToSize:CGSizeMake(35, 35)];
    
    self.pic_ImageView.image = image;
    self.name_Label.text = item.name_image;
}

@end
