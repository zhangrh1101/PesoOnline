//
//  HttpTools.m
//  LongLongLiCai
//
//  Created by mc on 2018/4/3.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import "HttpTools.h"
#import "BaseModel.h"
#import "NoProductManager.h"

#define isOpenHttps   NO

//判断当前网络的全局变量
BOOL whetherHaveNetwork = NO;
AFNetworkReachabilityStatus reachabilityStatus = AFNetworkReachabilityStatusUnknown;

@implementation AFHttpManager

+ (instancetype)sharedManager {
    
    static AFHttpManager *manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[AFHttpManager alloc] initWithBaseURL:[NSURL URLWithString:RequestBaseURL]];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"multipart/form-data", @"text/json",@"text/plain",@"text/javascript",@"text/xml", @"image/*"]];
        
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];

        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];// 请求返回的格式为json
        
        manager.requestSerializer.timeoutInterval = 30;
        manager.securityPolicy.allowInvalidCertificates = NO;
        
        // 有缓存就用缓存，没有缓存就重新请求
        //manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
        
        //请求队列的最大并发数
        manager.operationQueue.maxConcurrentOperationCount = 5;
        
        
        //客户端类型，只能写英文   [HH_Utilities getDeviceUUID]
//        if (@"global.accessToken" && Constants.Token_Valid && config.url.indexOf(@"pub/") == -1 && config.url.indexOf(@"gateway") == -1) {
//                  config.headers.authorization = @"Bearer " + @"global.accessToken";
//        }
        
//        NSString *strHeader = [NSString stringWithFormat:@"iOS,2.0,%@",[HH_Utilities getDeviceUUID]];
//        NSString *strHeader = [NSString stringWithFormat:@"iOS,%@",@"chutianscfc"];
//        [manager.requestSerializer setValue:strHeader forHTTPHeaderField:@"User-Agent"];
        
    });
    
    return manager;
}


/**
 设置证书
 */
- (AFSecurityPolicy *)customSecurityPolicy {
    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"CTFreightLoan_ssl" ofType:@"cer"];
    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet * cerSet = [NSSet setWithObjects:cerData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 是否验证域名
    securityPolicy.validatesDomainName = NO;
    // 信任非法证书（自签名证书）
    securityPolicy.allowInvalidCertificates = YES;
    // 设置证书
    [securityPolicy setPinnedCertificates:cerSet];
    return securityPolicy;
}

@end



@implementation HttpTools

/**
 Get,Post
 
 @param NetworkMethed   0/1
 @param path     url路径
 @param params   url参数
 @param success  请求成功 返回NSDictionary或NSArray
 @param failure  请求失败 返回NSError
 */
