//
//  GLPublishedPassTime.h
//  Bili
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLPublishedPassTime : NSObject

/**  【若要计算ss秒,请修改工具类】
 
 *  根据传入的字符串 @"2015-06-29 07:05" [计算差值result=当前时间-发时间]
 *
 *  @param str_time 传入时间
 *
 *  @return 距离传入时间过去了多长时间
 */
+ (NSString *)PublishedPassTime:(NSString *)str_time;

/**
 *  @return 返回单例对象
 */
+ (instancetype)sharePublishedPassTime;

/**
 *  [passTimes_str=当前时间-发布时间]
 *
 *  @param str_time      传入时间
 *  @param passTimes_str 过去了多长时间
 *
 *  @return 过去了多长时间
 */
- (void)PublishedPassTimeWithTimeNSString:(NSString *)str_time result:(void(^)(NSString *passTimes_str))passTimes_str;

/** 计算结果 - passTimes_str */
@property (nonatomic, strong) NSString *passTimes_str;

/**
 *  block中传入str_time发布时间,结果保存在passTimes_str属性中
 */
- (GLPublishedPassTime *(^)(NSString *str_time))passTime;

@end
