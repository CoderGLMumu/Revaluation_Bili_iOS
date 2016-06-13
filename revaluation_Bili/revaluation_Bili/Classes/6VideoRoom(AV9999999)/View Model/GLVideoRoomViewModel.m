//
//  GLVideoRoomViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLVideoRoomViewModel.h"

#import "GLVideoRoomItemViewModel.h"

#import "GLVideoRoomModel.h"

@interface GLVideoRoomViewModel ()

/** 用于判断cell类型 */
//@property (nonatomic, strong) NSString *head;

// 保存cell的模型数组
@property (nonatomic ,strong)NSArray *cellArr;

/** 用于请求页面数据的唯一id */
@property (nonatomic, strong) NSString *aid;
/** 用于请求视频播放id */
@property (nonatomic, strong) NSString *cid;

@end

@implementation GLVideoRoomViewModel

- (instancetype)initWithAid:(NSString *)aid
{
    self = [super init];
    if (self) {
        self.aid = aid;
        [self handleLiveViewData];
        
    }
    return self;
}

/**
 *  和数据模型无关的初始化设置,放到独立的方法中.
 */

#pragma mark - 网络请求数据
- (void)loadVideoRoomDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = [NSString stringWithFormat:@"http://app.bilibili.com/x/view?access_key=aa769b7fbfadf8a43d209a567792b1f7&actionKey=appkey&aid=%@&appkey=27eb53fc9058f8c3&build=3220&device=phone&plat=0&platform=ios",self.aid];
    
    // 调用网络请求工具类
    [HttpToolSDK getWithURL:url parameters:nil success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)loadVideoLinkDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = [NSString stringWithFormat:@"http://interface.bilibili.com/playurl?platform=android&_device=android&_hwid=831fc7511fa9aff5&_tid=0&_p=1&_down=0&quality=2&otype=json&appkey=86385cdc024c0f6c&type=mp4&sign=7fed8a9b7b446de4369936b6c1c40c3f&cid=%@",self.cid];
    
    // 调用网络请求工具类
    [HttpToolSDK getWithURL:url parameters:nil success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 处理网络请求数据
- (void)handleLiveViewData
{
    [self loadVideoRoomDataSuccess:^(id json) {
//        pages 的cid	Number	4,554,594 用于请求 视频链接
        
        GLVideoRoomModel *RM = [GLVideoRoomModel yy_modelWithJSON:json[@"data"]];
//        NSString *strurl = RM.pages[0][@"cid"];
        self.cid = ((NSNumber *)RM.pages[0][@"cid"]).stringValue;
        self.aid_str = [NSString stringWithFormat:@"AV%@",self.aid];
        self.title = RM.title;
//        NSLog(@"%@``%@",self.view,[self.view class]);
        self.view = ((NSNumber *)RM.stat[@"view"]).stringValue;
        
        self.danmaku = ((NSNumber *)RM.stat[@"danmaku"]).stringValue;
        self.desc = RM.desc;
        self.share = ((NSNumber *)RM.stat[@"share"]).stringValue;
        self.coin = ((NSNumber *)RM.stat[@"coin"]).stringValue;
        self.favorite = ((NSNumber *)RM.stat[@"favorite"]).stringValue;
        self.reply = ((NSNumber *)RM.stat[@"reply"]).stringValue;
        self.face_str = RM.owner[@"face"];
        self.name = RM.owner[@"name"];
        self.pubdate = RM.pubdate.stringValue;
        self.total = ((NSNumber *)RM.elec[@"total"]).stringValue;
        self.count = ((NSNumber *)RM.elec[@"count"]).stringValue;
        
//        self.pic = RM.pic;
        
        NSMutableArray * cellItemViewModels = [NSMutableArray array];
        self.cellArr = [NSArray yy_modelArrayWithClass:[GLVideoRoomModel class] json:json[@"data"][@"relates"]];
        
        RACSequence * newblogViewModels = [self.cellArr.rac_sequence
                                           map:^(GLVideoRoomItemViewModel * model) {
                                               GLVideoRoomItemViewModel * vm = [[GLVideoRoomItemViewModel alloc] initWithcellItemModel: model];
                                               
                                               return vm;
                                           }];
        
        
        [cellItemViewModels addObjectsFromArray: newblogViewModels.array];
        
        self.cellItemViewModels = cellItemViewModels;
        
        
        /** 请求成功后拿到cid 去请求视频链接 */
        [self loadVideoLinkDataSuccess:^(id json) {
            
            self.videoLink = json[@"durl"][0][@"url"];
        } failure:^(NSError *error) {
            
        }];
    } failure:^(NSError *error) {
        
    }];
}


@end
