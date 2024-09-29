//
//  UINavigationBar+HHExtension.m
//  RenMinWenLv
//
//  Created by Mac on 2021/8/13.
//

#import "UINavigationBar+HHExtension.h"

@implementation UINavigationBar (HHExtension)

/*导航栏底部添加阴影*/
- (void)hh_dropShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity {
 
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
 
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
 
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
 
}


@end
