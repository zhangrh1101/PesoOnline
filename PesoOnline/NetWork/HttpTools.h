//
//  HttpTools.h
//  LongLongLiCai
//
//  Created by mc on 2018/4/3.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import <Foundation/Foundation.h>

// 判断当前网络的全局变量
UIKIT_EXTERN BOOL whetherHaveNetwork;
UIKIT_EXTERN AFNetworkReachabilityStatus reachabilityStatus;

@interface AFHttpManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethed;

typedef void (^HttpSuccessBlock)(id responseObject);
typedef void (^HttpFailureBlock)(id error);
typedef void (^HttpDownloadProgressBlock)(CGFloat progress);
typedef void (^HttpUploadProgressBlock)(CGFloat progress);


@interface HttpTools : NSObject

/**
 网络请求
 不做任何处理
 Get,Post
 */
+ (void)requestNetworkPath:(NSString *)path type:(int)NetworkMethed  params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure;

/**
 Get,Post
 
 @param NetworkMethed   0/1
 @param path     url路径
 @param params   url参数
 @param success  请求成功 返回NSDictionary或NSArray
 @param failure  请求失败 返回NSError
 */
+ (void)requestJsonDataWithMethedType:(int)NetworkMethed
                                 path:(NSString *)path
                                 params:(id)params
                                 success:(HttpSuccessBlock)success
                                 failure:(HttpFailureBlock)failure;


/**
 Get,Post
 
 @param NetworkMethed   0/1
 @param path     url路径
 @param params   url参数
 @param isFormData   表单提交
 @param success  请求成功 返回NSDictionary或NSArray
 @param failure  请求失败 返回NSError
 */
+ (void)requestJsonDataWithMethedType:(int)NetworkMethed
                                 path:(NSString *)path params:(id)params
                                 isFormData:(BOOL)isFormData
                                 success:(HttpSuccessBlock)success
                                 failure:(HttpFailureBlock)failure;


/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param success  下载成功
 *  @param failure  下载失败
 *  @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpDownloadProgressBlock)progress;


/**
 *  上传图片
 *
 *  @param path     url地址
 *  @param image    UIImage对象
 *  @param params  上传参数
 *  @param success  上传成功
 *  @param failure  上传失败
 *  @param progress 上传进度
 */
+ (void)uploadFileWithPath:(NSString *)path
                     params:(NSDictionary *)params
                     image:(id)image
                     success:(HttpSuccessBlock)success
                     failure:(HttpFailureBlock)failure
                     progress:(HttpUploadProgressBlock)progress;



/**
 *  错误代码
 *
 *  @param code    错误代码
 *  @param failure  失败信息
 */
+ (void)showErrorMessage:(NSString *)codeStr;

@end











