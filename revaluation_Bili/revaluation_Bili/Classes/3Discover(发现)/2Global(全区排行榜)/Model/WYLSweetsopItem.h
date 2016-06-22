//
//  WYLSweetsopItem.h
//  Bili
//
//  Created by 王亚龙 on 16/4/8.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYLSweetsopItem : NSObject

/*
 pic:图片
 title:
 author
 play nsnumber
 comment nsnumber
 */

/** 图片*/
@property (nonatomic ,strong) NSString *pic;

/** title*/
@property (nonatomic ,strong) NSString *title;

/** 作者*/
@property (nonatomic ,strong) NSString *author;

/** 播放数*/
@property (nonatomic ,strong) NSNumber *play;

/** 弹幕*/
@property (nonatomic ,strong) NSNumber *comment;


@end
