//
//  GLRecommedViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecommedViewModel.h"
#import "GLRecommedItemViewModel.h"

#import "GLRecommedModel.h"
#import "GLFMDBToolSDK.h"

@interface GLRecommedViewModel ()

/** 用于判断cell类型 */
@property (nonatomic, strong) NSString *head;

//@property (strong, nonatomic) AFHTTPRequestOperationManager * httpClient;

// 保存cell的模型数组
@property (nonatomic ,strong)NSArray *cellArr;

/** FMDBTool */
@property (nonatomic, strong) GLFMDBToolSDK *FMDBTool;

@end

@implementation GLRecommedViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self handleLiveViewData];
        
    }
    return self;
}

- (GLFMDBToolSDK *)FMDBTool
{
    if (_FMDBTool == nil) {
        _FMDBTool = [GLFMDBToolSDK shareToolsWithCreateDDL:nil];
    }
    return _FMDBTool;
}

/**
 *  和数据模型无关的初始化设置,放到独立的方法中.
 */

#pragma mark - 网络请求数据
- (void)loadLiveViewDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = @"http://app.bilibili.com/bangumi/operation_module?_device=android&_hwid=130a7709aeac1793&_ulv=10000&access_key=b938b895c8a7a0af574a6ae76f5631c8&appkey=c1b107428d337928&build=402003&module=index&platform=android&screen=xxhdpi&test=0&ts=1450884356000";
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

#pragma mark - 处理网络请求数据
- (void)handleLiveViewData
{
    [self loadLiveViewDataSuccess:^(id json) {
        
        NSMutableArray * cellItemViewModels = [NSMutableArray array];
        
        self.cellArr = [NSArray yy_modelArrayWithClass:[GLRecommedModel class] json:json[@"result"]];
        // 缓存t_GLRecommedModel数据
        /** FMDB缓存 */
        if (self.cellArr.count) {
            NSString *delete_sql = @"delete from t_GLRecommedModel";
            NSLog(@"delete from t_GLRecommedModel");
            [self.FMDBTool deleteWithSql:delete_sql];
            for (GLRecommedModel *model in self.cellArr) {
                //head blob, body blob, type TEXT
                NSString *insert_sql = [NSString stringWithFormat:@"insert into t_GLRecommedModel (head,body,type) values(?,?,'%@');",model.type];
                NSLog(@"test???????????????");
                [self.FMDBTool insertWithSql:insert_sql,[NSKeyedArchiver archivedDataWithRootObject:model.head],[NSKeyedArchiver archivedDataWithRootObject:model.body], nil];
            }
        }
        
        RACSequence * newblogViewModels = [self.cellArr.rac_sequence
                                           map:^(GLRecommedModel * model) {
                                                  GLRecommedItemViewModel * vm = [[GLRecommedItemViewModel alloc] initWithArticleModel: model];
                                               
                                               return vm;
                                           }];
        
        
        [cellItemViewModels addObjectsFromArray: newblogViewModels.array];
        
        self.cellItemViewModels = cellItemViewModels;
        
    } failure:^(NSError *error) {

    }];
}

#pragma mark - 处理数据库缓存- -【查询】
- (void)loadPhoneDataSourceToComplete:(void (^)())complete
{
    // 传入DDL 创建表打开数据库
    self.FMDBTool = [GLFMDBToolSDK shareToolsWithCreateDDL:nil];
    
    // 查询数据【banner】
    NSString *query_sql = @"select * from t_GLRecommedModel";
    
    FMResultSet *result = [self.FMDBTool queryWithSql:query_sql];

    NSMutableArray * GLRecommedModels = [NSMutableArray array];
    while ([result next]) { // next方法返回yes代表有数据可取
        GLRecommedModel *model = [GLRecommedModel new];
        model.head = [NSKeyedUnarchiver unarchiveObjectWithData:[result dataForColumn:@"head"]];
        model.body = [NSKeyedUnarchiver unarchiveObjectWithData:[result dataForColumn:@"body"]];
        model.type = [result stringForColumn:@"type"];
        [GLRecommedModels addObject:model];
    }
    self.cellArr = GLRecommedModels;
    
    NSMutableArray * cellItemViewModels = [NSMutableArray array];
    
    RACSequence * newblogViewModels = [self.cellArr.rac_sequence
                                       map:^(GLRecommedModel * model) {
                                           GLRecommedItemViewModel * vm = [[GLRecommedItemViewModel alloc] initWithArticleModel: model];
                                           
                                           return vm;
                                       }];
    
    
    [cellItemViewModels addObjectsFromArray: newblogViewModels.array];
    
    self.cellItemViewModels = cellItemViewModels;
    
    if (self.cellArr.count) {
        complete();
    }
}

- (void)first
{
    [self handleLiveViewData];
}



@end
