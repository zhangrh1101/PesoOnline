//
//  HomeHandler.h
//  WisePeople
//
//  Created by mac mini on 2022/7/19.
//

#import "BaseHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeHandler : BaseHandler

/**
 获取默认线路
 */
+ (void)requestDefaultPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 获取所有线路
 */
+ (void)requestAllPathListPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 获取轮播广告
 */
+ (void)requestTextCycleAdverListPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed;

@end

NS_ASSUME_NONNULL_END
