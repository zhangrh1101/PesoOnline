//
//  UIView+HHExtension.h
//  HaoWeibo
//
//  Created by Zzzzzzzzz💤 on 16/3/9.
//  Copyright © 2016年 Zzzzzzzzz💤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    HHShadowPathLeft = 0,
    HHShadowPathRight,
    HHShadowPathTop,
    HHShadowPathBottom,
    HHShadowPathNoTop,
    HHShadowPathAllSide
    
} HHShadowPathSide;

@interface UIView (HHExtension)

/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat x;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat y;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat width;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat height;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat centerX;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat centerY;
/** 获取/设置view的x坐标 */
@property (nonatomic, assign) CGFloat top;
/** 获取/设置view的左边坐标 */
@property (nonatomic, assign) CGFloat left;
/** 获取/设置view的底部坐标Y */
@property (nonatomic, assign) CGFloat bottom;
/** 获取/设置view的右边坐标 */
@property (nonatomic, assign) CGFloat right;
/** 获取/设置view的size */
@property (nonatomic, assign) CGSize size;
/** 获取/设置view的origin */
@property (nonatomic, assign) CGSize origin;
/** 获取/设置view的x中点 */
@property (nonatomic, assign) CGFloat middleX;
/** 获取/设置view的y中点 */
@property (nonatomic, assign) CGFloat middleY;
@property (nonatomic, assign) CGFloat tail;

/** 屏幕大小 */
CGSize HHScreenSize(void);
/** 屏幕宽度 */
CGFloat HHScreenWidth(void);
/** 屏幕高度 */
CGFloat HHScreenHeight(void);
/** 屏幕bounds */
CGRect HHScreenBounds(void);

/** 设置比例 */
CGFloat KScale(CGFloat size);
/** 获取相对屏幕的宽度 */
CGFloat HHAutoWidth(CGFloat width);
/** 获取相对屏幕的高度 */
CGFloat HHAutoHeight(CGFloat height);
/** 获取相对大小 */
CGSize HHSize(CGFloat width, CGFloat height);
/** 获取相对布局 */
UIEdgeInsets HHEdge(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

/** 是否是Ipad */
BOOL HH_IsIPad(void);

/** 是否是苹果X */
BOOL HH_IsIphoneX(void);
/** 是否是苹果XR */
BOOL HH_IsIphoneXR(void);
/** 是否是苹果XS */
BOOL HH_IsIphoneXS(void);
/** 是否是苹果XS_Max */
BOOL HH_IsIphoneXS_Max(void);
/** 是否是苹果11 */
BOOL HH_IsIphone11(void);
/** 是否是苹果11_Pro  */
BOOL HH_IsIphone11_Pro(void);
/** 是否是苹果11_Pro_Max */
BOOL HH_IsIphone11_Pro_Max(void);
/** 是否是苹果12_Mini */
BOOL HH_IsIphone12_Mini(void);
/** 是否是苹果12 */
BOOL HH_IsIphone12(void);
/** 是否是苹果12_Pro */
BOOL HH_IsIphone12_Pro(void);
/** 是否是苹果12_Pro_Max */
BOOL HH_IsIphone12_Pro_Max(void);
/** 是否是苹果X系列(刘海屏系列) */
BOOL HH_IsIphoneX_ALL(void);

/**
 *  截屏生成图片
 */
- (UIImage *)napshotImage;

/**
 *  给UIView添加事件响应
 *
 *  @param target 响应者
 *  @param action 响应事件
 */
- (void)addTapGestureWithTarget:(id)target action:(SEL)action;

/**
 *  给UIView添加长按事件响应
 *
 *  @param target 响应者
 *  @param action 响应事件
 */
- (void)addLongPressGestureWithTarget:(id)target action:(SEL)action;


/**
 获取当前View所在控制器
 */
- (UIViewController *)viewController;


/*
 * shadowColor 阴影颜色
 * shadowOpacity 阴影透明度，默认0
 * shadowRadius  阴影半径，默认3
 * shadowPathSide 设置哪一侧的阴影，
 * shadowPathWidth 阴影的宽度，
 */

-(void)setShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(HHShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;


@end
