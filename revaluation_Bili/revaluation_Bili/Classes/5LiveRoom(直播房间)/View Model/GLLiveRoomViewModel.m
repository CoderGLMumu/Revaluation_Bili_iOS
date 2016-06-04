//
//  GLLiveRoomViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveRoomViewModel.h"

@implementation GLLiveRoomViewModel

static GLLiveRoomViewModel *_instance;

- (GLLiveRoomModel *)liveRoomDataModel
{
    if (_liveRoomDataModel == nil) {
        _liveRoomDataModel = [[GLLiveRoomModel alloc] init];
    }
    return _liveRoomDataModel;
}

- (void)handleVCToVMDataonline:(NSString *)online face:(NSString *)face
{
    self.liveRoomDataModel.face = face;
    self.liveRoomDataModel.online = online;
}

+ (void)setUpHeaderView:(UIView *)headerView complete:(void(^)())complete
{

    headerView.backgroundColor = [UIColor whiteColor];
    
    complete();
}

+ (void)setUpFooterView:(UIView *)footerView complete:(void(^)())complete
{
    
    footerView.backgroundColor = [UIColor orangeColor];
    
    complete();
}

#pragma mark - 网络请求json数据
- (void)loadLiveViewDataWithRoom_id:(NSString *)room_id Success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
//    http://live.bilibili.com/api/room_info?_device=iphone&_hwid=234af756f0fca4b4&_ulv=10000&access_key=aa769b7fbfadf8a43d209a567792b1f7&appkey=27eb53fc9058f8c3&appver=3220&build=3220&buld=3220&platform=ios&room_id=48499&type=json&sign=6afad619d1d6c703918b2b9d6584ad7a
    
    // 使用请求参数 发送网络请求
    NSString *url = @"http://live.bilibili.com/live/getInfo";
    NSDictionary *dictM = @{
                            @"roomid":room_id,
                            };
    // 调用网络请求工具类
    
    [HttpToolSDK getWithURL:url parameters:dictM success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 网络请求html数据
- (void)loadLiveViewHTMLDataWithRoom_id:(NSString *)room_id Success:(void (^)(id string))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = [NSString stringWithFormat:@"http://live.bilibili.com/%@",room_id];

    // 调用网络请求工具类
    [HttpToolSDK getHTMLDataWithURL:url parameters:nil success:^(id string) {
        
        if (success) {
            success(string);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    //    http://live.bilibili.com/11783
}

#pragma mark - 网络请求html数据
- (void)loadLiveViewPlayerURLWithRoom_id:(NSString *)room_id Success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = [NSString stringWithFormat:@"http://live.bilibili.com/api/playurl?cid=%@&player=0&quality=0",room_id];
    
    // 调用网络请求工具类
    [HttpToolSDK getHTMLDataWithURL:url parameters:nil success:^(id string) {
//        NSLog(@"success - - %@",success);
        if (success) {
//            NSLog(@"testsuccessstring");
            success(string);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    //    http://live.bilibili.com/11783
}

#pragma mark - 处理网络请求数据
- (void)handleLiveViewDataWithRoom_id:(NSString *)room_id Success:(void (^)())success Failure:(void (^)())failure
{
    
    __weak typeof(self)weakSelf = self;
    
    [weakSelf loadLiveViewDataWithRoom_id:room_id Success:^(id json) {

        weakSelf.liveRoomDataModel = [GLLiveRoomModel yy_modelWithJSON:json[@"data"]];
//        NSLog(@"weakSelf.liveRoomDataModel-- %@",weakSelf.liveRoomDataModel);
        
        //        success();
    } failure:^(NSError *error) {
        //        failure();
    }];
    
    
    [weakSelf loadLiveViewHTMLDataWithRoom_id:room_id Success:^(id string) {
//        NSLog(@"testtest");
        
        /** 拼接 房间的标签 tags */
        NSString *str_start = @" tags=\"";
        NSUInteger location = [string rangeOfString:str_start].location + str_start.length;
        
        NSUInteger length = [string rangeOfString:@"\"><span class=\"item\""].location - location;
        NSRange range = NSMakeRange(location, length);
        NSString *newStr = [string substringWithRange:range];
        
        NSArray *tags = [newStr componentsSeparatedByString:@","];
        weakSelf.liveRoomDataModel.tags = tags;
        
        /** 拼接 房间的公告 des */
        str_start = @"\"roomIntro\">";
        location = [string rangeOfString:str_start].location + str_start.length;
        
        length = [string rangeOfString:@"<!-- Recommend Videos"].location - location;
        range = NSMakeRange(location, length);
        newStr = [string substringWithRange:range];
        
        weakSelf.liveRoomDataModel.des = newStr;
//        NSLog(@"weakSelf.liveRoomDataModel.des - %@",weakSelf.liveRoomDataModel.des);
        success();
    } failure:^(NSError *error) {
        failure();
    }];
    
    [weakSelf loadLiveViewPlayerURLWithRoom_id:room_id Success:^(id json) {
//        NSLog(@"json-%@",json);
        
        /** 截取直播视频的URL */
        NSString *str_start = @"<url><![CDATA[";
        NSUInteger location = [json rangeOfString:str_start].location + str_start.length;
        
        NSUInteger length = [json rangeOfString:@"]]></url>"].location - location;
        NSRange range = NSMakeRange(location, length);
        NSString *URL_str = [json substringWithRange:range];
        weakSelf.liveRoomDataModel.URL = URL_str;
//         NSLog(@"URL==-%@",weakSelf.liveRoomDataModel.URL);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

+ (void)cancelloadLiveViewDataAtComplete:(void(^)())complete
{
    [HttpToolSDK cancelAllRequest];
    complete();
}

- (void)dealloc
{
//    NSLog(@"RommVMdealooc");
}

//类方法
+ (instancetype)viewModel
{
    //注意：这里建议使用self
    
    return [[self alloc]init];
}

@end
