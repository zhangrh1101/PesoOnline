//
//  UIWindow+HHSafeArea.m
//  RenMinWenLv
//
//  Created by Zzzzzzzzz💤 on 2021/8/6.
//

#import "UIWindow+HHSafeArea.h"

@implementation UIWindow (HHSafeArea)

- (UIEdgeInsets)hh_layoutInsets {
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = self.safeAreaInsets;
        if (safeAreaInsets.bottom > 0) {
            //参考文章：https://mp.weixin.qq.com/s/Ik2zBox3_w0jwfVuQUJAUw
            return safeAreaInsets;
        }
        return UIEdgeInsetsMake(20, 0, 0, 0);
    }
    return UIEdgeInsetsMake(20, 0, 0, 0);
}

- (CGFloat)hh_navigationHeight {
    CGFloat statusBarHeight = [self hh_layoutInsets].top;
    return statusBarHeight + 44;
}

@end
