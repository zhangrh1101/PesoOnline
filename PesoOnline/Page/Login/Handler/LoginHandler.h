//
//  LoginHandler.h
//  FasterVpn
//
//  Created by Zzzzzzzzz💤 on 2022/5/9.
//

#import "BaseHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginHandler : BaseHandler

/**
 手机号登录接口
 */
+ (void)requestLoginWithPhonePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 注册接口
 */
+ (void)requestRegistWithPhonePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 忘记密码
 */
+ (void)requestForgetWithPhonePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 发送验证码
 */
+ (void)requestSendVerificationCodePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

@end

NS_ASSUME_NONNULL_END
