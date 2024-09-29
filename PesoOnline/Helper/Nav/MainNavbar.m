//
//  MainNavbar.m
//  RenMinWenLv
//
//  Created by Zzzzzzzzz💤 on 2021/8/5.
//

#import "MainNavbar.h"
#import "HHTransitionAnimator.h"

@interface MainNavbar () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIImageView   * logoImage;
@property (nonatomic, strong) UIButton      * searchBtn;
@property (nonatomic, strong) UIView        * shadowLine;

@end

@implementation MainNavbar

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initNavBar];
    }
    return self;
}


- (void)initNavBar {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:KIMAGE(@"news_nav_logo")];
    [self addSubview:logoImage];
    
    UIButton *searchBtn = [ControlTools buttonWithImage:@"news_nav_search" title:@"" titleColor:nil font:nil upInsideAction:^(id  _Nonnull sender) {
        HHLog(@"searchBtn");
        
//        SearchViewController *searchVC = [[SearchViewController alloc] init];
//        BaseNavigationController *navVC = [[BaseNavigationController alloc] initWithRootViewController:searchVC];
//        navVC.modalPresentationStyle = UIModalPresentationCustom;
//        navVC.transitioningDelegate = self;
//        [[ControlTools navigationViewController] presentViewController:navVC animated:YES completion:nil];
    }];
    [self addSubview:searchBtn];
    
    
    UIView *shadowLine = [[UIView alloc] initWithFrame:CGRectMake(0, KNavBarHeight-3, SCREEN_WIDTH, 2)];
    shadowLine.backgroundColor = [UIColor whiteColor];
    shadowLine.layer.shadowColor = InvestBlackColor.CGColor;
    shadowLine.layer.shadowOpacity = 0.1;//阴影透明度，默认为0，如果不设置的话看不到阴影，切记，这是个大坑
    shadowLine.layer.shadowOffset = CGSizeMake(0, 1);
    shadowLine.layer.shadowRadius = 1;
    [self addSubview:shadowLine];

    self.logoImage = logoImage;
    self.searchBtn = searchBtn;
    self.shadowLine = shadowLine;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-6);
        make.size.mas_equalTo(CGSizeMake(86, 34));
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.logoImage);
        make.right.mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
}

- (void)setHideLine:(BOOL)hideLine {
    _hideLine = hideLine;
    self.shadowLine.hidden = hideLine;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [HHTransitionAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [HHTransitionAnimator new];
}



@end
