//
//  MBProgressHUD+Extension.m
//
//  Created by mc on 2018/4/13.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

#define imageMargin  22.5
#define imageWidth   45

@implementation MBProgressHUD (Extension)

+ (MBProgressHUD *)showHUD{
    
    return [self showHUD:nil];
}

/**
 *HUD
 */
+ (MBProgressHUD *)showHUD:(UIView *)view {
    
    if (view == nil) view = [ControlTools getCurrentVC].view;
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    HUD.userInteractionEnabled = NO;
    
    HUD.removeFromSuperViewOnHide = YES;
//    [HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    return HUD;
}

/**
 *  默认转圈文字
 */
+ (MBProgressHUD *)showHudMessage:(NSString *)message {
    
    UIView *view = [ControlTools getCurrentVC].view;
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];;
    HUD.animationType = MBProgressHUDAnimationZoom;
    HUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    HUD.userInteractionEnabled = YES;
    HUD.label.text = message;
    HUD.removeFromSuperViewOnHide = YES;
    //    [HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    return HUD;
}

/**
 *Progress
 */
+ (MBProgressHUD *)showProgress:(UIView *)view progress:(void (^)(MBProgressHUD * _Nullable hud))progressBlock {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];;
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.animationType = MBProgressHUDAnimationZoomOut;
    HUD.removeFromSuperViewOnHide = YES;
    //    HUD.bezelView.color = HHRandomColor;
    
    if (progressBlock) {
        progressBlock(HUD);
    }
    return HUD;
}


#pragma mark 文字提示 快速显示一个提示信息
+ (void)showMessage:(NSString *)message
{
    [self showMessage:message toView:nil];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    [self hideHUDForView:nil];
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    //快速显示一个提示信息
    view.hidden = NO;
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;   //先设置类型
        
        hud.label.text = message;
        hud.label.font = [UIFont systemFontOfSize:KFontSize(13)];
        hud.label.textColor = [UIColor whiteColor];
        hud.label.numberOfLines = 0;
        
        hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.8f];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        
        hud.margin = KScale(15);
        hud.userInteractionEnabled = NO;
        hud.offset = CGPointMake(0, KScale(150));
        
        [hud hideAnimated:YES afterDelay:2.0];
    });
}


#pragma mark 显示成功
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

#pragma mark 显示失败
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}
#pragma mark 显示警告
+ (void)showWarn:(NSString *)warn
{
    [self showWarn:warn toView:nil];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"hud_success.png" view:view];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    
    [self show:error icon:@"hud_error.png" view:view];
}
#pragma mark 显示警告信息
+ (void)showWarn:(NSString *)warn toView:(UIView *)view{
    
    [self show:warn icon:@"hud_warn.png" view:view];
}

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    [self hideHUDForView:nil];
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    view.hidden = NO;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    //    hud.label.font = [UIFont systemFontOfSize:KFontSize(16)];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hideAnimated:YES afterDelay:2.0];
    
    //    hud.label.textColor = [UIColor whiteColor];
    
    hud.removeFromSuperViewOnHide = YES;
    
    hud.bezelView.color = [UIColor colorWithWhite:1.0f alpha:0.8f];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //    hud.bezelView.backgroundColor = [UIColor blackColor];
    
//    hud.userInteractionEnabled = NO;
    hud.margin = KScale(15);
}



/*****帧动画*****/
+ (MBProgressHUD *)showCustomAnimate:(NSString *)text imageName:(NSString *)imageName imageCounts:(NSInteger)imageCounts view:(UIView *)view {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUD:view];
    HUD.square = YES;
    HUD.bezelView.color = [UIColor clearColor];
    HUD.label.text = text;
    HUD.label.textColor = [UIColor grayColor];
    HUD.label.font = [UIFont systemFontOfSize:8];
    HUD.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@0001",imageName]];
    UIImageView *animateGifView = [[UIImageView alloc]initWithImage:image];
    
    NSMutableArray *gifArray = [NSMutableArray array];
    for (int i = 1; i <= imageCounts; i ++) {
        UIImage *images = [UIImage imageNamed:[NSString stringWithFormat:@"%@000%d", imageName, i]];
        [gifArray addObject:images];
    }
    
    [animateGifView setAnimationImages:gifArray];
    [animateGifView setAnimationDuration:0.5];
    [animateGifView setAnimationRepeatCount:0];
    [animateGifView startAnimating];
    
    HUD.customView = animateGifView;
    
    return HUD;
}


/**
 *  环形转圈
 */
