//
//  WYLDiscoverCell.m
//  Bili
//
//  Created by 王亚龙 on 16/4/10.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "WYLDiscoverCell.h"

@implementation WYLDiscoverCell

- (void)awakeFromNib {

    if (self.tag == 1) {//兴趣圈
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xingququan_icon_11"]];
    }else
    {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_right_arrow"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
