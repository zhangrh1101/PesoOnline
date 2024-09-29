//
//  NSDate+HHExtension.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HHExtension)

/**获取当前的时间*/
+ (NSString *)currentDateStr;
/**获取当前时间戳*/
+ (NSString *)currentTimeStamp;

/**时间转日期*/
+ (NSString *)getTimeWithDate:(NSDate *)date format:(NSString * _Nullable)format;
/**时间转时间戳*/
+ (NSString *)getTimeIntervalWithDate:(NSDate *)date;
/**时间戳转时间*/
+ (NSDate *)getDateWithTimeInterval:(NSInteger)timeInterval;

/**获取几天前的时间戳*/
+ (NSString *)getTimeBeforeNowWithDay:(NSInteger)day;
/**获取几天后的时间戳*/
+ (NSString *)getTimeAfterNowWithDay:(NSInteger)day;


/**根据时间戳转换成北京时间*/
+ (NSString *)getTimeWithTimeInterval:(NSString *)time;
/**根据时间戳转换成指定格式北京时间 @param time 格式化格式 ：如@“yyyy-MM-dd HH-mm-ss” */  
+ (NSString *)getTimeWithTimeInterval:(NSString *)time format:(NSString * _Nullable)format;

/**字符串时间 转 时间戳 如：2017-4-10 17:15:10*/
+ (NSString *)timeStamp:(NSString *)str;

/** 根据需求 距离现在多少秒 */
+ (NSInteger)getSecondBefore:(NSString *)timeStamp;

/** 根据需求 返回多少小时前 */
+ (NSString *)getHoursBefore:(NSString *)timeStamp;

/** 根据需求格式化时间 今天/昨天 */
+ (NSString *)getDateForTime:(NSString *)timeStamp;

/** 根据需求 计算耗时 天、时、分钟 */
+ (NSString *)getUseDate:(NSInteger)timeStamp;

@end

NS_ASSUME_NONNULL_END