+ (void)requestJsonDataWithMethedType:(int)NetworkMethed path:(NSString *)path params:(id)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
    if (whetherHaveNetwork) {   //是否有网络
        [NoProductManager removeHUDFromView:nil];
    }
    
    NSString *accessToken = [UserModel getInfo].accessToken;
    if (ValidStr(accessToken)) {
        NSString *token = [NSString stringWithFormat:@"bea_us %@",accessToken];
        [[AFHttpManager sharedManager].requestSerializer setValue:token forHTTPHeaderField:@"V-Auth"];
    }
    NSString *requestUrl = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    HHLog(@"请求地址---> %@ 请求类型 ---> %d", KString(@"%@%@",[AFHttpManager sharedManager].baseURL, requestUrl), NetworkMethed);
    HHLog(@"请求参数 ---> \n%@" ,params);
    
    //收起键盘
    //[APP_KeyWindow endEditing:YES];
    [[[ControlTools getCurrentVC] view] endEditing:YES];

    WeakSelf
    switch (NetworkMethed) {
        case Get:
        {
            [[AFHttpManager sharedManager] GET:requestUrl parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                HHLog(@"Get --- %@",[responseObject jsonPrettyStringEncoded]);
                
                BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
                if ([model.code isEqualToString:HTTP_SUCCESS]) {
                    success(model.data);
                }else{
                    [MBProgressHUD hideHUD];
                    if ([model.code isEqualToString:HTTP_UNLOGIN]) {
                        [UserModel logOut];
                        failure(model);
                        //getTJCulturalList会频繁调用
                        //[HHPushTools pushLoginController];
                    }else{
//                        [MBProgressHUD showMessage:model.message];
                        [weakSelf showErrorMessage:model.code];
                        failure(model);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUD];
                [[[ControlTools getCurrentVC] view] endEditing:YES];
                if (failure) {
#warning 超时崩溃
                    //                    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
                    //
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = [response statusCode];
                    if (statusCode == 401) {
                        //                        [UserModel logOut];
                    }else{
                        [HttpTools errorMessageCode:error.code];
                    }
                    HHLog(@"response --- GET %ld", error.code);
                    HHLog(@"error --- GET %@  \n %@", path, error);
                    failure(error);
                }
            }];
            break;
        }
        case Post:
        {
            [[AFHttpManager sharedManager] POST:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                HHLog(@"POST --- %@",[responseObject jsonPrettyStringEncoded]);
                
                BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
                if ([model.code isEqualToString:HTTP_SUCCESS]) {
                    success(model.data);
                }else{
                    [MBProgressHUD hideHUD];
                    if ([model.code isEqualToString:HTTP_UNLOGIN]) {
                        [UserModel logOut];
                        failure(model);
//                        [HHPushTools pushLoginController];
                    }else{
//                        [MBProgressHUD showMessage:model.message];
                        [weakSelf showErrorMessage:model.code];
                        failure(model);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUD];
                [[[ControlTools getCurrentVC] view] endEditing:YES];
                if (failure) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = [response statusCode];
                    if (statusCode == 401) {
                        //                        [UserModel logOut];
                    }else{
                        [HttpTools errorMessageCode:error.code];
                    }
                    HHLog(@"response --- POST %ld", error.code);
                    HHLog(@"error --- POST %@",error);
                    failure(error);
                }
            }];
            break;
        }
        case Put:
        {
            [[AFHttpManager sharedManager] PUT:path parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                HHLog(@"Put --- %@",[responseObject jsonPrettyStringEncoded]);
                
                BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
                if ([model.code isEqualToString:HTTP_SUCCESS]) {
                    success(model.data);
                }else{
//                    [MBProgressHUD showMessage:model.message];
                    [weakSelf showErrorMessage:model.code];
                    failure(model);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUD];
                [[[ControlTools getCurrentVC] view] endEditing:YES];
                if (failure) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = [response statusCode];
                    
                    HHLog(@"response --- PUT %ld",statusCode);
                    HHLog(@"%@",error);
                    failure(error);
                }
                [HttpTools errorMessageCode:error.code];
            }];
            break;
        }
        case Delete:
        {
            [[AFHttpManager sharedManager] DELETE:path parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                HHLog(@"Delete --- %@",[responseObject jsonPrettyStringEncoded]);
                
                BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
                if ([model.code isEqualToString:HTTP_SUCCESS]) {
                    success(model.data);
                }else{
                    [[[ControlTools getCurrentVC] view] endEditing:YES];
//                    [MBProgressHUD showMessage:model.message];
                    [weakSelf showErrorMessage:model.code];
                    failure(model);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUD];
                [[[ControlTools getCurrentVC] view] endEditing:YES];
                if (failure) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = [response statusCode];
                    
                    HHLog(@"response --- DELETE %ld",statusCode);
                    HHLog(@"%@",error);
                    failure(error);
                }
                [HttpTools errorMessageCode:error.code];
            }];
            break;
        }
        default:
            break;
    }
}


/**
 Get,Post
 
 @param NetworkMethed   0/1
 @param path     url路径
 @param params   url参数
 @param isFormData   表单提交
 @param success  请求成功 返回NSDictionary或NSArray
 @param failure  请求失败 返回NSError
 */
