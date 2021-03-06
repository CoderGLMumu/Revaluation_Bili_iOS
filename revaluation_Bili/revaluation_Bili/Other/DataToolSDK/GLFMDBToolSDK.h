//
//  GLFMDBToolSDK.h
//  revaluation_Bili
//
//  Created by mac on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
/** 导入FMDB框架
    封装工具类 【使用队列-存储在cache文件夹】,提供 CURD接口
    单例模式
 
 */

@interface GLFMDBToolSDK : NSObject

+ (instancetype)shareToolsWithCreateDDL:(NSString *)DDL;

- (void)insertWithSql:(NSString *)DML_sql, ...NS_REQUIRES_NIL_TERMINATION;

- (void)deleteWithSql:(NSString *)DML_sql;

- (void)updateWithSql:(NSString *)DML_sql;

- (FMResultSet *)queryWithSql:(NSString *)DML_sql;

@end
