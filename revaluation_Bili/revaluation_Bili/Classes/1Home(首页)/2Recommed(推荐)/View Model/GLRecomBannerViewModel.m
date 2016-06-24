//
//  GLRecomBannerViewModel.m
//  revaluation_Bili
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRecomBannerViewModel.h"

#import "GLRecomBannerModel.h"

#import "GLFMDBToolSDK.h"

@interface GLRecomBannerViewModel ()

/** 轮播图模型 */
@property (nonatomic, strong) GLRecomBannerModel *model;

/** FMDBTool */
@property (nonatomic, strong) GLFMDBToolSDK *FMDBTool;

@end

@implementation GLRecomBannerViewModel

- (GLRecomBannerModel *)model
{
    if (_model == nil) {
        _model = [[GLRecomBannerModel alloc] init];
    }
    return _model;
}

- (GLFMDBToolSDK *)FMDBTool
{
    if (_FMDBTool == nil) {
        _FMDBTool = [GLFMDBToolSDK shareToolsWithCreateDDL:nil];
    }
    return _FMDBTool;
}

+ (instancetype)viewModel
{
    return [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化 和模型的关系 并且做网络请求
        [self linkModel];
        [self handleRecomData];
    }
    return self;
}

- (void)linkModel
{

}

/**
 *  和数据模型无关的初始化设置,放到独立的方法中.
 */

#pragma mark - 网络请求数据
- (void)loadRecomDataSuccess:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    // 使用请求参数 发送网络请求
    NSString *url = @"http://app.bilibili.com/x/banner?build=3220&channel=appstore&plat=2";
    
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
- (void)handleRecomData
{
    [self loadRecomDataSuccess:^(id json) {
        
        NSMutableArray *arrM_images = [NSMutableArray array];
        NSMutableArray *arrM_values = [NSMutableArray array];
        
        NSArray *GLRecomBannerModels = [NSArray yy_modelArrayWithClass:[GLRecomBannerModel class] json:json[@"data"]];
        
//        /** FMDB缓存 */
//        // 调用方法传递模型-数组
//        if (self.headerBannerArr.count) {
//            NSString *delete_sql = @"delete from t_LBLiveBannerItem";
//            [self.FMDBTool deleteWithSql:delete_sql];
//            self.FMDBTool = [GLFMDBToolSDK shareToolsWithCreateDDL:nil];
//            for (LBLiveBannerItem *BannerItem in self.headerBannerArr) {
//                
//                NSString *insert_sql = [NSString stringWithFormat:@"insert into t_LBLiveBannerItem (img,link,title,remark,bannerHeight) values('%@','%@','%@','%@',%f);",BannerItem.img,BannerItem.link,BannerItem.title,BannerItem.remark,BannerItem.bannerHeight];
//                [self.FMDBTool insertWithSql:insert_sql, nil];
//            }
//        }
        if (GLRecomBannerModels.count) {
            NSString *delete_sql = @"delete from t_GLRecomBannerModel";
            [self.FMDBTool deleteWithSql:delete_sql];
            for (GLRecomBannerModel *model in GLRecomBannerModels) {
                [arrM_images addObject:model.image];
                [arrM_values addObject:model.value];
                NSString *insert_sql = [NSString stringWithFormat:@"insert into t_GLRecomBannerModel (image,value) values('%@','%@');",model.image,model.value];
                [self.FMDBTool insertWithSql:insert_sql, nil];
            }
            self.imageArr = arrM_images;
            self.imageValueArr = arrM_values;
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 处理数据库缓存- -【查询】
- (void)loadPhoneDataSourceToComplete:(void (^)())complete
{
    // 传入DDL 创建表打开数据库[banner][entranceIcons][partitions]
    self.FMDBTool = [GLFMDBToolSDK shareToolsWithCreateDDL:nil];
    
    // 查询数据【banner】
    NSString *query_sql = @"select * from t_GLRecomBannerModel";
    
    FMResultSet *result = [self.FMDBTool queryWithSql:query_sql];
    
    NSMutableArray *arrM_images = [NSMutableArray array];
    NSMutableArray *arrM_values = [NSMutableArray array];
    
    while ([result next]) { // next方法返回yes代表有数据可取
        GLRecomBannerModel *model = [GLRecomBannerModel new];
        model.image = [result stringForColumn:@"image"];
        model.value = [result stringForColumn:@"value"];
        [arrM_images addObject:model.image];
        [arrM_values addObject:model.value];
    }
    self.imageArr = arrM_images;
    self.imageValueArr = arrM_values;
    if (self.imageArr.count && self.imageValueArr.count) {
        complete();
    }
}

@end
