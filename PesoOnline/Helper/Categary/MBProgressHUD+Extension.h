//
//  MBProgressHUD+Extension.h
//
//  Created by mc on 2018/4/13.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)

+ (MBProgressHUD *)showHUD;

/**
 *  默认转圈
 */
+ (MBProgressHUD *)showHUD:(UIView *)view;

/**
 *  默认转圈文字
 */
+ (MBProgressHUD *)showHudMessage:(NSString *)message;

/**
 *Progress
 */
+ (MBProgressHUD *)showProgress:(UIView *)view progress:(void (^)(MBProgressHUD * _Nullable hud))progressBlock;

/**
 *  环形转圈
 */
+ (MBProgressHUD *)showRoundLoadingToView:(UIView *)view;
/**
 *  显示文本信息
 */
+ (void)showMessage:(NSString *_Nullable)message;
/**
 *  显示成功信息
 */
+ (void)showSuccess:(NSString *_Nullable)success;
/**
 *  显示失败信息
 */
+ (void)showError:(NSString *_Nullable)error;
/**
 *  显示警告
 */
+ (void)showWarn:(NSString *_Nullable)warn;
/**
 *  帧动画
 */
+ (MBProgressHUD *)showCustomAnimate:(NSString *)text imageName:(NSString *)imageName imageCounts:(NSInteger)imageCounts view:(UIView *)view;

/**
 *  正确动画MBProgressHUD
 */
+ (void)showAnimalSuccessViewWithText:(NSString *)text view:(UIView *)view;
/**
 *  错误MBProgressHUD
 */
+ (void)showAnimalErrorViewWithText:(NSString *)text view:(UIView *)view;


#pragma mark 隐藏
/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD;
/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view;


@end