+ (void)requestJsonDataWithMethedType:(int)NetworkMethed path:(NSString *)path params:(id)params
                           isFormData:(BOOL)isFormData
                              success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
    if (whetherHaveNetwork) {   //是否有网络
        [NoProductManager removeHUDFromView:nil];
    }
    
    NSString *accessToken = [UserModel getInfo].accessToken;
    if (ValidStr(accessToken)) {
        NSString *token = [NSString stringWithFormat:@"bea_us %@",accessToken];
        [[AFHttpManager sharedManager].requestSerializer setValue:token forHTTPHeaderField:@"V-Auth"];
    }
    NSString *requestUrl = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    HHLog(@"请求地址---> %@ 请求类型 ---> %d", KString(@"%@%@",[AFHttpManager sharedManager].baseURL, requestUrl), NetworkMethed);
    HHLog(@"请求参数 ---> \n%@" ,params);
    
    switch (NetworkMethed) {
        case Get: {
            
        } break;
        case Post: {
            
            NSDictionary *formDataDic = [[NSDictionary alloc] initWithDictionary:params];
            if (params && isFormData) {
                params = nil;
            }
            [[AFHttpManager sharedManager] POST:path parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                //拼接表单数据
                if (isFormData) {
                    NSArray *keys = [formDataDic allKeys];
                    for (id key in keys) {
                        [formData appendPartWithFormData:[formDataDic[key] dataUsingEncoding:NSUTF8StringEncoding] name:key];
                    }
                }
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                HHLog(@"POST --- %@",[responseObject jsonPrettyStringEncoded]);
                
                BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
                if ([model.code isEqualToString:HTTP_SUCCESS]) {
                    success(model.data);
                }
                else if ([model.code isEqualToString:HTTP_LOGIN_UNBIND]) {
                    success(model.code);
                }
                else{
                    [MBProgressHUD hideHUD];
                    if ([model.code isEqualToString:HTTP_UNLOGIN]) {
                        [UserModel logOut];
                        failure(model);
//                        [HHPushTools pushLoginController];
                    }else{
                        [MBProgressHUD showMessage:model.message];
                        [[[ControlTools getCurrentVC] view] endEditing:YES];
                        failure(model);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUD];
                [[[ControlTools getCurrentVC] view] endEditing:YES];
                if (failure) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSInteger statusCode = [response statusCode];
                    if (statusCode == 401) {
                        //                        [UserModel logOut];
                    }else{
                        [HttpTools errorMessageCode:error.code];
                    }
                    
                    HHLog(@"response --- POST %ld", statusCode);
                    HHLog(@"error --- POST %@",error);
                    failure(error);
                }
            }];
        } break;
        case Put: {
            
        } break;
        case Delete: {
            
        } break;
        default:
            break;
    }
}


/**
 *  网络请求
 *  @param path     url路径
 */
+ (void)requestNetworkPath:(NSString *)path type:(int)NetworkMethed  params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure {
    
    if (whetherHaveNetwork) {   //是否有网络
        [NoProductManager removeHUDFromView:nil];
    }
    
    WeakSelf
    switch (NetworkMethed) {
        case Get:
        {
            [[AFHttpManager sharedManager] GET:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                HHLog(@"%@",[responseObject jsonPrettyStringEncoded]);
                
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                [MBProgressHUD hideHUD];
//                [HttpTools errorMessageCode:error.code];
            }];
            break;
        }
        case Post:
        {
            [[AFHttpManager sharedManager] POST:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                HHLog(@"%@",[responseObject jsonPrettyStringEncoded]);
                
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                [MBProgressHUD hideHUD];
//                [HttpTools errorMessageCode:error.code];
            }];
            break;
        }
        default:
            break;
    }
}


/**
 *  基础网络请求
 *  @param path     url路径
 */
+ (void)requestThridMethedType:(int)NetworkMethed path:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure{
    
    if (whetherHaveNetwork) {   //是否有网络
        [NoProductManager removeHUDFromView:nil];
    }
    
    WeakSelf
    switch (NetworkMethed) {
        case Get:
        {
            [[AFHttpManager sharedManager] GET:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                HHLog(@"%@",[responseObject jsonPrettyStringEncoded]);
                
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                [MBProgressHUD hideHUD];
                [HttpTools errorMessageCode:error.code];
            }];
            break;
        }
        case Post:
        {
            [[AFHttpManager sharedManager] POST:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                HHLog(@"%@",[responseObject jsonPrettyStringEncoded]);
                
                if (success) {
                    success(responseObject);
                }else{
                    [MBProgressHUD hideHUD];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failure) {
                    failure(error);
                }
                [MBProgressHUD hideHUD];
                [HttpTools errorMessageCode:error.code];
            }];
            break;
        }
        default:
            break;
    }
}




/**
 *  下载文件
 *
 *  @param path     url路径
 *  @param success  下载成功
 *  @param failure  下载失败
 *  @param progress 下载进度
 */
+ (void)downloadWithPath:(NSString *)path success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpDownloadProgressBlock)progress{
    
    //下载
    NSURL *URL = [NSURL URLWithString:path];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpManager sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
    }];
    
    [downloadTask resume];
}


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
                  progress:(HttpUploadProgressBlock)progress {
    
    //参数加密
    NSString *requestUrl = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    HHLog(@"图片上传请求地址---> %@", KString(@"%@%@",[AFHttpManager sharedManager].baseURL, requestUrl));
    HHLog(@"图片上传参数 %@", params);
    
    [[AFHttpManager sharedManager] POST:path parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

//        HHImageModel *model = (HHImageModel *)image;
//        [formData appendPartWithFileData:model.data name:@"uploadFile" fileName:model.fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
        CGFloat uploadNum = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        HHLog(@"上传进度 --- %.2f%%", uploadNum)
        progress(uploadNum);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HHLog(@"%@",[responseObject jsonPrettyStringEncoded]);
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObject];
        if ([model.code isEqualToString:HTTP_SUCCESS]) {
            success(model.data);
        }else{
            [MBProgressHUD showMessage:model.message];
            failure(nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        [MBProgressHUD hideHUD];
        [HttpTools errorMessageCode:error.code];
    }];
    
}


