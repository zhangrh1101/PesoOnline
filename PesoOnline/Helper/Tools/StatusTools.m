//
//  StatusTools.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/19.
//

#import "StatusTools.h"

@implementation StatusTools

/**
 账号状态
 */
+ (NSString *)getAccountState:(NSString *)value {
    if ([value isEqualToString:Account_State_OK]) {
        return @"正常";
    }
    if ([value isEqualToString:Account_State_DISABLED]) {
        return @"已移除";
    }
    return @"";
}

/**
 用户状态
 */
+ (NSString *)getEmpState:(NSString *)value {
    if ([value isEqualToString:Employee_State_WORKING]) {
        return @"在职";
    }
    if ([value isEqualToString:Employee_State_DISSMISSION]) {
        return @"离职";
    }
    if ([value isEqualToString:Employee_State_RETIRE]) {
        return @"退休";
    }
    return @"";
}

/**
 性别
 */
+ (NSString *)getSexState:(NSString *)value {
    if ([value isEqualToString:User_Sex_MALE]) {
        return @"男";
    }
    if ([value isEqualToString:User_Sex_FEMALE]) {
        return @"女";
    }
    if ([value isEqualToString:User_Sex_SECRECY]) {
        return @"保密";
    }
    return @"";
}



/**
 * 返回时间段
 */
+ (NSString *)getTimeSolt:(NSString *)value {
    NSArray *timeArray = [value componentsSeparatedByString:@":"];
    NSInteger hour = [timeArray[0] integerValue];    //时
    //    NSInteger mins = [timeArray[1] integerValue];    //分
    
    NSString *interval = @"";
    if (hour >= 0 && hour < 6) {
        interval = @"凌晨";
    }
    if (hour >= 6 && hour < 12) {
        interval = @"上午";
    }
    if (hour >= 12 && hour < 18) {
        interval = @"下午";
    }
    if (hour >= 18 && hour < 24) {
        interval = @"晚上";
    }
    return interval;
}



@end
