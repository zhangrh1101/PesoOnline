//
//  BaseViewController.h
//  FasterVpn
//
//  Created by mac mini on 2022/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NavBarTintState) {
    NavBarTintStatDefault = 0,      //默认黑色
    NavBarTintStateLight ,          //浅色
};

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIBarButtonItem   *   leftBarItem;
@property (nonatomic, strong) UIBarButtonItem   *   rightBarItem;

@property (nonatomic, assign) NavBarTintState       barTintState;
@property (nonatomic, strong) UIColor           *   barTintColor;
@property (nonatomic, strong) UIColor           *   barTitleColor;
@property (nonatomic, strong) UIFont            *   barFont;

//@property (nonatomic, strong) MainNavbar        *   navbar; //隐藏导航栏 default NO

/**
 添加导航栏
 */
- (void)addMainNavbar;

/**
 返回事件
 */
- (void)navBackClick;

/**
 设置导航栏字体颜色大小
 */
- (void)configNavigationBarTitleWithColor:(UIColor *)color font:(CGFloat)fontsize;

/**
 透明导航栏
 */
- (void)setNavigationAlphaBar;
- (void)configNavigationBarImage:(UIImage *)barImage BarShadow:(UIImage *)barShadow;


/**
 添加导航栏按钮
 */
- (void)configLeftBar:(UIButton *)button upInsideAction:(void(^)(id sender))actionBlock;
- (void)configRightBar:(UIButton *)button upInsideAction:(void(^)(id sender))actionBlock;


/**
 添加多个左侧Item
 @[@"icon_add_wt",@"",@"img_search"] 中间间隔
 */
- (void)addNavigationLeftItems:(NSArray *)leftImages;


/**
 添加多个右侧Item 文字或图片名
 @[@"icon_add_wt",@"",@"img_search"] 中间间隔
 */
- (void)addNavigationRightItems:(NSArray *)rightItems;


/*进入主页面*/
- (void)showRootViewController;

@end

NS_ASSUME_NONNULL_END