+ (void)errorMessageCode:(NSInteger)code
{
    switch (code) {
        case -1://NSURLErrorUnknown
            [MBProgressHUD showMessage:@"无效的URL地址"];
            break;
        case -999://NSURLErrorCancelled
            [MBProgressHUD showMessage:@"无效的URL地址"];
            break;
        case -1000://NSURLErrorBadURL
            [MBProgressHUD showMessage:@"无效的URL地址"];
            break;
        case -1001://NSURLErrorTimedOut
            [MBProgressHUD showMessage:@"网络不给力，请稍后再试"];
            break;
        case -1002://NSURLErrorUnsupportedURL
            [MBProgressHUD showMessage:@"不支持的URL地址"];
            break;
        case -1003://NSURLErrorCannotFindHost
            [MBProgressHUD showMessage:@"找不到服务器"];
            break;
        case -1004://NSURLErrorCannotConnectToHost
            [MBProgressHUD showMessage:@"服务器连接失败"];
            break;
        case -1103://NSURLErrorDataLengthExceedsMaximum
            [MBProgressHUD showMessage:@"请求数据长度超出最大限度"];
            break;
        case -1005://NSURLErrorNetworkConnectionLost
            [MBProgressHUD showMessage:@"网络连接异常"];
            break;
        case -1006://NSURLErrorDNSLookupFailed
            [MBProgressHUD showMessage:@"DNS查询失败"];
            break;
        case -1007://NSURLErrorHTTPTooManyRedirects
            [MBProgressHUD showMessage:@"HTTP请求重定向"];
            break;
        case -1008://NSURLErrorResourceUnavailable
            [MBProgressHUD showMessage:@"资源不可用"];
            break;
        case -1009://NSURLErrorNotConnectedToInternet
            [MBProgressHUD showMessage:@"无网络连接"];
            break;
        case -1010://NSURLErrorRedirectToNonExistentLocation
            [MBProgressHUD showMessage:@"重定向到不存在的位置"];
            break;
        case -1011://NSURLErrorBadServerResponse
            [MBProgressHUD showMessage:@"服务器响应异常"];
            break;
        case -1012://NSURLErrorUserCancelledAuthentication
            [MBProgressHUD showMessage:@"用户取消授权"];
            break;
        case -1013://NSURLErrorUserAuthenticationRequired
            [MBProgressHUD showMessage:@"需要用户授权"];
            break;
        case -1014://NSURLErrorZeroByteResource
            [MBProgressHUD showMessage:@"零字节资源"];
            break;
        case -1015://NSURLErrorCannotDecodeRawData
            [MBProgressHUD showMessage:@"无法解码原始数据"];
            break;
        case -1016://NSURLErrorCannotDecodeContentData
            [MBProgressHUD showMessage:@"无法解码内容数据"];
            break;
        case -1017://NSURLErrorCannotParseResponse
            [MBProgressHUD showMessage:@"无法解析响应"];
            break;
        case -1018://NSURLErrorInternationalRoamingOff
            [MBProgressHUD showMessage:@"国际漫游关闭"];
            break;
        case -1019://NSURLErrorCallIsActive
            [MBProgressHUD showMessage:@"被叫激活"];
            break;
        case -1020://NSURLErrorDataNotAllowed
            [MBProgressHUD showMessage:@"请检查网络设置"];
            break;
        case -1021://NSURLErrorRequestBodyStreamExhausted
            [MBProgressHUD showMessage:@"请求体"];
            break;
        case -1100://NSURLErrorFileDoesNotExist
            [MBProgressHUD showMessage:@"文件不存在"];
            break;
        case -1101://NSURLErrorFileIsDirectory
            [MBProgressHUD showMessage:@"文件是个目录"];
            break;
        case -1102://NSURLErrorNoPermissionsToReadFile
            [MBProgressHUD showMessage:@"无读取文件权限"];
            break;
        case -1200://NSURLErrorSecureConnectionFailed
            [MBProgressHUD showMessage:@"安全连接失败"];
            break;
        case -1201://NSURLErrorServerCertificateHasBadDate
            [MBProgressHUD showMessage:@"服务器证书失效"];
            break;
        case -1202://NSURLErrorServerCertificateUntrusted
            [MBProgressHUD showMessage:@"不被信任的服务器证书"];
            break;
        case -1203://NSURLErrorServerCertificateHasUnknownRoot
            [MBProgressHUD showMessage:@"未知Root的服务器证书"];
            break;
        case -1204://NSURLErrorServerCertificateNotYetValid
            [MBProgressHUD showMessage:@"服务器证书未生效"];
            break;
        case -1205://NSURLErrorClientCertificateRejected
            [MBProgressHUD showMessage:@"客户端证书被拒"];
            break;
        case -1206://NSURLErrorClientCertificateRequired
            [MBProgressHUD showMessage:@"需要客户端证书"];
            break;
        case -2000://NSURLErrorCannotLoadFromNetwork
            [MBProgressHUD showMessage:@"无法从网络获取"];
            break;
        case -3000://NSURLErrorCannotCreateFile
            [MBProgressHUD showMessage:@"无法创建文件"];
            break;
        case -3001:// NSURLErrorCannotOpenFile
            [MBProgressHUD showMessage:@"无法打开文件"];
            break;
        case -3002://NSURLErrorCannotCloseFile
            [MBProgressHUD showMessage:@"无法关闭文件"];
            break;
        case -3003://NSURLErrorCannotWriteToFile
            [MBProgressHUD showMessage:@"无法写入文件"];
            break;
        case -3004://NSURLErrorCannotRemoveFile
            [MBProgressHUD showMessage:@"无法删除文件"];
            break;
        case -3005://NSURLErrorCannotMoveFile
            [MBProgressHUD showMessage:@"无法移动文件"];
            break;
        case -3006://NSURLErrorDownloadDecodingFailedMidStream
            [MBProgressHUD showMessage:@"下载解码数据失败"];
            break;
        case -3007://NSURLErrorDownloadDecodingFailedToComplete
            [MBProgressHUD showMessage:@"下载解码数据失败"];
            break;
        default:
            [MBProgressHUD showMessage:@"网络突然开小差了~"];
            break;
    }
}


