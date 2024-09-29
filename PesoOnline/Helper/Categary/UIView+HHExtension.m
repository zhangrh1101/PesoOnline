//
//  UIView+HHExtension.m
//  HaoWeibo
//
//  Created by Zzzzzzzzz💤 on 16/3/9.
//  Copyright © 2016年 Zzzzzzzzz💤. All rights reserved.
//

#import "UIView+HHExtension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)centerY{
    return self.center.y;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


- (void)setSize:(CGSize)size
{
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(void)setOrigin:(CGPoint)origin{
    
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGPoint)origin{
    
    return self.frame.origin;
}

- (void)setMiddleX:(CGFloat)middleX
{
    CGRect frame = self.frame;
    frame.origin.x = middleX - frame.size.width / 2;
    self.frame = frame;
}

- (CGFloat)middleX
{
    return CGRectGetMidX(self.frame);
}

- (void)setMiddleY:(CGFloat)middleY
{
    CGRect frame = self.frame;
    frame.origin.y = middleY - frame.size.height / 2 ;
    self.frame = frame;
}

- (CGFloat)middleY
{
    return CGRectGetMidY(self.frame);
}



CGSize HHScreenSize(void) {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height <= size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size;
}

CGFloat HHScreenWidth(void) {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height <= size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size.width;
}

CGFloat HHScreenHeight(void) {
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [UIScreen mainScreen].bounds.size;
        if (size.height <= size.width) {
            CGFloat tmp = size.height;
            size.height = size.width;
            size.width = tmp;
        }
    });
    return size.height;
}

// iPhone 12   390 x 844
CGFloat KScale(CGFloat size) {
    return floor( HHScreenWidth() / 375.f * size );
}

CGFloat HHAutoWidth(CGFloat width) {
    return floor( HHScreenWidth() / 375.f * width );
}

CGFloat HHAutoHeight(CGFloat height) {
    return floor( HHScreenHeight() / 812.f * height );
}

/** 获取相对大小 */
CGSize HHSize(CGFloat width, CGFloat height) {
    return CGSizeMake(KScale(width), KScale(height));
}

UIEdgeInsets HHEdge(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    return UIEdgeInsetsMake(KScale(top), KScale(left), KScale(bottom), KScale(right));
}


/** 是否是Ipad */
BOOL HH_IsIPad() {
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPad"]) {
        return YES;
    }
    return NO;
}


/** 是否是苹果X */
BOOL HH_IsIphoneX(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果XR */
BOOL HH_IsIphoneXR(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果XS */
BOOL HH_IsIphoneXS(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果XS_Max */
BOOL HH_IsIphoneXS_Max(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size): NO);
}
/** 是否是苹果11 */
BOOL HH_IsIphone11(void)  {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果11_Pro  */
BOOL HH_IsIphone11_Pro(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果11_Pro_Max */
BOOL HH_IsIphone11_Pro_Max(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果12_Mini */
BOOL HH_IsIphone12_Mini(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果12 */
BOOL HH_IsIphone12(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果12_Pro */
BOOL HH_IsIphone12_Pro(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果12_Pro_Max */
BOOL HH_IsIphone12_Pro_Max(void) {
    return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) : NO);
}
/** 是否是苹果X系列(刘海屏系列) */
BOOL HH_IsIphoneX_ALL(void) {
    //    return (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), LSTScreenSize())|| CGSizeEqualToSize(CGSizeMake(812.f, 375.f), LSTScreenSize())  || CGSizeEqualToSize(CGSizeMake(414.f, 896.f), LSTScreenSize()) || CGSizeEqualToSize(CGSizeMake(896.f, 414.f), LSTScreenSize()));
    //    //或者以下方法判断
    BOOL isPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;
    }
    return isPhoneX;
}

/**
 *  截屏生成图片
 */
- (UIImage *)napshotImage {
    UIGraphicsBeginImageContext(self.bounds.size);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    } else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    image = [UIImage imageWithData:imageData];
    return image;
}

/**
 *  给UIView添加事件响应
 *
 *  @param target 响应者
 *  @param action 响应事件
 */
- (void)addTapGestureWithTarget:(id)target action:(SEL)action
{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    singleTap.view.tag = self.tag;
    [self addGestureRecognizer:singleTap];
}

/**
 *  给UIView添加长按事件响应
 *
 *  @param target 响应者
 *  @param action 响应事件
 */
- (void)addLongPressGestureWithTarget:(id)target action:(SEL)action
{
    self.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *longPressTap = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    longPressTap.view.tag = self.tag;
    [self addGestureRecognizer:longPressTap];
}

/**
 获取当前View所在控制器
 */
- (UIViewController *)viewController
{
    UIResponder *responder = self;
    do {
        responder = [responder nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    } while (responder != nil);
    return nil;
}

/*
 * shadowColor 阴影颜色
 * shadowOpacity 阴影透明度，默认0
 * shadowRadius  阴影半径，默认3
 * shadowPathSide 设置哪一侧的阴影，
 * shadowPathWidth 阴影的宽度，
 */

-(void)setShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(HHShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth {
    
    
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = shadowColor.CGColor;
    
    self.layer.shadowOpacity = shadowOpacity;
    
    self.layer.shadowRadius =  shadowRadius;
    
    self.layer.shadowOffset = CGSizeMake(0, 0);
    CGRect shadowRect;
    
    CGFloat originX = 0;
    
    CGFloat originY = 0;
    
    CGFloat originW = self.bounds.size.width;
    
    CGFloat originH = self.bounds.size.height;
    
    
    switch (shadowPathSide) {
        case HHShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case HHShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
        case HHShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case HHShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case HHShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case HHShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
    }
    
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = path.CGPath;
}

@end
