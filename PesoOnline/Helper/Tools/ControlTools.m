//
//  ControlTools.m
//  DuoLa
//
//  Created by Zzzzzzzzz💤 on 2017/9/26.
//  Copyright © 2017年 ZRH. All rights reserved.
//

#import "ControlTools.h"
#import "HH_Utilities.h"

@implementation ControlTools

/**
 获取当前活动的navigationcontroller
 */
+ (UINavigationController *)navigationViewController
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    if ([window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)window.rootViewController;
    }
    else if ([window.rootViewController isKindOfClass:[UITabBarController class]])
    {
        UIViewController *selectVc = [((UITabBarController *)window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)selectVc;
        }
    }
    return nil;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *temp in windows) {
            if (temp.windowLevel == UIWindowLevelNormal) {
                window = temp;
                break;
            }
        }
    }
    //取当前展示的控制器
    result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    //如果为UITabBarController：取选中控制器
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    //如果为UINavigationController：取可视控制器
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}



/**
 UILabel
 */

/**
 创建一个纯文字标签
 
 @param text 文字
 @param textColor 文字颜色
 @param font 文字大小
 */
+ (UILabel *_Nullable)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *_Nullable)font {
    
    return [ControlTools labelWithText:text textColor:textColor font:font backColor:nil textAlignment:0 numberOfLines:0];
}


/**
 创建一个纯文字NSTextAlignment标签
 
 @param text 文字
 @param textColor 文字颜色
 @param font 文字大小
 @param textAlignment 居中
 */
+ (UILabel *_Nullable)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *_Nullable)font textAlignment:(NSTextAlignment)textAlignment{
    
    return [ControlTools labelWithText:text textColor:textColor font:font backColor:nil textAlignment:textAlignment numberOfLines:0];
}


/**
 快速创建标签
 
 @param text 文字
 @param textColor 文字颜色
 @param font 文字大小
 @param backgroundColor 背景颜色
 @param textAlignment 居中
 @param numberOfLines 行数
 */
