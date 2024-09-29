//
//  PublicHandler.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/17.
//

#import "PublicHandler.h"

@implementation PublicHandler

/**
 基础接口 完整Api
 */
+ (void)requestBasePath:(NSString *)path type:(NetworkMethed)type params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    [HttpTools requestNetworkPath:path type:type params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(id error) {
        failed(error);
    }];
}


/**
 公共接口 BaseApi
 */
+ (void)requestPublicPath:(NSString *)path type:(NetworkMethed)type params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    [HttpTools requestJsonDataWithMethedType:type path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

@end
