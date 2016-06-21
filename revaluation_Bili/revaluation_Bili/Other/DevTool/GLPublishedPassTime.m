//
//  GLPublishedPassTime.m
//  Bili
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLPublishedPassTime.h"

@implementation GLPublishedPassTime

+ (NSString *)PublishedPassTime:(NSString *)str_time
{
    //获得服务器返回时间[发布时间]
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//    @"yyyy-MM-dd HH:mm:ss Z"; 完整例子 @"2015-06-29 07:05:26 +0000";
    NSDate *date = [formatter dateFromString:str_time];
    
    //获得当前的时间
    NSDate *now = [NSDate date];
    
    /** 计算时间差值 */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:date toDate:now options:0];
    //    NSLog(@" result ====  %ld年%ld月%ld日%ld小时%ld分钟%ld秒钟", (long)cmps.year, (long)cmps.month, (long)cmps.day, (long)cmps.hour, (long)cmps.minute, (long)cmps.second);
    
    if (cmps.year != 0) {
        return [NSString stringWithFormat:@"%ld年前",cmps.year];
    }else if (cmps.month != 0){
        return [NSString stringWithFormat:@"%ld月前",cmps.month];
    }else if (cmps.day != 0){
        return [NSString stringWithFormat:@"%ld天前",cmps.day];
    }else if (cmps.hour != 0){
        return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
    }else if (cmps.hour != 0){
        return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
    }else{
        return @"刚刚";
    }
    return @"";
}

static GLPublishedPassTime *_instance;
/** 返回单例 */
+ (instancetype)sharePublishedPassTime
{
    return [[self alloc]init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    }
    
    return _instance;
}

- (void)PublishedPassTimeWithTimeNSString:(NSString *)str_time result:(void(^)(NSString *passTimes_str))passTimes_str
{
    
    //获得服务器返回时间[发布时间]
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    //    @"yyyy-MM-dd HH:mm:ss Z"; 完整例子 @"2015-06-29 07:05:26 +0000";
    NSDate *date = [formatter dateFromString:str_time];
    
    //获得当前的时间
    NSDate *now = [NSDate date];
    
    /** 计算时间差值 */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:date toDate:now options:0];
    
    if (cmps.year != 0) {
        _passTimes_str = [NSString stringWithFormat:@"%ld年前",cmps.year];
    }else if (cmps.month != 0){
        _passTimes_str = [NSString stringWithFormat:@"%ld月前",cmps.month];
    }else if (cmps.day != 0){
        _passTimes_str = [NSString stringWithFormat:@"%ld天前",cmps.day];
    }else if (cmps.hour != 0){
        _passTimes_str = [NSString stringWithFormat:@"%ld小时前",cmps.hour];
    }else if (cmps.hour != 0){
        _passTimes_str = [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
    }else{
        _passTimes_str = @"刚刚";
    }

    passTimes_str(_passTimes_str);
}

- (GLPublishedPassTime *(^)(NSString *))passTime
{
    return ^(NSString *str_time){
        
        //获得服务器返回时间[发布时间]
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        //    @"yyyy-MM-dd HH:mm:ss Z"; 完整例子 @"2015-06-29 07:05:26 +0000";
        NSDate *date = [formatter dateFromString:str_time];
        
        //获得当前的时间
        NSDate *now = [NSDate date];
        
        /** 计算时间差值 */
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSCalendarUnit type = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        NSCalendarUnitSecond;
        NSDateComponents *cmps = [calendar components:type fromDate:date toDate:now options:0];
        
        if (cmps.year != 0) {
            _passTimes_str = [NSString stringWithFormat:@"%ld年前",cmps.year];
        }else if (cmps.month != 0){
            _passTimes_str = [NSString stringWithFormat:@"%ld月前",cmps.month];
        }else if (cmps.day != 0){
            _passTimes_str = [NSString stringWithFormat:@"%ld天前",cmps.day];
        }else if (cmps.hour != 0){
            _passTimes_str = [NSString stringWithFormat:@"%ld小时前",cmps.hour];
        }else if (cmps.hour != 0){
            _passTimes_str = [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
        }else{
            _passTimes_str = @"刚刚";
        }
        return self;
    };
}

@end
