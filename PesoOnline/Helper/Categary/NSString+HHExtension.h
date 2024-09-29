//
//  NSString+Extension.h
//
//  Created by mc on 2018/4/9.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HHExtension)

/**
 字符串为空 返回@" "
 */
- (NSString *)hh_sting;
+ (NSString *)hh_sting:(NSString *)string;

/**
 根据空格截断取第一个元素
 */
- (NSString *)ectuTime;

/**
 一个或者多个空格也算是空
 */
- (BOOL)stringIsEmpty;

/**
 截取字符串
 */
- (NSString *)subTextWithRange:(NSRange)range;

/**
 字典转链接（参数）
 */
- (NSString *)keyValueStringWithDict:(NSDictionary *)dict;

/**
 * 获取一个字符在字符串中出现的所有位置 返回一个被NSValue包装的NSRange数组
 */
- (NSArray *)rangeOfSubString:(NSString *)subStr;

/**
 仅保留数字
 */
- (NSInteger)keepNumbers;

/**
 保留2位小数
 */
- (NSString *)safeString;

/**
 隐藏手机号中间4位
 */
- (NSString *)encryptPhone;
- (NSString *)encryptNumber:(NSRange)range;

/**
 距离某一个时间多少天
 */
- (int)todayFormatDate;

/**
 判断是否过期
 */
- (BOOL)isExpiryTime:(NSString *)endTime;


/**
 MD5加密
 */
- (NSString *)md5;


/**
 字符串编码
 */
- (NSString *)encodeParameter;


/**
 每隔四位添加一个空格
 */
- (NSString *)formatterBankCardNum;

/**
 金额千分位显示
 */
- (NSString *)toThousandsText;

/**
 *  判断字符串中是否存在emoji
 * @return YES(含有表情)
 */
- (BOOL)stringContainsEmoji;


//去除表情规则
//  \u0020-\\u007E  标点符号，大小写字母，数字
//  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
//  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
//  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
//  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
//  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
// 注：对照表 http://blog.csdn.net/hherima/article/details/9045765
- (NSString *)noEmoji;


/** *  判断字符串中是否包含非法字符 *
 @param content 需要判断的字符串 *
 @return Yes: 包含；No: 不包含 */
- (BOOL)hasIllegalCharacter:(NSString *)content;


/**
 解析 URL
 @return 字典
 */
- (NSDictionary *)getUrlParameter;


@end
