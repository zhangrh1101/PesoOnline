//
//  HHProgressCircleView.h
//  RenMinWenLv
//
//  Created by Mac on 2021/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HHProgressCircleViewDelegate<NSObject>
@optional
- (void)didProgressAnmateEnd;
@end

@interface HHProgressCircleView : UIView

@property (nonatomic, assign) id <HHProgressCircleViewDelegate>        delegate;

//渐变颜色
@property (nonatomic, strong) UIColor   * lightColor;
@property (nonatomic, strong) UIColor   * darkColor;

//宽度
@property (nonatomic, assign) CGFloat     lineWidth;

//进度值
@property (nonatomic, assign) CGFloat     progress;
//动画跳到进度
- (void)animateToProgress:(CGFloat)progress;
//动画进度为0
- (void)animateToZero;
//重置
- (void)reset;

@end

NS_ASSUME_NONNULL_END
