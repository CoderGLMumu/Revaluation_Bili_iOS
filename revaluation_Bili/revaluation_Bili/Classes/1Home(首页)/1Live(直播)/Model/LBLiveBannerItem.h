//
//  LBLiveBannerItem.h
//  Bili
//
//  Created by 林彬 on 16/4/20.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBLiveBannerItem : NSObject
@property(nonatomic , strong)NSString *img;
@property(nonatomic , strong)NSString *link;
@property(nonatomic , strong)NSString *title;
@property(nonatomic , strong)NSString *remark;

@property(nonatomic , assign)CGFloat bannerHeight;
@end