+ (UILabel *_Nullable)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *_Nullable)font backColor:(UIColor *)backgroundColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines
{
    UILabel *label = [[UILabel alloc] init];
    if (text) {
        label.text = text;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    if (font) {
        label.font = font;
    }
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    if (textAlignment) {
        label.textAlignment = textAlignment;
    }
    label.numberOfLines = numberOfLines>=0 ? numberOfLines : 1;
    //    label.font = [UIFont fontWithName:@"STSongti-SC-Regular" size:kNum(fontSize)];
    
    return label;
}



/**
 UIButton
 */
/**
 创建带图片/背景图片的按钮
 
 @param image 图片
 @param selImage 选中图片
 @param bgImage 背景图片
 @param selBgImage 选中背景图片
 @param actionBlock 点击事件
 */
+ (UIButton *_Nullable)buttonWithImage:(NSString *_Nullable)image selImage:(NSString *_Nullable)selImage bgImage:(NSString *_Nullable)bgImage selBgImage:(NSString *_Nullable)selBgImage upInsideAction:(void(^_Nullable)(id  _Nonnull sender))actionBlock{
    
    return [ControlTools buttonWithImage:image selImage:selImage bgImage:bgImage selBgImage:selBgImage title:nil selTitle:nil titleColor:nil selTitleColor:nil font:0 upInsideAction:actionBlock];
}

/**
 创建普通文字/图片的按钮
 
 @param image 图片
 @param title 文字
 @param titleColor 字体颜色
 @param font 字体大小
 @param actionBlock 点击事件
 */
+ (UIButton *_Nullable)buttonWithImage:(NSString *_Nullable)image title:(NSString *_Nullable)title titleColor:(UIColor *_Nullable)titleColor font:(UIFont *_Nullable)font upInsideAction:(void(^_Nullable)(id  _Nonnull sender))actionBlock{
    
    return [ControlTools buttonWithImage:image selImage:nil title:title selTitle:nil titleColor:titleColor selTitleColor:nil font:font upInsideAction:actionBlock];
}


/**
 创建切换状态文字/图片没有背景的按钮
 
 @param image 图片
 @param selImage 选中图片
 @param title 文字
 @param titleColor 字体颜色
 @param selTitleColor 选中字体颜色
 @param font 字体大小
 @param actionBlock 点击事件
 */
+ (UIButton *)buttonWithImage:(NSString *)image selImage:(NSString *)selImage title:(NSString *)title selTitle:(NSString *)selTitle titleColor:(UIColor *)titleColor selTitleColor:(UIColor *)selTitleColor font:(UIFont *_Nullable)font upInsideAction:(void(^)(id  _Nonnull sender))actionBlock{
    
    return [ControlTools buttonWithImage:image selImage:selImage bgImage:nil selBgImage:nil title:title selTitle:selTitle titleColor:titleColor selTitleColor:selTitleColor font:font upInsideAction:actionBlock];
}



/**
 创建切换状态的文字/只有背景图片的按钮
 @param title 文字
 @param selTitle 选中文字
 @param titleColor 字体颜色
 @param selTitleColor 选中字体颜色
 @param font 字体大小
 @param bgImage 背景图片
 @param selBgImage 选中背景图片
 @param actionBlock 点击事件
 */
+ (UIButton *_Nullable)buttonWithTitle:(NSString *_Nullable)title selTitle:(NSString *_Nullable)selTitle titleColor:(UIColor *_Nullable)titleColor selTitleColor:(UIColor *_Nullable)selTitleColor font:(UIFont *_Nullable)font bgImage:(NSString *_Nullable)bgImage selBgImage:(NSString *_Nullable)selBgImage upInsideAction:(void(^_Nullable)(id  _Nonnull sender))actionBlock {
    
    return [ControlTools buttonWithImage:nil selImage:nil bgImage:nil selBgImage:nil title:title selTitle:selTitle titleColor:titleColor selTitleColor:selTitleColor font:font upInsideAction:actionBlock];
}



/**
 快速创建按钮
 
 @param image 图片
 @param selImage 选中图片
 @param bgImage 背景图片
 @param selBgImage 选中背景图片
 @param title 文字
 @param selTitle 选中文字
 @param titleColor 字体颜色
 @param selTitleColor 选中字体颜色
 @param font 字体大小
 @param actionBlock 点击事件
 */
+ (UIButton *)buttonWithImage:(NSString *)image selImage:(NSString *)selImage bgImage:(NSString *)bgImage selBgImage:(NSString *)selBgImage title:(NSString *)title selTitle:(NSString *)selTitle titleColor:(UIColor *)titleColor  selTitleColor:(UIColor *)selTitleColor font:(UIFont *_Nullable)font upInsideAction:(void(^)(id  _Nonnull sender))actionBlock
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:actionBlock];
    
    if (![HH_Utilities isBlankString:image]) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (![HH_Utilities isBlankString:selImage]) {
        [button setImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:selImage] forState:UIControlStateHighlighted];
    }
    if (![HH_Utilities isBlankString:bgImage]) {
        [button setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    }
    if (![HH_Utilities isBlankString:selBgImage]) {
        [button setBackgroundImage:[UIImage imageNamed:selBgImage] forState:UIControlStateSelected];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (selTitleColor) {
        [button setTitleColor:selTitleColor forState:UIControlStateSelected];
    }
    if (![HH_Utilities isBlankString:title]) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (![HH_Utilities isBlankString:selTitle]) {
        [button setTitle:selTitle forState:UIControlStateSelected];
    }
    if (font) {
        button.titleLabel.font = font;
        button.titleLabel.numberOfLines = 0;
    }
    button.titleLabel.lineBreakMode =  NSLineBreakByTruncatingTail;
    [button setAdjustsImageWhenHighlighted:NO];
    
    return button;
}






+ (NSAttributedString *)attributeWithStr:(NSString *)str strFontSize:(CGFloat)size lineSpace:(CGFloat)space
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, str.length)];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    
    return attributedString;
    
}

+ (NSAttributedString *)attributeWithStr:(NSString *)str strFontSize:(CGFloat)size lineSpace:(CGFloat)space charaSpace:(long)sPace textColor:(UIColor *)color
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    //    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"ArialMT" size:size] range:NSMakeRange(0, str.length)];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    //NSBackgroundColorAttributeName: [UIColor orangeColor],//只有在有字的的部分有橘黄色的背景
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&sPace);
    NSDictionary *attributes1 = @{
        NSForegroundColorAttributeName:color,
        NSFontAttributeName:[UIFont systemFontOfSize:size],
        
        NSKernAttributeName:(__bridge id _Nonnull)(num)};//指定了每个字母之间的距离（数值越小字间的距离也越紧密）
    
    [attributedString addAttributes:attributes1 range:NSMakeRange(0, str.length)];
    
    return attributedString;
    
}

+ (CGFloat)heightWithAttributedString:(NSAttributedString *)attributedString labelWidth:(CGFloat)width
{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                                 options:options
                                                 context:nil];
    return ceilf(rect.size.height);
}

+ (CGFloat)widthWithAttributedString:(NSAttributedString *)attributedString labelHeight:(CGFloat)height
{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                                 options:options
                                                 context:nil];
    return ceilf(rect.size.width);
}






@end
