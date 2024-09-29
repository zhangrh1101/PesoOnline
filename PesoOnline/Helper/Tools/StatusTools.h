//
//  StatusTools.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatusTools : NSObject

/**
 账号状态
 */
+ (NSString *)getAccountState:(NSString *)value;

/**
 用户状态
 */
+ (NSString *)getEmpState:(NSString *)value;

/**
 性别
 */
+ (NSString *)getSexState:(NSString *)value;

/**
* 返回时间段
*/
+ (NSString *)getTimeSolt:(NSString *)value;
    


@end

NS_ASSUME_NONNULL_END
