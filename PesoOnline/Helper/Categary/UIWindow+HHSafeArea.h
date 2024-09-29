//
//  UIWindow+HHSafeArea.h
//  RenMinWenLv
//
//  Created by Zzzzzzzzz💤 on 2021/8/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (HHSafeArea)

- (UIEdgeInsets)hh_layoutInsets;

- (CGFloat)hh_navigationHeight;
    
@end

NS_ASSUME_NONNULL_END
