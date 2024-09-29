//
//  UIView+Border.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/13.
//

#import "UIView+Border.h"

@implementation UIView (Border)

/**
 添加圆角
 */
- (void)cornerRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)addCornerRadius:(CGFloat)radius {

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)].CGPath;
    self.layer.mask = maskLayer;
}

- (void)addCorners:(UIRectCorner)corners radius:(CGFloat)radius {
 
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)].CGPath;
    self.layer.mask = maskLayer;
}

/**
 添加阴影
 */
- (void)addShadowColor:(UIColor *)shadowColor
         shadowOpacity:(CGFloat)shadowOpacity
          shadowOffset:(CGSize)shadowOffset
          shadowRadius:(CGFloat)shadowRadius {
    
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;//阴影透明度，默认为0，如果不设置的话看不到阴影，切记，这是个大坑
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowRadius = shadowRadius;
}

/**
 任意圆角 带边框大小颜色 ； 当设置borderWidth为0 或者borderColor为透明色 移除layer
 */
- (void)shapeLayerCornerRadiusWithRectCorner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth {
    //使用UIBezierPath 和 CAShapeLayer 设置圆角 内存占用最小且渲染快速
    if (cornerRadius == 0) {
        [self addCorners:rectCorner radius:cornerRadius];
        return;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    //设置边框大小颜色 中间透明
    maskLayer.strokeColor = borderColor.CGColor;
    maskLayer.lineWidth = borderWidth;
    maskLayer.fillColor  = [UIColor clearColor].CGColor;
    
    //当设置borderWidth为0 或者borderColor为透明色 移除
    if (borderWidth == 0 || borderColor == UIColor.clearColor) {
       NSArray<CALayer *> *subLayers = self.layer.sublayers;
       NSArray<CALayer *> *removedLayers = [subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
           return [evaluatedObject isKindOfClass:[CAShapeLayer class]];
       }]];
       [removedLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           [obj removeFromSuperlayer];
       }];
    }else{
        [self.layer insertSublayer:maskLayer atIndex:0];
    }
}


/**
 添加边框
 */
-(void)addBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
}

/**
 添加单边框 可设置颜色 大小 方向
 */
- (void)addBorderLayerWithColor:(UIColor *)color borderWidth:(CGFloat) borderWidth borderType:(HHBorderType)boderType {
    CALayer * layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];

    switch (boderType) {
        case HHBorderTypeTop:
            layer.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
            break;
        case HHBorderTypeLeft:
            layer.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
            break;
        case HHBorderTypeBottom:
            layer.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
            break;
        case HHBorderTypeRight:
            layer.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
            break;
        default:
            break;
    }
}


/**
 绘制虚线边框
 */
-(void)addDottedLineWithColor:(UIColor *)color {
    
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = color.CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    //设置路径
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    //虚线的宽度
    border.lineWidth = 1.0f;
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @3];

    [self.layer addSublayer:border];
}

- (void)drawBottomLine:(float)margin left:(float)leftMargin right:(float)rightMargin {
    /*
     *画实线
     */
    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:SeparationlineColor.CGColor];
    solidShapeLayer.lineWidth = 0.5f ;
    CGPathMoveToPoint(solidShapePath, NULL, 0 + leftMargin, CGRectGetHeight(self.frame)+margin);
    CGPathAddLineToPoint(solidShapePath, NULL, CGRectGetWidth(self.frame) + rightMargin,CGRectGetHeight(self.frame)+margin);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.layer addSublayer:solidShapeLayer];
    
}


/**
 渐变色  左右
 */
- (void)addTransitionLeftColor:(UIColor *)startColor endColor:(UIColor *)endColor {
        
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(1, 1);
    gradientLayer.endPoint = CGPointMake(0, 1);
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,
                             (__bridge id)endColor.CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.5f), @(1.0f)];
    gradientLayer.frame = self.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.layer addSublayer:gradientLayer];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

/**
 渐变色 上下
 */
- (void)addGradientTopColor:(UIColor *)startColor endColor:(UIColor *)endColor {
        
    [self addGradientBeginColor:startColor endColor:endColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1) locations:@[@0.5, @1]];
}

/**
 渐变色 左右
 */
- (void)addGradientLeftColor:(UIColor *)startColor rightColor:(UIColor *)endColor {
        
    [self addGradientBeginColor:startColor endColor:endColor startPoint:CGPointMake(1, 1) endPoint:CGPointMake(0, 1) locations:@[@0.5, @1]];
}

/**
 自定义渐变色 分割点
 */
- (void)addGradientBeginColor:(UIColor *)startColor
                  endColor:(UIColor *)endColor
                startPoint:(CGPoint)startPoint
                  endPoint:(CGPoint)endPoint
                      locations:(NSArray *)locations {
    
    //初始化CAGradientlayer对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = locations;
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}


@end
