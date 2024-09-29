//
//  LoginHandler.m
//  FasterVpn
//
//  Created by Zzzzzzzzz💤 on 2022/5/9.
//

#import "LoginHandler.h"

@implementation LoginHandler

/**
 手机号登录接口
 */
+ (void)requestLoginWithPhonePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    [HttpTools requestJsonDataWithMethedType:Post path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

/**
 注册接口
 */
+ (void)requestRegistWithPhonePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    [HttpTools requestJsonDataWithMethedType:Post path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

/**
 忘记密码
 */
+ (void)requestForgetWithPhonePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    [HttpTools requestJsonDataWithMethedType:Post path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

/**
 发送验证码
 */
+ (void)requestSendVerificationCodePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    [HttpTools requestJsonDataWithMethedType:Get path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

@end
