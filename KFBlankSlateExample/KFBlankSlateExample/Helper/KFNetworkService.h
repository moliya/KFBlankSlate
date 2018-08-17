//
//  KFNetworkService.h
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/17.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, HttpMethodType) {
    HttpMethodTypeGet,
    HttpMethodTypePost,
};

//请求地址
FOUNDATION_EXTERN NSString *const BaseURL;

//返回键值：error
FOUNDATION_EXTERN NSString *const API_RESPONSE_KEY_ERROR;
//返回键值：results
FOUNDATION_EXTERN NSString *const API_RESPONSE_KEY_RESULT;


//iOS分类
FOUNDATION_EXTERN NSString *const API_METHOD_CATE_IOS;
//前端分类
FOUNDATION_EXTERN NSString *const API_METHOD_CATE_HTML;
//福利分类
FOUNDATION_EXTERN NSString *const API_METHOD_CATE_GIFT;
//好奇心日报
FOUNDATION_EXTERN NSString *const API_METHOD_READ_QDAILY;


@interface KFNetworkService : NSObject

//服务
+ (instancetype)sharedService;

/***
 get请求
 **/
- (NSUInteger)getWithURLString:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void(^)(id responseObject))success
                       failure:(void(^)(NSError *error))failure;

- (NSUInteger)getWithURLString:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void(^)(NSProgress *progress))progress
                       success:(void(^)(id responseObject))success
                       failure:(void(^)(NSError *error))failure;

/***
 post请求
 **/
- (NSUInteger)postWithURLString:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void(^)(id responseObject))success
                        failure:(void(^)(NSError *error))failure;

- (NSUInteger)postWithURLString:(NSString *)URLString
                     parameters:(id)parameters
                       progress:(void(^)(NSProgress *progress))progress
                        success:(void(^)(id responseObject))success
                        failure:(void(^)(NSError *error))failure;

- (NSUInteger)postWithURLString:(NSString *)URLString
                     parameters:(id)parameters
      constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                       progress:(void (^)(NSProgress *uploadProgress))progress
                        success:(void(^)(id responseObject))success
                        failure:(void(^)(NSError *error))failure;

/***
 request请求
 **/
- (NSUInteger)requestWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                        methodType:(HttpMethodType)type
                           success:(void(^)(id responseObject))success
                           failure:(void(^)(NSError *error))failure;

- (NSUInteger)requestWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                        methodType:(HttpMethodType)type
                          progress:(void(^)(NSProgress *progress))progress
                           success:(void(^)(id responseObject))success
                           failure:(void(^)(NSError *error))failure;

- (NSUInteger)requestWithURLString:(NSString *)URLString
                        parameters:(id)parameters
                        methodType:(HttpMethodType)type
         constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                          progress:(void(^)(NSProgress *progress))progress
                           success:(void(^)(id responseObject))success
                           failure:(void(^)(NSError *error))failure;

//取消网络请求
- (void)cancelTaskWithIdentifier:(NSUInteger)taskIdentifier;

@end
