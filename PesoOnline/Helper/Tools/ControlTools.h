//
//  ControlTools.h
//
//  Created by Zzzzzzzzz💤 on 2017/9/26.
//  Copyright © 2017年 ZRH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControlTools : NSObject

//获取当前活动的navigationcontroller
+ (UINavigationController *)navigationViewController;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;



/**
 UILabel
 */
+ (UILabel *_Nullable)labelWithText:(NSString *_Nullable)text textColor:(UIColor *_Nullable)textColor font:(UIFont *_Nullable)font;

+ (UILabel *_Nullable)labelWithText:(NSString *_Nullable)text textColor:(UIColor *_Nullable)textColor font:(UIFont *_Nullable)font textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *_Nullable)labelWithText:(NSString *_Nonnull)text textColor:(UIColor *_Nullable)textColor font:(UIFont *_Nullable)font backColor:(UIColor *_Nullable)backgroundColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines;



/**
 UIButton
 */
+ (UIButton *_Nullable)buttonWithImage:(NSString *_Nullable)image selImage:(NSString *_Nullable)selImage bgImage:(NSString *_Nullable)bgImage selBgImage:(NSString *_Nullable)selBgImage upInsideAction:(void(^_Nullable)(id  _Nonnull sender))actionBlock;

+ (UIButton *_Nullable)buttonWithImage:(NSString *_Nullable)image title:(NSString *_Nullable)title titleColor:(UIColor *_Nullable)titleColor font:(UIFont *_Nullable)font upInsideAction:(void(^_Nullable)(id  _Nonnull sender))actionBlock;

+ (UIButton *_Nullable)buttonWithImage:(NSString *_Nullable)image selImage:(NSString *_Nullable)selImage title:(NSString *_Nullable)title selTitle:(NSString *_Nonnull)selTitle titleColor:(UIColor *_Nullable)titleColor selTitleColor:(UIColor *_Nullable)selTitleColor font:(UIFont *_Nullable)font upInsideAction:(void(^_Nonnull)(id  _Nonnull sender))actionBlock;

+ (UIButton *_Nullable)buttonWithTitle:(NSString *_Nullable)title selTitle:(NSString *_Nullable)selTitle titleColor:(UIColor *_Nullable)titleColor selTitleColor:(UIColor *_Nullable)selTitleColor font:(UIFont *_Nullable)font bgImage:(NSString *_Nullable)bgImage selBgImage:(NSString *_Nullable)selBgImage upInsideAction:(void(^_Nullable)(id  _Nonnull sender))actionBlock;

+ (UIButton *_Nullable)buttonWithImage:(NSString *_Nullable)image selImage:(NSString *_Nullable)selImage bgImage:(NSString *_Nullable)bgImage selBgImage:(NSString *_Nullable)selBgImage title:(NSString *_Nullable)title SelTitle:(NSString *_Nullable)selTitle titleColor:(UIColor *_Nullable)titleColor  selTitleColor:(UIColor *_Nonnull)selTitleColor font:(UIFont *_Nullable)font upInsideAction:(void(^_Nullable)(id  _Nonnull sender))actionBlock;


/**
 拉伸图片
 */
+ (UIImage *_Nullable)resizableImageWithName:(NSString *_Nullable)imageName;

+ (NSAttributedString *_Nullable)shuxinziTiWithStr:(NSString *_Nullable)str strFontSize:(CGFloat)size lineSpace:(CGFloat)space;

+ (NSAttributedString *_Nullable)shuxinziTiWithStr:(NSString *_Nullable)str strFontSize:(CGFloat)size lineSpace:(CGFloat)space charaSpace:(long)sPace textColor:(UIColor *_Nullable)color;

+ (CGFloat)heightWithAttributedString:(NSAttributedString *_Nullable)attributedString labelWidth:(CGFloat)width;

+ (CGFloat)widthWithAttributedString:(NSAttributedString *_Nullable)attributedString labelHeight:(CGFloat)height;



@end








