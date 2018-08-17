//
//  KFNetworkService.m
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/17.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "KFNetworkService.h"

NSString *const BaseURL = @"http://gank.io/api";
NSString *const API_RESPONSE_KEY_ERROR = @"error";
NSString *const API_RESPONSE_KEY_RESULT = @"results";
NSString *const API_METHOD_CATE_IOS = @"/data/iOS/10/";
NSString *const API_METHOD_CATE_HTML = @"/data/前端/10/";
NSString *const API_METHOD_CATE_GIFT = @"/data/福利/10/";
NSString *const API_METHOD_READ_QDAILY = @"/xiandu/data/id/qdaily/count/10/";

@interface KFNetworkService()

@property (nonatomic, strong) AFHTTPSessionManager  *manager;

@end

@implementation KFNetworkService

- (void)initManager {
    //NSURLSessionConfiguration为NSURLSession配置一些请求所需要的策略。如：超时、缓存策略、链接需求的
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //设置配置文件
    //设置缓存策略
    //config.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    //设置网络服务类型 决定了网络请求的形式，默认default
    config.networkServiceType = NSURLNetworkServiceTypeDefault;
    //设置请求超时时间，默认60
    config.timeoutIntervalForRequest = 15;
    //设置请求头
    //config.HTTPAdditionalHeaders
    //网络属性  是否使用移动流量，默认YES
    config.allowsCellularAccess = YES;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    self.manager = manager;
}

- (id)filterParameters:(id)parameters {
    if ([parameters isKindOfClass:[NSString class]]) {
        //处理nil字符串
        return parameters ?: @"";
    } else if ([parameters isKindOfClass:[NSArray class]]) {
        //处理nil数组
        if (!parameters) {
            return [NSArray array];
        }
        NSMutableArray *array = [NSMutableArray arrayWithArray:parameters];
        for (NSInteger i = 0; i < array.count; i ++) {
            array[i] = [self filterParameters:array[i]];
        }
    } else if ([parameters isKindOfClass:[NSDictionary class]]) {
        //处理nil字典
        if (!parameters) {
            return [NSDictionary dictionary];
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
        for (NSString *key in dic.allKeys) {
            dic[key] = [self filterParameters:dic[key]];
        }
    }
    return parameters;
}


#pragma mark - ##
+ (instancetype)sharedService {
    static dispatch_once_t onceToken;
    static KFNetworkService *service;
    
    dispatch_once(&onceToken, ^{
        service = [[KFNetworkService alloc] init];
        [service initManager];
    });
    
    return service;
}

#pragma mark - ###
- (NSUInteger)getWithURLString:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(id))success
                       failure:(void (^)(NSError *))failure {
    return [self getWithURLString:URLString
                       parameters:parameters
                         progress:nil
                          success:success
                          failure:failure];
}

- (NSUInteger)getWithURLString:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress *))progress
                       success:(void (^)(id))success
                       failure:(void (^)(NSError *))failure {
    return [self requestWithURLString:URLString
                           parameters:parameters
                           methodType:HttpMethodTypeGet
            constructingBodyWithBlock:nil
                             progress:progress
                              success:success
                              failure:failure];
}

- (NSUInteger)postWithURLString:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id))success
                        failure:(void (^)(NSError *))failure {
    return [self postWithURLString:URLString
                        parameters:parameters
                          progress:nil
                           success:success
                           failure:failure];
}

- (NSUInteger)postWithURLString:(NSString *)URLString
                     parameters:(id)parameters
                       progress:(void (^)(NSProgress *))progress
                        success:(void (^)(id))success
                        failure:(void (^)(NSError *))failure {
    return [self requestWithURLString:URLString
                           parameters:parameters
                           methodType:HttpMethodTypePost
            constructingBodyWithBlock:nil
                             progress:progress
                              success:success
                              failure:failure];
}

- (NSUInteger)postWithURLString:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block progress:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    return [self requestWithURLString:URLString
                           parameters:parameters
                           methodType:HttpMethodTypePost
            constructingBodyWithBlock:block
                             progress:progress
                              success:success
                              failure:failure];
}

- (NSUInteger)requestWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                        methodType:(HttpMethodType)type
                           success:(void (^)(id))success
                           failure:(void (^)(NSError *))failure {
    return [self requestWithURLString:URLString
                           parameters:parameters
                           methodType:type
                             progress:nil
                              success:success
                              failure:failure];
}

- (NSUInteger)requestWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                        methodType:(HttpMethodType)type
                          progress:(void (^)(NSProgress *))progress
                           success:(void (^)(id))success
                           failure:(void (^)(NSError *))failure {
    return [self requestWithURLString:URLString
                           parameters:parameters
                           methodType:type
            constructingBodyWithBlock:nil
                             progress:progress
                              success:success
                              failure:failure];
}

- (NSUInteger)requestWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                        methodType:(HttpMethodType)type
         constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                          progress:(void (^)(NSProgress *))progress
                           success:(void (^)(id))success
                           failure:(void (^)(NSError *))failure {
    //处理请求参数
    parameters = [self filterParameters:parameters];
    NSURLSessionDataTask *task;
    //判断请求方式
    if (type == HttpMethodTypeGet) {
        task = [self.manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            if(progress) {
                progress(downloadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    } else {
        task = [self.manager POST:URLString parameters:parameters constructingBodyWithBlock:block progress:^(NSProgress * _Nonnull uploadProgress) {
            if(progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
    
    return task.taskIdentifier;
}

- (void)cancelTaskWithIdentifier:(NSUInteger)taskIdentifier {
    for (NSURLSessionDataTask *task in self.manager.tasks) {
        if (task.taskIdentifier == taskIdentifier) {
            [task cancel];
            break;
        }
    }
}

@end
