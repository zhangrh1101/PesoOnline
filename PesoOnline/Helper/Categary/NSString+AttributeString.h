//
//  NSString+AttributeString.h
//
//  Created by mc on 2018/4/17.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AttributeString)

/**
 小图标加文字
 */
+ (NSAttributedString *)attributeString:(NSString *)string font:(UIFont *)font textColor:(UIColor *)textColor imageName:(NSString *)imageName
                              imageSize:(CGSize)imageSize;

/**
 回复评论名字拼接
 */
+ (NSAttributedString *)attributeString:(NSString *)firstStr firstColor:(UIColor *)firstColor secondStr:(NSString *)secondStr secondColor:(UIColor *)secondColor imageName:(NSString *)imageName imageSize:(CGSize)imageSize;

/**
 结尾多一个百分比
 */
+ (NSAttributedString *)attributeRate:(NSString *)rate RatePlus:(NSString *)rateplus;


/**
 两部分大小不一样的属性字带%
 */
+ (NSAttributedString *)attributeRates:(NSArray *)rates Fonts:(NSArray *)fonts colors:(NSArray *)colors;

/**
 需要改变颜色的文字
 */
+ (NSAttributedString *)attributeString:(NSString *)allText needText:(NSString *)needText font:(UIFont *)font color:(UIColor *_Nullable)color;
/**
 需要改变颜色的文字数组
 */
+ (NSAttributedString *)attributeString:(NSString *)allText needTexts:(NSArray *)needTexts font:(UIFont *)font color:(UIColor *_Nullable)color;

/**
 关键文字加下划线
 */
+ (NSAttributedString *)attributeString:(NSString *)allText lineText:(NSString *)lineText font:(UIFont *)font;

/**
 关键文字加删除线
 */
+ (NSAttributedString *)attributeString:(NSString *)allText deletelineText:(NSString *)lineText font:(UIFont *)font;

/**
 两部分大小不一样的属性字
 */
+ (NSAttributedString *)attributeStr1:(NSString *)str1 font1:(UIFont *)font1 str2:(NSString *)str2 font2:(UIFont *)font2;

/**
 两部分大小不一样带颜色的属性字
 */
+ (NSAttributedString *)attributeStr1:(NSString *)str1 font1:(UIFont *)font1 color1:(UIColor *)color1 str2:(NSString *)str2 font2:(UIFont *)font2 color2:(UIColor *)color2;


@end
