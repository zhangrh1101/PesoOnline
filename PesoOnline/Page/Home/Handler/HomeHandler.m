//
//  HomeHandler.m
//  WisePeople
//
//  Created by mac mini on 2022/7/19.
//

#import "HomeHandler.h"

@implementation HomeHandler

/**
 获取默认线路
 */
+ (void)requestDefaultPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HttpTools requestJsonDataWithMethedType:Get path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

/**
 获取所有线路
 */
+ (void)requestAllPathListPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HttpTools requestJsonDataWithMethedType:Get path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

/**
 获取轮播广告
 */
+ (void)requestTextCycleAdverListPath:(NSString *)path params:(NSDictionary * _Nullable)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    [HttpTools requestJsonDataWithMethedType:Put path:path params:params success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failed(error);
    }];
}

@end
