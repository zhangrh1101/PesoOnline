//
//  MineHandler.h
//  FasterVpn
//
//  Created by mac mini on 2022/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHandler : NSObject

/**
 用户信息
 */
+ (void)requestUserInfoPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 更新用户信息
 */
+ (void)requestUpdateUserInfoPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 获取相关地址
 */
+ (void)requestWebUrlPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 填写邀请码
 */
+ (void)requestShareIntiveCodePath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

@end

NS_ASSUME_NONNULL_END
