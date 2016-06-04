//
//  HttpToolSDK.m
//  revaluation_Bili
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HttpToolSDK.h"

@interface HttpToolSDK ()

/** 为了懒加载AFN对象 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

/** 为了懒加载AFN对象 */
@property (nonatomic, strong) AFHTTPSessionManager *http_manager;

@end

@implementation HttpToolSDK

- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer.timeoutInterval = 10;
    }
    return _manager;
}

- (AFHTTPSessionManager *)http_manager
{
    if (_http_manager == nil) {
        _http_manager = [AFHTTPSessionManager manager];
        _http_manager.requestSerializer.timeoutInterval = 10;
    }
    return _manager;
}

+ (void)getWithURL:(NSString *)URL parameters:(NSDictionary *)parameters  success:(void (^)(id json))success failure: (void (^)(NSError *error))failure
{
    [[self shareHttpTool] getWithURL:URL parameters:parameters success:^(id responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

- (void)getWithURL:(NSString *)URL parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    
    
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    /** 必须在serializer后面 请求超时10s */
    self.manager.requestSerializer.timeoutInterval = 10;
    
//    申明请求的数据是json类型

    //申明返回的结果是json类型
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    // 2.发送请求
    [self.manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /** 容错处理 */
        if([responseObject isKindOfClass:[NSDictionary class]]){
            if (responseObject) {
                success(responseObject);
            }
        }else if([responseObject isKindOfClass:[NSData class]]){
            if (responseObject) {
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

+ (void)getHTMLDataWithURL:(NSString *)URL parameters:(NSDictionary *)parameters success:(void (^)(id string))success failure:(void (^)(NSError *error))failure
{
    [[self shareHttpTool] getHTMLDataWithURL:URL parameters:parameters success:^(id string) {
        if (string) {
            success(string);
        }
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

- (void)getHTMLDataWithURL:(NSString *)URL parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    
    //申明请求的数据是HTML类型
    self.http_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    /** timeoutInterval必须在serializer后面 */
    self.http_manager.requestSerializer.timeoutInterval = 10;
    
    //申明响应的数据是HTML类型
    self.http_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    self.http_manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];

    // 2.发送请求
    [self.http_manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            success(string);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error-html-%@",error);
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)URL parameters:(NSDictionary *)parameters success:(void (^)(id json))success failure:(void (^)(NSError *))failure
{
    [[self shareHttpTool] postWithURL:URL parameters:parameters success:^(id responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

- (void)postWithURL:(NSString *)URL parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    //申明请求的数据是json类型
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    /** 请求超时10s */
    self.manager.requestSerializer.timeoutInterval = 10;
    
    //申明返回的结果是json类型
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    
    /**
     //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
     //   如果报接受类型不一致请替换一致text/html或别的
     
     //    NSSet *set = manager.responseSerializer.acceptableContentTypes;
     //    NSMutableSet *setM = [NSMutableSet setWithSet:set];
     //    [setM addObject:@"text/plain"];
     //    AFHTTPResponseSerializer *responseSerializer = [[AFHTTPResponseSerializer alloc] init];
     //    responseSerializer.acceptableContentTypes = setM;
     //    manager.responseSerializer = responseSerializer;
     */
    
    // 2.发送请求
    [self.manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /** 容错处理 */
        if([responseObject isKindOfClass:[NSDictionary class]]){
            if (responseObject) {
                success(responseObject);
            }
        }else if([responseObject isKindOfClass:[NSData class]]){
            if (responseObject) {
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)URL parameters:(NSDictionary *)parameters fromDataArray:(NSArray *)dataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [[self shareHttpTool] postWithURL:URL parameters:parameters fromDataArray:dataArray success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

- (void)postWithURL:(NSString *)URL parameters:(NSDictionary *)parameters fromDataArray:(NSArray *)dataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    
    //申明请求的数据是json类型
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    self.manager.requestSerializer.timeoutInterval = 10;
    
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    
    // 2.发送请求
    [self.manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (FromData *formDatas in dataArray) {
            [formData appendPartWithFileData:formDatas.data name:formDatas.name fileName:formDatas.filename mimeType:formDatas.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /** 容错处理 */
        if([responseObject isKindOfClass:[NSDictionary class]]){
            if (responseObject) {
                success(responseObject);
            }
        }else if([responseObject isKindOfClass:[NSData class]]){
            if (responseObject) {
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

+ (void)cancelAllRequest
{
    [[self shareHttpTool] cancelAllRequest];
}

- (void)cancelAllRequest
{
    // AFN取消请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.http_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

static HttpToolSDK *_instance;

//类方法，返回一个单例对象
+ (instancetype)shareHttpTool
{
    //注意：这里建议使用self,而不是直接使用类名Tools（考虑继承）
    
    return [[self alloc]init];
}

//保证永远只分配一次存储空间
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    //    使用GCD中的一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

@end

/**
 *  用来封装文件数据的模型
 */
@implementation FromData

@end
