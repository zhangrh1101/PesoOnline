//
//  HHNavigationBar.h
//  RenMinWenLv
//
//  Created by Mac on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    HHNavBarTintStyleWhite = 0x01,    // 导航栏主题颜色：白色
    HHNavBarTintStyleBlack = 0x02,    // 导航栏主题颜色：黑色
}HHNavBarTintStyle;

@interface HHNavigationBar : UIView
/**
 设置导航栏标题
 */
@property (nonatomic, copy) NSString              * hh_navTitle;
/**
 设置导航栏标题颜色
 */
@property (nonatomic, strong) UIColor             * hh_navTitleColor;
/**
 设置导航栏标题颜色
 */
@property (nonatomic, strong) UIColor             * hh_navBackColor;
/**
 设置导航栏标题字体
 */
@property (nonatomic, assign) CGFloat               hh_navTitleFontSize;

/**
 设置导航栏标题字体
 */
@property (nonatomic, strong) UIImage             * hh_backBtnImage;

/**
 导航栏主题颜色
 */
@property(assign, nonatomic)HHNavBarTintStyle       hh_navBarTintStyle;

/**
 设置导航栏透明度
 */
@property (nonatomic, assign) CGFloat               hh_alpha;

/**
 导航栏返回按钮
 */
//@property (nonatomic, strong) HHButton     * navBackBtn;

/**
 导航栏最右侧按钮图片
 */
@property (nonatomic, strong) UIImage              * hh_navRightImage;

/**
 导航栏最右侧按钮文字
 */
@property (nonatomic, copy) NSString               * hh_navRightTitle;

/**
 最右侧Button点击回调
 */
@property (copy, nonatomic) void (^hh_rightBtnClickBlock)(HHButton *button);


@end

NS_ASSUME_NONNULL_END