/**
 *  错误代码
 *
 *  @param codeStr  错误代码
 *  @param failure  失败信息
 */
+ (void)showErrorMessage:(NSString *)codeStr {
    NSString *message = @"";
    NSInteger code = [codeStr integerValue];
    switch (code) {
        case 100990:
            message = @"用户token不存在";
            break;
        case 100991:
            message = @"用户token验证失败";
            break;
        case 100997:
            message = @"用户授权参数错误";
            break;
        case 100998:
            message = @"用户不存在";
            break;
        case 100999:
            message = @"用户名或密码错误";
            break;
        case 100899:
            message = @"老密码错误";
            break;
        case 100993:
            message = @"手机号已存在";
            break;
        case 100994:
            message = @"手机验证码不能为空";
            break;
        case 100995:
            message = @"手机验证码60s内重复发送错误";
            break;
        case 100996:
            message = @"手机验证码验证错误";
            break;
        case 100983:
            message = @"邮箱已存在";
            break;
        case 200990:{
            message = @"用户会员过期";
        }
            break;
        case 200991:
            message = @"用户邀请码不存在";
            break;
        case 200992:
            message = @"无法输入自己的邀请码";
            break;
        case 200993:
            message = @"该会员不是代理";
            break;
        case 200994:
            message = @"会员不存在";
            break;
        case 200995:
            message = @"设备ID不存在";
            break;
        case 200996:
            message = @"设备号解析失败";
            break;
        case 200997:
            message = @"免费时间到期";
            break;
        case 200998:
            message = @"已经填写过邀请码";
            break;
        case 300990:
            message = @"订单号不存在";
            break;
        case 300991:
            message = @"下订单与用户身份不符合，请求会盗取或者系统设置异常";
            break;
        case 300992:
            message = @"提现金额大于了账户剩余金额";
            break;
        case 300993:
            message = @"提现金额不能小于某个数";
            break;
        case 300994:
            message = @"提现金额不能小于某个数";
            break;
        case 300995:
            message = @"提现金额必须是整数";
            break;
        case 300997:
            message = @"当前时间小于允许提现时间，不允许提现";
            break;
        default:
            message = @"系统异常";
            break;
    }
    [MBProgressHUD showMessage:message];
}


@end








