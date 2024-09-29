//
//  HHPanGesturePopView.h
//  RenMinWenLv
//
//  Created by 张仁昊 on 2021/9/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHPanGesturePopView : UIView

+ (instancetype)panGesturePopViewWithFrame:(CGRect)frame contentView:(UIView *)contentView;

- (void)showToView:(UIView *)view;

- (void)dismiss;

//内容视图顶部距离父视图底部距离
@property (nonatomic, assign) CGFloat                    marginTop;

//是否隐藏蒙版
@property (nonatomic, assign) BOOL                       hideMaskView;

@end

NS_ASSUME_NONNULL_END
