//
//  UIView+Border.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/13.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HHBorderTypeTop,
    HHBorderTypeLeft,
    HHBorderTypeRight,
    HHBorderTypeBottom
} HHBorderType;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Border)

/**
 添加圆角
 */
- (void)cornerRadius:(CGFloat)radius;
- (void)addCornerRadius:(CGFloat)radius;
- (void)addCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 添加阴影
 */
- (void)addShadowColor:(UIColor *)shadowColor
         shadowOpacity:(CGFloat)shadowOpacity
          shadowOffset:(CGSize)shadowOffset
          shadowRadius:(CGFloat)shadowRadius;

/*
 任意圆角 带边框大小颜色 ； 当设置borderWidth为0 或者borderColor为透明色 移除layer
 */
- (void)shapeLayerCornerRadiusWithRectCorner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth;

/**
 添加边框
 */
-(void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

/**
 添加单边框 可设置颜色 大小 方向
 */
- (void)addBorderLayerWithColor:(UIColor *)color borderWidth:(CGFloat) borderWidth borderType:(HHBorderType)boderType;

/**
 绘制虚线边框
 */
- (void)addDottedLineWithColor:(UIColor *)color;

- (void)drawBottomLine:(float)margin left:(float)leftMargin right:(float)rightMargin;

/**
 渐变色 上下
 */
- (void)addGradientTopColor:(UIColor *)startColor endColor:(UIColor *)endColor;
/**
 渐变色 左右
 */
- (void)addGradientLeftColor:(UIColor *)startColor rightColor:(UIColor *)endColor;

/**
 自定义渐变色 分割点
 */
- (void)addGradientBeginColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint
                      locations:(NSArray *)locations;

@end

NS_ASSUME_NONNULL_END
