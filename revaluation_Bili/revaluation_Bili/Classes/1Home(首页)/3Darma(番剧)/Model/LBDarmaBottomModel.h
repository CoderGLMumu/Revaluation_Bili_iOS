//
//  LBDarmaBottomModel.h
//  Bili
//
//  Created by 林彬 on 16/5/17.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBDarmaBottomModel : NSObject
/* 图片URL **/
@property(nonatomic , strong)NSString *cover;
/* 描述 **/
@property(nonatomic , strong)NSString *desc;

/* 链接 **/
@property(nonatomic , strong)NSString *link;

/* 标题 **/
@property(nonatomic , strong)NSString *title;

@property(nonatomic , assign) CGFloat cellHeight;

@end
