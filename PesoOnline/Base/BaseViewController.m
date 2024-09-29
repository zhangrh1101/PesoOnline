//
//  BaseViewController.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/6.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UINavigationBarAppearance     * appearance;

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //设置导航栏属性
//    self.barFont = [UIFont boldSystemFontOfSize:18];
//    self.barTitleColor = kColorWhite;
//    self.barTintColor = ThemeColor;
//    self.navigationController.navigationBar.tintColor = kColorWhite;
  
    [UIApplication sharedApplication].statusBarStyle = self.barTintState == NavBarTintStatDefault ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;

    //navigation控件颜色
    if (self.barTintState == NavBarTintStatDefault) {
        self.barFont = [UIFont boldSystemFontOfSize:18];
        self.barTitleColor = kColorBlack;
        self.barTintColor = kColorWhite;;
        self.navigationController.navigationBar.tintColor = kColorBlack;
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    } else {
        //1.标题颜色  2.Item颜色  3.背景颜色
        self.barFont = [UIFont boldSystemFontOfSize:18];
        self.barTitleColor = kColorBlack;
        self.barTintColor = kColorWhite;;
        self.navigationController.navigationBar.tintColor = kColorBlack;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    
    //设置导航栏透明
//    [self setNavigationAlphaBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 13.0, *)) {
        self.appearance = [[UINavigationBarAppearance alloc] init];
    } else {
        // Fallback on earlier versions
    };

    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(navBackClick)];
    }
    
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    
    if (@available(iOS 15.0, *)) {
        [UITableView appearance].sectionHeaderTopPadding = 0;
    }
    
    AdjustsScrollViewInsets_NO([UITableView appearance], self);
    
    
    //设置图片背景
//    UIImage *backgroundImage = [UIImage imageNamed:@"background_main"];
//    self.view.layer.contents = (id) backgroundImage.CGImage;
//    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
//    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置背景色
//    [self.view addGradientTopColor:[UIColor colorWithHexString:@"#180F25"] endColor:[UIColor colorWithHexString:@"#050308"]];

}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}



/**
 导航栏背景颜色
 */
- (void)setBarTintColor:(UIColor *)barTintColor {
    //导航栏背景
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 15.0, *)) {
        self.appearance.backgroundColor = [barTintColor colorWithAlphaComponent:1.0];
        self.appearance.backgroundImage= [UIImage new];      //图片
        self.appearance.shadowColor = UIColor.clearColor;    //阴影
        self.navigationController.navigationBar.scrollEdgeAppearance = self.appearance;
        self.navigationController.navigationBar.standardAppearance = self.appearance;
    }else{
        //背景色
        self.navigationController.navigationBar.barTintColor = barTintColor;
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }
}

/**
 导航栏标题颜色
 */
- (void)setBarTitleColor:(UIColor *)barTitleColor {
    _barTitleColor = barTitleColor;
    
    UIFont *titleFont = self.barFont ? self.barFont : [UIFont boldSystemFontOfSize:18];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : barTitleColor, NSFontAttributeName : titleFont};
    
    if (@available(iOS 15.0, *)) {
        self.appearance.titleTextAttributes = attributes;
        self.navigationController.navigationBar.scrollEdgeAppearance = self.appearance;
        self.navigationController.navigationBar.standardAppearance = self.appearance;
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    }
}

/**
 导航栏标题大小
 */
- (void)setBarFont:(UIFont *)barFont {
    _barFont = barFont;
    UIColor *titleColor = self.barTitleColor ? self.barTitleColor : kColorWhite;
    NSDictionary *attributes = @{NSForegroundColorAttributeName : titleColor, NSFontAttributeName : barFont};

    if (@available(iOS 15.0, *)) {
        self.appearance.titleTextAttributes = attributes;
        self.navigationController.navigationBar.scrollEdgeAppearance = self.appearance;
        self.navigationController.navigationBar.standardAppearance = self.appearance;
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    }
}


/**
 导航栏状态
 */
-(void)setBarTintState:(NavBarTintState)barTintState {
    _barTintState = barTintState;
}

/**
 添加导航栏
 */
- (void)addMainNavbar {
    
//    MainNavbar *navbar = [[MainNavbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, KNavBarHeight)];
//    [self.view addSubview:navbar];
//    self.navbar = navbar;
}


/**
 添加多个右侧Item
 @[@"icon_add_wt",@"",@"img_search"] 中间间隔
 */
- (void)addNavigationRightItems:(NSArray *)rightItems {

    NSMutableArray *itemArr = [[NSMutableArray alloc] init];

    for (int i=0; i<rightItems.count; i++) {

        NSString *name = [rightItems[i] objectForKey:@"name"];
        NSString *icon = [rightItems[i] objectForKey:@"icon"];

        if ([HH_Utilities isBlankString:name] && [HH_Utilities isBlankString:icon]) {
            //添加UIBarButtonSystemItemFixedSpace类型的item
            UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spaceItem.width = 15;
            [itemArr addObject:spaceItem];
        }else{
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = i+100;
            [button setTitle:name forState:UIControlStateNormal];
            if (![HH_Utilities isBlankString:icon]) {
                [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
            [button.widthAnchor constraintEqualToConstant:35].active = YES;
            [button.heightAnchor constraintEqualToConstant:35].active = YES;
            //[button sizeToFit];
            [button setEnlargeEdge:5];
            [itemArr addObject:[[UIBarButtonItem alloc] initWithCustomView:button]];
        }
    }
    self.navigationItem.rightBarButtonItems = itemArr;
}


- (void)rightItemClick:(UIButton *)rightItem
{
    HHLog(@"rightItemClick");
}


/**
 透明导航栏
 */
- (void)setNavigationAlphaBar {
    
    [self configNavigationBarImage:[UIImage new] BarShadow:[UIImage new]];
}

- (void)configNavigationBarImage:(UIImage *)barImage BarShadow:(UIImage *)barShadow {
   
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:barShadow];
}

- (void)configNavigationBarImage:(UIImage *)image {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)configNavigationBarShadow:(UIImage *)image {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.navigationController.navigationBar setShadowImage:image];
}


- (void)configLeftBar:(UIButton *)button upInsideAction:(void(^)(id sender))actionBlock {
    
    [button sizeToFit];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:actionBlock];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.leftBarItem = leftItem;
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)configRightBar:(UIButton *)button upInsideAction:(void(^)(id sender))actionBlock {
    
//    [button.widthAnchor constraintEqualToConstant:35].active = YES;
//    [button.heightAnchor constraintEqualToConstant:35].active = YES;
    [button sizeToFit];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:actionBlock];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.rightBarItem = rightItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)navBackClick {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count >= 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


/*进入主界面*/
- (void)showRootViewController {

//    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    BaseNavigationController *navVC = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    
    BaseTabBarController *tabbarVC = [[BaseTabBarController alloc] init];
    CATransition *transtition = [CATransition animation];
    transtition.duration = 0.5;
    transtition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarVC;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtition forKey:@"animation"];
}

/*应用直接退出*/
- (void)exitApplication {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
