//
//  PublicHandler.h
//  FasterVpn
//
//  Created by mac mini on 2022/5/17.
//

#import "BaseHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface PublicHandler : BaseHandler

/**
 基础接口 完整Api
 */
+ (void)requestBasePath:(NSString *)path type:(NetworkMethed)type params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 公共接口 BaseApi
 */
+ (void)requestPublicPath:(NSString *)path type:(NetworkMethed)type params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

@end

NS_ASSUME_NONNULL_END