+ (MBProgressHUD *)showRoundLoadingToView:(UIView *)view{
    
    MBProgressHUD *HUD = [MBProgressHUD showHUD:view];
    HUD.mode = MBProgressHUDModeCustomView;
    //    HUD.square = YES;
    
    HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.bezelView.backgroundColor = [UIColor clearColor];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    layer.frame = iconImageView.frame;
    [iconImageView.layer addSublayer: layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor  redColor].CGColor;
    HUD.customView = iconImageView;
    layer.center = HUD.bezelView.center;
    
    //    HUD.minSize = CGSizeMake(KFontSize(80), KFontSize(80));
    
    
    const int STROKE_WIDTH = 2;
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [[UIColor colorWithCGColor: layer.strokeColor] colorWithAlphaComponent: 0.3].CGColor;// 设置图层的透明圆形的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [layer addSublayer: alphaLineLayer];// 把外部半透明圆形的图层加到当前图层上
    
    CAShapeLayer *drawLayer = [CAShapeLayer layer];
    UIBezierPath *progressPath = [UIBezierPath bezierPath];
    [progressPath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle: 0 * M_PI / 180 endAngle: 360 * M_PI / 180 clockwise: YES];
    
    drawLayer.lineWidth = STROKE_WIDTH;
    drawLayer.fillColor = [UIColor clearColor].CGColor;
    drawLayer.path = progressPath.CGPath;
    drawLayer.frame = drawLayer.bounds;
    drawLayer.strokeColor = layer.strokeColor;
    [layer addSublayer: drawLayer];
    
    CAMediaTimingFunction *progressRotateTimingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.80 :0.75 :1.00];
    
    // 开始划线的动画
    CABasicAnimation *progressLongAnimation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    progressLongAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressLongAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongAnimation.duration = 2;
    progressLongAnimation.timingFunction = progressRotateTimingFunction;
    progressLongAnimation.repeatCount = 10000;
    // 线条逐渐变短收缩的动画
    CABasicAnimation *progressLongEndAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    progressLongEndAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressLongEndAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongEndAnimation.duration = 2;
    CAMediaTimingFunction *strokeStartTimingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints: 0.65 : 0.0 :1.0 : 1.0];
    progressLongEndAnimation.timingFunction = strokeStartTimingFunction;
    progressLongEndAnimation.repeatCount = 10000;
    // 线条不断旋转的动画
    CABasicAnimation *progressRotateAnimation = [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
    progressRotateAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressRotateAnimation.toValue = [NSNumber numberWithFloat: M_PI / 180 * 360];
    progressRotateAnimation.repeatCount = 1000000;
    progressRotateAnimation.duration = 6;
    
    [drawLayer addAnimation:progressLongAnimation forKey: @"strokeEnd"];
    [layer addAnimation:progressRotateAnimation forKey: @"transfrom.rotation.z"];
    [drawLayer addAnimation: progressLongEndAnimation forKey: @"strokeStart"];
    
    
    return HUD;
}




#pragma mark 隐藏
/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil){
        view = [ControlTools getCurrentVC].view;
        if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    }
    [self hideHUDForView:view animated:YES];
}



/**
 *  错误MBProgressHUD
 */
