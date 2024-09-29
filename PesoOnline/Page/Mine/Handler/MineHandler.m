//
//  MineHandler.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/17.
//

#import "MineHandler.h"

@implementation MineHandler

/**
 查询用户信息
 */
+ (void)requestUserInfoPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    [HttpTools requestJsonDataWithMethedType:Get path:path params:params success:^(id responseObject) {
    
        success(responseObject);
        
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

/**
 更新用户信息
 */
+ (void)requestUpdateUserInfoPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    [HttpTools requestJsonDataWithMethedType:Post path:path params:params isFormData:YES success:^(id responseObject) {
    
        success(responseObject);
        
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

/**
 获取相关地址
 */
+ (void)requestWebUrlPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    [HttpTools requestJsonDataWithMethedType:Get path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

/**
 填写邀请码
 */
+ (void)requestShareIntiveCodePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    [HttpTools requestJsonDataWithMethedType:Put path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}


@end
