//
//  UIColor+HHExtension.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HHExtension)

/** 以下为C语言 语法快捷调用颜色设置 **/

/** rbg颜色 */
UIColor * _Nullable HH_RGBColor(NSInteger r, NSInteger g, NSInteger b);
/** rbg颜色 带alpha */
UIColor * _Nullable HH_RGBColorWithAlpha(NSInteger r, NSInteger g, NSInteger b, CGFloat alpha);
/** 十六进制颜色  */
UIColor * _Nullable HH_HexColor(NSString * _Nullable hexString);
/** 十六进制颜色 带alpha */
UIColor * _Nullable HH_HexColorAlpha(NSString * _Nullable hexString, CGFloat alpha);



/**
 根据图片获取图片的主色调
 */
+ (UIColor *)mainColor:(UIImage *)aImage;

@end


@interface NSString (hh_StringTansformer)

/**
 检查十六进制字符串比如#fff,并给转化成十六进制字符串,比如#ffffff
 
 @return 返回标准的7位十六进制字符串或者初始化一个字符串为十六进制字符串
 */
- (nonnull NSString *)hh_HexStringTransformFromThreeCharacters;

@end

NS_ASSUME_NONNULL_END
