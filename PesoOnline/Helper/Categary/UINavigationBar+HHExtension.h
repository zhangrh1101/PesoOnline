//
//  UINavigationBar+HHExtension.h
//  RenMinWenLv
//
//  Created by Mac on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (HHExtension)

/*导航栏底部添加阴影*/
- (void)hh_dropShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity;

@end

NS_ASSUME_NONNULL_END
