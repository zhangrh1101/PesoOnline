//
//  NSString+Extension.m
//
//  Created by mc on 2018/4/9.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import "NSString+HHExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import <SAMKeychain.h>

@implementation NSString (HHExtension)

/**
 字符串为空 返回@" "
 */
- (NSString *)hh_sting {
    if ([HH_Utilities isBlankString:self]) {
        return @"";
    }
    return self;
}
+ (NSString *)hh_sting:(NSString *)string {
    if ([HH_Utilities isBlankString:string]) {
        return @"";
    }
    return string;
}

/**
 根据空格截断取第一个元素
 */
- (NSString *)ectuTime{
    
    if (!self.length) {
        return self;
    }
    return [[self componentsSeparatedByString:@" "] firstObject];
}


#pragma mark - 5. Check 字符串空判断
// 一个或者多个空格也算是空
- (BOOL)stringIsEmpty {
    
    if (!self) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}


/**
 截取字符串
 */
- (NSString *)subTextWithRange:(NSRange)range {
    
    if (self.length <= 0) {
        return @"";
    }
    if (self.length > (range.location + range.length)) {
        return [NSString stringWithFormat:@"%@...", [self substringWithRange:range]];
    }
    return self;
}


/**
 字典转链接（参数）
 */
- (NSString *)keyValueStringWithDict:(NSDictionary *)dict
{
    if (dict == nil) {
        return nil;
    }
    NSMutableString *string = [NSMutableString stringWithString:@"?"];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"%@=%@&",key,obj];
    }];

    if ([string rangeOfString:@"&"].length) {
        [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    }
    
    NSString *path = [NSString stringWithFormat:@"%@%@",self, string];
    return path;
}



/*
 * 获取一个字符在字符串中出现的所有位置 返回一个被NSValue包装的NSRange数组
 */
- (NSArray *)rangeOfSubString:(NSString *)subStr {
    
    if (subStr == nil && [subStr isEqualToString:@""]) {
        return nil;
    }
    NSMutableArray *rangeArray = [NSMutableArray array];
    NSString *string1 = [self stringByAppendingString:subStr];
    NSString *temp;
    for (int i = 0; i < self.length; i ++) {
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        if ([temp isEqualToString:subStr]) {
            NSRange range = {i,subStr.length};
            [rangeArray addObject:[NSValue valueWithRange:range]];
        }
    }
    return rangeArray;
}

/**
 仅保留数字
 */
- (NSInteger)keepNumbers{
    
    return [[[self componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""] integerValue];
}


/**
 保留2位小数
 */
- (NSString *)safeString{
    
    NSString *str = [NSString stringWithFormat:@"%.2f",self.doubleValue];
    return [str decimalNumberMutiplyWithString:@"0.00"];
}


/**
 减法
 */
-(NSString*)decimalNumberMutiplyWithString:(NSString*)multiplierValue{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *product = [multiplicandNumber decimalNumberBySubtracting:multiplierNumber];
    return [product stringValue];
}


/**
 距离某一个时间多少天
 */
- (int)todayFormatDate{

    //现在的时间
    NSDate * nowDate = [NSDate date];
    //要转换的字符串
    //字符串转NSDate格式的方法
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *toDate = [formatter dateFromString:self]; // 传入的时间
    //计算两个中间差值(秒)
    NSTimeInterval timeInterval = [nowDate timeIntervalSinceDate:toDate];
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)timeInterval)/(3600*24);  //一天是24小时*3600秒
    NSString * dateValue = [NSString stringWithFormat:@"%i",days];
    
    //abs([dateValue intValue]) 绝对值
    return [dateValue intValue];
}


/**
 判断是否过期
 */
- (BOOL)isExpiryTime:(NSString *)endTime{
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:endTime];
    
    NSTimeInterval time = [date timeIntervalSinceNow];
    
    if (time < 0) {
        return NO;
    }else{
        return YES;
    }
}


/**
 隐藏手机号中间4位
 */
- (NSString *)encryptPhone{
    
    if (self.length > 7) {
        NSString *phone = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return phone;
    }
    return self;
}

/**
 隐藏号码为*号 位置
 */
- (NSString *)encryptNumber:(NSRange)range{
    
    if (self.length > 7) {
        NSString *phone = [self stringByReplacingCharactersInRange:range withString:@"****"];
        return phone;
    }
    return self;
}



