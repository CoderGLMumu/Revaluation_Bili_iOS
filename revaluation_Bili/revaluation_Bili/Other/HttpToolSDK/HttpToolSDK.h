//
//  HttpToolSDK.h
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpToolSDK : NSObject

/**
 *  封装get请求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */

+ (void)getWithURL:(NSString *)URL parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure: (void (^)(NSError *error))failure;

/**
 *  封装返回HTML数据的get请求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)getHTMLDataWithURL:(NSString *)URL parameters:(NSDictionary *)parameters success:(void (^)(id string))success failure:(void (^)(NSError *error))failure;

/**
 *  封装post请求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)postWithURL:(NSString *)URL parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *))failure;

/**
 *  封装带文件的POST请求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param dataArray  上传内容数组
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)postWithURL:(NSString *)URL parameters:(NSDictionary *)parameters fromDataArray:(NSArray *)dataArray success:(void (^)(id json))success failure:(void (^)(NSError *))failure;

+ (void)cancelAllRequest;

@end

/**
 *  上传文件中包含的参数
 */
@interface FromData : NSObject

/** 文件数据 */
@property(nonatomic, strong)NSData *data;
/** 参数名 */
@property (nonatomic, copy) NSString *name;
/** 文件名 */
@property (nonatomic, copy) NSString *filename;
/** 文件类型 */
@property (nonatomic, copy) NSString *mimeType;

@end
