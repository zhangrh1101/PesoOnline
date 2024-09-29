//
//  HHNavigationBar.m
//  RenMinWenLv
//
//  Created by Mac on 2021/8/13.
//

#import "HHNavigationBar.h"

#define KNavigationButtonWidth        40

@interface HHNavigationBar ()
//背景图片
@property (nonatomic, strong) UIImageView  * navBackImageView;
//背景蒙版
@property (nonatomic, strong) UIView       * navMaskView;
//内容载体
@property (nonatomic, strong) UIView       * navBackView;
//导航标题
@property (nonatomic, strong) UILabel      * navTitleLB;

@property (nonatomic, strong) HHButton     * navBackBtn;
@property (nonatomic, strong) HHButton     * navRightBtn;

@property (nonatomic, assign) HHNavBarTintStyle       lastTintStyle;

@end

@implementation HHNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initNavBar];
    }
    return self;
}


- (void)initNavBar {
        
    self.navBackImageView = [[UIImageView alloc] init];
    self.navBackImageView.userInteractionEnabled = YES;
    [self addSubview:self.navBackImageView];
    
    //背景蒙版
    self.navMaskView = [[UIView alloc] init];
    self.navMaskView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.navMaskView];
    
    self.navBackView = [[UIView alloc] init];
    [self addSubview:self.navBackView];
    
    self.navTitleLB = [[UILabel alloc] init];
    self.navTitleLB.font = [UIFont boldSystemFontOfSize:18];
    self.navTitleLB.textColor = [UIColor blackColor];
    self.navTitleLB.textAlignment = NSTextAlignmentCenter;
    [self.navBackView addSubview:self.navTitleLB];
    
    self.navBackBtn = [[HHButton alloc] init];
    self.navBackBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.navBackBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navBackBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.navBackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.navBackBtn setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
    [self.navBackBtn addTarget:self action:@selector(navBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBackView addSubview:self.navBackBtn];
    
    self.navRightBtn = [[HHButton alloc] init];
    self.navRightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.navRightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navRightBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.navRightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.navRightBtn.contentMode = UIViewContentModeScaleAspectFill;
//    [self.navRightBtn setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
    [self.navRightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBackView addSubview:self.navRightBtn];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat statusBarHeight = IS_IPHONE_X ? 44 : 20;

    self.navBackImageView.frame = self.bounds;
    self.navMaskView.frame = self.bounds;
    self.navBackView.frame = CGRectMake(0, statusBarHeight, size.width, KNavigationHeight);
    self.navTitleLB.frame = CGRectMake(80, 0, size.width-160, KNavigationHeight);
    self.navBackBtn.frame = CGRectMake(0, 0, KNavigationButtonWidth, KNavigationHeight);
    self.navRightBtn.frame = CGRectMake(size.width-KNavigationButtonWidth, 0, KNavigationButtonWidth, KNavigationHeight);
}

#pragma mark 点击了左侧Button
- (void)navBackClick {
    
    UINavigationController *navigationController = [[ControlTools getCurrentVC] navigationController];
    if (navigationController) {
        if (navigationController.viewControllers.count >= 1) {
            [navigationController popViewControllerAnimated:YES];
        } else {
            [navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [[ControlTools getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 点击了右侧Button
- (void)rightBtnAction:(HHButton *)rightBtn {
    !self.hh_rightBtnClickBlock ? : self.hh_rightBtnClickBlock(rightBtn);
}


- (void)setHh_navBarTintStyle:(HHNavBarTintStyle)hh_navBarTintStyle {
    _hh_navBarTintStyle = hh_navBarTintStyle;
    
    if (_lastTintStyle == hh_navBarTintStyle) {
        return;
    }
    if (hh_navBarTintStyle == HHNavBarTintStyleBlack) {
        self.navTitleLB.textColor = [UIColor blackColor];
        [self.navBackBtn setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
    }else{
        self.navTitleLB.textColor = [UIColor whiteColor];
        [self.navBackBtn setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
    }
    
    _lastTintStyle = hh_navBarTintStyle;
}


- (void)setHh_navTitle:(NSString *)hh_navTitle {
    _hh_navTitle = hh_navTitle;
    self.navTitleLB.text = hh_navTitle;
}

- (void)setHh_navTitleColor:(UIColor *)hh_navTitleColor {
    _hh_navTitleColor = hh_navTitleColor;
    self.navTitleLB.textColor = hh_navTitleColor;
}

- (void)setHh_navBackColor:(UIColor *)hh_navBackColor {
    _hh_navBackColor = hh_navBackColor;
    self.navMaskView.backgroundColor = hh_navBackColor;
}

- (void)setHh_navRightImage:(UIImage *)hh_navRightImage {
    _hh_navRightImage = hh_navRightImage;
    [self.navRightBtn setImage:hh_navRightImage forState:UIControlStateNormal];
    self.navRightBtn.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setHh_navRightTitle:(NSString *)hh_navRightTitle {
    _hh_navRightTitle = hh_navRightTitle;
    [self.navRightBtn setTitle:hh_navRightTitle forState:UIControlStateNormal];
}


- (void)setHh_alpha:(CGFloat)hh_alpha {
    //背景透明度
    self.navMaskView.alpha = hh_alpha;
}

@end
