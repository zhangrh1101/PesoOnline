//
//  NSDate+HHExtension.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/29.
//

#import "NSDate+HHExtension.h"

@implementation NSDate (HHExtension)

/*获取当前时间戳*/
+ (NSString *)currentTimeStamp {
    //获取当前时间0秒后的时间
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    //*1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}


/*获取当前的时间*/
+ (NSString *)currentDateStr
{
    // 获取系统当前时间
    NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}



/*时间转日期*/
+ (NSString *)getTimeWithDate:(NSDate *)date format:(NSString *)format {
    if (!ValidStr(format)) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

/*时间转时间戳*/
+ (NSString *)getTimeIntervalWithDate:(NSDate *)date {
    //*1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

/*时间戳转时间*/
+ (NSDate *)getDateWithTimeInterval:(NSInteger)timeInterval {
    //*1000 是精确到毫秒，不乘就是精确到秒
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return date;
}



/*获取几天前的时间戳*/
+ (NSString *)getTimeBeforeNowWithDay:(NSInteger)day {
    //获取当前时间0秒后的时间
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    //*1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSInteger milsec =  time - day * 24 * 3600 * 1000;
    
    NSString *timeString = [NSString stringWithFormat:@"%.0ld", milsec];
    return timeString;
}


/*获取几天后的时间戳*/
+ (NSString *)getTimeAfterNowWithDay:(NSInteger)day {

    NSInteger milsec = day * 24 * 3600;
    //获取当前时间0秒后的时间
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:milsec];
    //*1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}


/*根据时间戳转换成北京时间*/
+ (NSString *)getTimeWithTimeInterval:(NSString *)time {
    return [NSDate getTimeWithTimeInterval:time format:@"yyyy-MM-dd HH:mm:ss"];
}

/*根据时间戳转换成指定格式北京时间*/
+ (NSString *)getTimeWithTimeInterval:(NSString *)time format:(NSString *)format {
    if (!ValidStr(time)) {
        return @"";
    }
    if (!ValidStr(format)) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    //13位时间戳
    NSTimeInterval interval    = [time doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateString       = [formatter stringFromDate:date];
    return dateString;
}


/*字符串时间 转 时间戳 如：2017-4-10 17:15:10*/
+ (NSString *)timeStamp:(NSString *)time {
    if (!ValidStr(time)) {
        return @"";
    }
    if (time.length < 15) {
        time = KString(@"%@ 00:00:00", time);
    }
    //创建一个时间格式化对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间的格式
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //将字符串转换为时间对象
    NSDate *tempDate = [dateFormatter dateFromString:time];
    //字符串转成时间戳,精确到毫秒*1000
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];
    return timeStr;
}

/** 根据需求 距离现在多少秒 */
+ (NSInteger)getSecondBefore:(NSString *)timeStamp {
    if (!ValidStr(timeStamp)) {
        return 0;
    }
    NSDate *afterDate = [NSDate date];
    //时间格式
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 截止时间字符串格式  早的时间
    NSString *firstDateStr = [NSDate getTimeWithTimeInterval:timeStamp];
    // 当前时间字符串格式  晚的时间
    NSString *afterDateStr = [dateFomatter stringFromDate:afterDate];
    // 截止时间data格式
    NSDate *firstDate = [dateFomatter dateFromString:firstDateStr];
    // 当前时间data格式
    afterDate = [dateFomatter dateFromString:afterDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差        先是 早的时间      后是 晚的时间
    NSDateComponents *dateCom = [calendar components:unit fromDate:firstDate toDate:afterDate options:0];
    NSLog(@"======%ld年%ld月%ld日%ld时%ld分%ld秒  之前 ", dateCom.year, dateCom.month, dateCom.day, dateCom.hour, dateCom.minute, dateCom.second);

    //秒转小时
    NSInteger day = dateCom.hour * 3600 *24;
    NSInteger hour = dateCom.hour * 3600;
    NSInteger min = dateCom.minute * 60;
    
    NSInteger secondTime = day + hour + min + dateCom.second;
    
    return  secondTime;
}

/** 根据需求 返回多少小时前 */
+ (NSString *)getHoursBefore:(NSString *)timeStamp {
    if (!ValidStr(timeStamp)) {
        return @"";
    }
    //获取当前时时间戳 1611738221778
    NSInteger currentTime = [[NSDate currentTimeStamp] integerValue];
    NSInteger createTime = [timeStamp integerValue];
    //时间差
    NSTimeInterval time = currentTime - createTime;
    //秒转小时
    NSInteger hours = time/3600/1000;
    if (hours < 1) {
        //        NSString *stirng = [NSDate timeWithTimeInterval:timeStamp format:@"HH:mm"];
        return [NSString stringWithFormat:@"刚刚"];
    }
    if (hours < 12) {
        //        NSString *stirng = [NSDate timeWithTimeInterval:timeStamp format:@"HH:mm"];
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    if (hours < 24) {
        NSString *stirng = [NSDate getTimeWithTimeInterval:timeStamp format:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@",stirng];
    }
    return [NSDate getTimeWithTimeInterval:KString(@"%.0f",time) format:@"MM-dd HH:mm"];
}



/** 根据需求格式化时间 今天/昨天 */
+ (NSString *)getDateForTime:(NSString *)timeStamp {
    if (!ValidStr(timeStamp)) {
        return @"";
    }
    //获取当前时时间戳 1611738221778
    NSInteger currentTime = [[NSDate currentTimeStamp] integerValue];
    NSInteger createTime = [timeStamp integerValue];
    //时间差
    NSTimeInterval time = currentTime - createTime;
    //秒转小时
    NSInteger hours = time/3600/1000;
    if (hours < 24) {
        NSString *stirng = [NSDate getTimeWithTimeInterval:timeStamp format:@"HH:mm"];
        return [NSString stringWithFormat:@"今天 %@",stirng];
    }
    if (hours < 48) {
        NSString *stirng = [NSDate getTimeWithTimeInterval:timeStamp format:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@",stirng];
    }
    return [NSDate getTimeWithTimeInterval:KString(@"%.0f",time) format:@"MM-dd HH:mm"];
    
    //秒转天数
    //    NSInteger days = time/3600/24;
    //    if (days < 30) {
    //        return [NSString stringWithFormat:@"%ld天前",days];
    //    }
    //秒转月
    //    NSInteger months = time/3600/24/30;
    //    if (months < 12) {
    //        return [NSString stringWithFormat:@"%ld月前",months];
    //    }
    //    //秒转年
    //    NSInteger years = time/3600/24/30/12;
    //    return [NSString stringWithFormat:@"%ld年前",years];
}


/** 根据需求 时间戳准转换耗时 天、时、分钟 */
+ (NSString *)getUseDate:(NSInteger)interval {
    if (interval <= 0) {
        return @"";
    }
    //秒转小时
    NSInteger useTime = interval/1000;
    NSInteger day = useTime / (3600 * 24);
    NSInteger hour = useTime % (3600 * 24) / 3600;
    NSInteger min = useTime % (3600 * 24) % 3600 /60;
    
    NSString *useTimeStr = @"";
    if (day > 0) {
        //        NSString *stirng = [NSDate timeWithTimeInterval:timeStamp format:@"HH:mm"];
        useTimeStr = [NSString stringWithFormat:@"%ld天", day];
    }
    if (day > 0 || hour > 0) {
        //        NSString *stirng = [NSDate timeWithTimeInterval:timeStamp format:@"HH:mm"];
        useTimeStr = [NSString stringWithFormat:@"%@%ld小时",useTimeStr, hour];
    }
    if (min > 1) {
        useTimeStr = [NSString stringWithFormat:@"%@%ld分钟",useTimeStr, min];
    }
    if (day == 0 && hour == 0 && min < 1.1) {
        useTimeStr = @"刚刚";
    }
    return useTimeStr;
}



@end