+ (NSString *)simpleNumber:(NSString *)numberStr{
    
    NSString *numString = numberStr;
    NSInteger allNumber = numString.integerValue;
    NSInteger thousand;
    if (allNumber > 10000) {
        if (allNumber%10000/1000 > 0) {
            thousand = allNumber%10000/1000;
            numString = [NSString stringWithFormat:@"%ld.%ld万",allNumber/10000,thousand];
        }else{
            thousand = allNumber%10000/100 ? allNumber%10000/100 : 0;
            if (thousand > 0) {
                numString = [NSString stringWithFormat:@"%ld.0%ld万",allNumber/10000,thousand];
            }else{
                numString = [NSString stringWithFormat:@"%ld万",allNumber/10000];
            }
        }
    }else{
        numString = [NSString stringWithFormat:@"%@",numString];
    }
    
    return numString;
}



/**
 MD5加密
 */
- (NSString *)md5{
    // 判断传入的字符串是否为空
    if (! self) return nil;
    // 转成utf-8字符串
    const char *cStr = self.UTF8String;
    // 设置一个接收数组
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    // 对密码进行加密
    CC_MD5(cStr, (CC_LONG) strlen(cStr), result);
    NSMutableString *md5Str = [NSMutableString string];
    // 转成32字节的16进制
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}


/**
 字符串编码
 */
- (NSString *)encodeParameter {
    
    CFStringRef encodeParaCf = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    NSString *encodePara = (__bridge NSString *)(encodeParaCf);
    CFRelease(encodeParaCf);
    return encodePara;
}



/**
 每隔四位添加一个空格
 */
- (NSString *)formatterBankCardNum{
    
    NSString *tempStr = self;
    NSInteger count = (tempStr.length / 4);
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
  
    for (int i=0; i < count; i++) {
        [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(i*4, 4)]];
    }

    if (self.length%4 != 0) {
         [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(self.length-self.length%4, self.length%4)]];
    }
    
    if (tmpStrArr.count > 1) {
        for (int i=0; i < tmpStrArr.count-1; i++) {
            [tmpStrArr replaceObjectAtIndex:i withObject:@"****"];
        }
        tempStr = [tmpStrArr componentsJoinedByString:@" "];
    }
    
    return tempStr;
}


/**
 金额千分位显示
 */
- (NSString *)toThousandsText{
    
    if(!self || [self floatValue] == 0){
        return @"0.00";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"###,##0.00;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    }
    return @"";
}


/**
 * 判断 字母、数字、中文
 */
- (BOOL)isInputRuleAndNumber:(NSString *)str
{
    NSString *other = @"➋➌➍➎➏➐➑➒";     //九宫格的输入值
    unsigned long len=str.length;
    for(int i=0;i<len;i++)
    {
        unichar a=[str characterAtIndex:i];
        if(!((isalpha(a))
             ||(isalnum(a))
             //             ||((a=='_') || (a == '-')) //判断是否允许下划线，昵称可能会用上
             ||((a==' '))                 //判断是否允许空格
             ||((a >= 0x4e00 && a <= 0x9fa6))
             ||([other rangeOfString:str].location != NSNotFound)
             ))
            return NO;
    }
    return YES;
}


/**
 * 判断字符串中是否存在emoji
 * @return YES(含有表情)
 */
- (BOOL)stringContainsEmoji {
    
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}



- (NSString *)noEmoji {
    //去除表情规则
    //  \u0020-\\u007E  标点符号，大小写字母，数字
    //  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
    //  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
    //  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
    //  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
    //  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
    // 注：对照表 http://blog.csdn.net/hherima/article/details/9045765
    
    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSString* result = [expression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
    
    return result;
}



/** 判断字符串中是否包含非法字符 *
 @param content 需要判断的字符串 *
 @return Yes: 包含；No: 不包含 */
- (BOOL)hasIllegalCharacter:(NSString *)content{
    // 特殊字符
    NSString *str = @"[^%@《》/#^*&¥'~=$<>`\x22]+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}



/**
 解析 URL
 @return 字典
 */
- (NSDictionary *)getUrlParameter {
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc] init];
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:[NSURL URLWithString:self].absoluteString];
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.value && obj.name) {
            [parm setObject:obj.value forKey:obj.name];
        }
    }];
    return parm;
}




@end




