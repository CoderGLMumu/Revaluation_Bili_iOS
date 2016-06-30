//
//  GLLiveListViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLLiveListViewModel.h"
#import "GLLiveListModel.h"

@interface GLLiveListViewModel ()

/** btn_titles */
@property (nonatomic, strong) NSMutableArray *btn_titles;

@end

@implementation GLLiveListViewModel

- (NSMutableArray *)btn_titles
{
    if (_btn_titles == nil) {
        _btn_titles = [NSMutableArray array];
    }
    return _btn_titles;
}

#pragma mark - 网络请求数据
- (void)loadLiveViewDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = @"http://live.bilibili.com/mobile/tags?access_key=aa769b7fbfadf8a43d209a567792b1f7&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3220&device=phone&platform=ios&sign=7acfbb5f74e68c647bdb8e5d1bb292ec&ts=1464097273";
//    NSDictionary *dictM = @{
//                            @"actionKey":@"appkey",
//                            @"appkey":@"27eb53fc9058f8c3",
//                            @"build":@"3060",
//                            @"device":@"phone",
//                            @"platform":@"ios",
//                            @"scale":@"2",
//                            @"sign":@"13f053baf875521b0d1958c812a0f110",
//                            @"ts":@"1460106665"
//                            };
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

#warning 需要请求数据,处理数据并传递数组出去 btn_titles 去掉属性 【area_id】 需要处理缓存

#pragma mark - 处理网络请求数据
- (void)handleLiveViewDataWithListID:(int)listID success:(void (^)(NSArray *btn_titles))success Failure:(void (^)(NSArray *btn_titles))failure
{
    if (listID == 8) {
        [self.btn_titles insertObject:@"全部" atIndex:0];
        success(self.btn_titles);
    }else{
        [self loadLiveViewDataSuccess:^(id json) {
            
            if (json) {
                NSDictionary *dictM = json[@"data"];
                NSArray *arrM = dictM.allKeys;
                
                for (id key in arrM) {
                    NSString *keyValue = (NSString *)key;
                    if (keyValue.integerValue == listID) {
                        [self.btn_titles removeAllObjects];
                        
                        [self.btn_titles addObjectsFromArray:dictM[key]];
                        
                        [self.btn_titles insertObject:@"全部" atIndex:0];
                        success(self.btn_titles);
                    }
                }
            }
            
        } failure:^(NSError *error) {
            if (self.btn_titles.count == 0) {
                [self.btn_titles insertObject:@"全部" atIndex:0];
            }
            failure(self.btn_titles);
        }];
    }
}

//类方法，返回viewModel
+ (instancetype)viewModel
{
    //注意：这里建议使用self
    
    return [[self alloc]init];
}

-(void)dealloc
{
    NSLog(@"listVMdeinit");
}


@end