+ (void)showAnimalErrorViewWithText:(NSString *)text view:(UIView *)view{
    
    MBProgressHUD *HUD = [MBProgressHUD showHUD:view];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.text = text;
    HUD.label.textColor = [UIColor whiteColor];
    HUD.label.font = [UIFont systemFontOfSize:14];
    HUD.square = YES;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = iconImageView.bounds;
    [iconImageView.layer addSublayer: layer];
    layer.strokeColor = [UIColor  whiteColor].CGColor;
    HUD.customView = iconImageView;
    [HUD hideAnimated:YES afterDelay:1.0];
    
    const int STROKE_WIDTH = 3;// 默认的划线线条宽度
    
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [[UIColor colorWithCGColor: layer.strokeColor] colorWithAlphaComponent: 0.1].CGColor;
    // ↑ 设置图层的透明圆形的颜色，取图标颜色之后设置其对应的0.1透明度的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [layer addSublayer: alphaLineLayer];// 把外部半透明圆形的图层加到当前图层上
    
    // 开始画叉的两条线，首先画逆时针旋转的线
    CAShapeLayer *leftLayer = [CAShapeLayer layer];
    // 设置当前图层的绘制属性
    leftLayer.frame = layer.bounds;
    leftLayer.fillColor = [UIColor clearColor].CGColor;
    leftLayer.lineCap = kCALineCapRound;// 圆角画笔
    leftLayer.lineWidth = STROKE_WIDTH;
    leftLayer.strokeColor = layer.strokeColor;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    // 绘制大半圆
    [leftPath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  -43 * M_PI / 180 endAngle: -315 * M_PI / 180 clockwise: NO];
    [leftPath addLineToPoint: CGPointMake(layer.frame.size.width * 0.35, layer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    leftLayer.path = leftPath.CGPath;
    
    [layer addSublayer: leftLayer];
    
    // 逆时针旋转的线
    CAShapeLayer *rightLayer = [CAShapeLayer layer];
    // 设置当前图层的绘制属性
    rightLayer.frame = layer.bounds;
    rightLayer.fillColor = [UIColor clearColor].CGColor;
    rightLayer.lineCap = kCALineCapRound;// 圆角画笔
    rightLayer.lineWidth = STROKE_WIDTH;
    rightLayer.strokeColor = layer.strokeColor;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    // 绘制大半圆
    [rightPath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH  startAngle:  -128 * M_PI / 180 endAngle: 133 * M_PI / 180 clockwise: YES];
    [rightPath addLineToPoint: CGPointMake(layer.frame.size.width * 0.65, layer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    rightLayer.path = rightPath.CGPath;
    
    [layer addSublayer: rightLayer];
    
    
    CAMediaTimingFunction *timing = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.1];
    // 创建路径顺序绘制的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.duration = 0.5;// 动画使用时间
    animation.fromValue = [NSNumber numberWithInt: 0.0];// 从头
    animation.toValue = [NSNumber numberWithInt: 1.0];// 画到尾
    // 创建路径顺序从结尾开始消失的动画
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    strokeStartAnimation.duration = 0.4;// 动画使用时间
    strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.2;// 延迟0.2秒执行动画
    strokeStartAnimation.fromValue = [NSNumber numberWithFloat: 0.0];// 从开始消失
    strokeStartAnimation.toValue = [NSNumber numberWithFloat: 0.84];// 一直消失到整个绘制路径的84%，这个数没有啥技巧，一点点调试看效果，希望看此代码的人不要被这个数值怎么来的困惑
    strokeStartAnimation.timingFunction = timing;
    
    leftLayer.strokeStart = 0.84;// 设置最终效果，防止动画结束之后效果改变
    leftLayer.strokeEnd = 1.0;
    rightLayer.strokeStart = 0.84;// 设置最终效果，防止动画结束之后效果改变
    rightLayer.strokeEnd = 1.0;
    
    
    [leftLayer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [leftLayer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
    [rightLayer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [rightLayer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
    
}


/**
 *  正确MBProgressHUD
 */
+ (void)showAnimalSuccessViewWithText:(NSString *)text view:(UIView *)view{
    
    MBProgressHUD *HUD = [MBProgressHUD showHUD:view];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.text = text;
    HUD.label.textColor = [UIColor whiteColor];
    HUD.label.font = [UIFont systemFontOfSize:14];
    HUD.square = YES;
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.frame = iconImageView.bounds;
    [iconImageView.layer addSublayer: layer];
    layer.strokeColor = [UIColor  whiteColor].CGColor;
    HUD.customView = iconImageView;
    [HUD hideAnimated:YES afterDelay:1.0];
    
    
    const int STROKE_WIDTH = 3;// 默认的划线线条宽度
    
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [[UIColor colorWithCGColor: layer.strokeColor] colorWithAlphaComponent: 0.1].CGColor;// 设置图层的透明圆形的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [layer addSublayer: alphaLineLayer];// 把外部半透明圆形的图层加到当前图层上
    
    // 设置当前图层的绘制属性
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;// 圆角画笔
    layer.lineWidth = STROKE_WIDTH;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 绘制大半圆
    [path addArcWithCenter: CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2) radius:layer.frame.size.width / 2 - STROKE_WIDTH startAngle:  67 * M_PI / 180 endAngle: -158 * M_PI / 180 clockwise: NO];
    // 绘制对号第一笔
    [path addLineToPoint: CGPointMake(layer.frame.size.width * 0.42, layer.frame.size.width * 0.68)];
    // 绘制对号第二笔
    [path addLineToPoint: CGPointMake(layer.frame.size.width * 0.75, layer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    layer.path = path.CGPath;
    
    CAMediaTimingFunction *timing = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.1];
    // 创建路径顺序绘制的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.duration = 0.5;// 动画使用时间
    animation.fromValue = [NSNumber numberWithInt: 0.0];// 从头
    animation.toValue = [NSNumber numberWithInt: 1.0];// 画到尾
    // 创建路径顺序从结尾开始消失的动画
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    strokeStartAnimation.duration = 0.4;// 动画使用时间
    strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.2;// 延迟0.2秒执行动画
    strokeStartAnimation.fromValue = [NSNumber numberWithFloat: 0.0];// 从开始消失
    strokeStartAnimation.toValue = [NSNumber numberWithFloat: 0.74];// 一直消失到整个绘制路径的74%，这个数没有啥技巧，一点点调试看效果，希望看此代码的人不要被这个数值怎么来的困惑
    strokeStartAnimation.timingFunction = timing;
    
    layer.strokeStart = 0.74;// 设置最终效果，防止动画结束之后效果改变
    layer.strokeEnd = 1.0;
    
    [layer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [layer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
}

@end









