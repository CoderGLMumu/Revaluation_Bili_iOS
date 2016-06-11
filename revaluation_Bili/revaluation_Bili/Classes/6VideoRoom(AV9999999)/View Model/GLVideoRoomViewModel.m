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
- (void)loadLiveViewDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
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

#pragma mark - 处理网络请求数据
- (void)handleLiveViewData
{
    [self loadLiveViewDataSuccess:^(id json) {
//        pages 的cid	Number	4,554,594 用于请求 视频链接
        
        GLVideoRoomModel *RM = [GLVideoRoomModel yy_modelWithJSON:json[@"data"]];
        NSString *strurl = RM.pages[0][@"cid"];
        
        
        
        self.desc = RM.desc;
        self.pic = RM.pic;
        
        NSMutableArray * cellItemViewModels = [NSMutableArray array];
        self.cellArr = [NSArray yy_modelArrayWithClass:[GLVideoRoomModel class] json:json[@"data"][@"relates"]];
        
        RACSequence * newblogViewModels = [self.cellArr.rac_sequence
                                           map:^(GLVideoRoomItemViewModel * model) {
                                               GLVideoRoomItemViewModel * vm = [[GLVideoRoomItemViewModel alloc] initWithcellItemModel: model];
                                               
                                               return vm;
                                           }];
        
        
        [cellItemViewModels addObjectsFromArray: newblogViewModels.array];
        
        self.cellItemViewModels = cellItemViewModels;
        
    } failure:^(NSError *error) {
        
    }];
}


@end
