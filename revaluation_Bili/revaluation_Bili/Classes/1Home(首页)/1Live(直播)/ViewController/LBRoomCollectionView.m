




//
//  LBRoomCollectionView.m
//  Bili
//
//  Created by 林彬 on 16/4/19.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "LBRoomCollectionView.h"

@implementation LBRoomCollectionView

// 确定collectionView各个cell的间距
static CGFloat const margin = 10;

- (instancetype)initWithItem:(CGFloat)itemW :(CGFloat)itemH
{
    // 新建流水布局
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置尺寸
    flowL.itemSize = CGSizeMake(itemW, itemH);
    
    // 设置最小列间距和行间距
    flowL.minimumInteritemSpacing = margin;
    flowL.minimumLineSpacing = margin;
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.scrollsToTop = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    
    return [self initWithFrame:CGRectZero collectionViewLayout:flowL];
}

@end
