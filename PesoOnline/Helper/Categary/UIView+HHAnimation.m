//
//  UIView+HHAnimation.m
//  RenMinWenLv
//
//  Created by Zzzzzzzzz💤 on 2021/9/3.
//

#import "UIView+HHAnimation.h"

@implementation UIView (HHAnimation)

/**
 *  缩放的动画
 */
- (void)reboundEffectAnimationDuration:(CGFloat)duration
{   //缩放的动画 效果
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration=duration;
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                        nil];//x y z 放大缩小的倍数
    [self.layer addAnimation:animation forKey:nil];
}


@end
