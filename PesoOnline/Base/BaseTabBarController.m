//
//  BaseTabBarController.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/6.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger indexFlag;

@end

@implementation BaseTabBarController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //修改Tabbar高度
//    CGRect frame = self.tabBar.frame;
//    frame.size.height = 83;
//    frame.origin.y = self.view.frame.size.height - frame.size.height;
//    self.tabBar.frame = frame;
//    self.tabBar.barStyle = UIBarStyleBlack;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置代理
    self.delegate = self;
    
    //初始化
    [self addChildViewController];
    //tabbar配置
    [self configTabbar];
}


# pragma mark - 添加子类的数据
- (void)addChildViewController {
    
    NSArray *controllers = @[@"HomeViewController", @"MineViewController"];
    NSArray *normalImages = @[@"tab_home", @"tab_mine"];
    NSArray *selectImages = @[@"tab_home_sel", @"tab_mine_sel"];
    NSArray *titles = @[@"首页", @"我的"];
    
    [self TabbarControllerAddSubViewsControllers:controllers addTitleArray:titles addNormalImagesArray:normalImages addSelectImageArray:selectImages];
}

# pragma mark - 初始化Tabbar里面的元素
- (void)TabbarControllerAddSubViewsControllers:(NSArray *)classControllersArray addTitleArray:(NSArray *)titleArray addNormalImagesArray:(NSArray *)normalImagesArray addSelectImageArray:(NSArray *)selectImageArray
{
    NSMutableArray *controllerArray = [NSMutableArray array];
    
    for (int i = 0; i < classControllersArray.count; i++) {
        
        //添加导航控制器
        //先给外面传进来的小控制器 包装一个导航控制器
        Class classVc = NSClassFromString(classControllersArray[i]);
        UIViewController *childVC = [[classVc alloc] init];
        BaseNavigationController *navVC = [[BaseNavigationController alloc] initWithRootViewController:childVC];
        [controllerArray addObject:navVC];

        //设置图片
        UIImage *normalImage = [[UIImage imageNamed:normalImagesArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectImage = [[UIImage imageNamed:selectImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:normalImage selectedImage:selectImage];
        
        //设置文字的样式
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = HH_HexColor(@"#BDC3E4");
        NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
        selectTextAttrs[NSForegroundColorAttributeName] = ThemeColor;
        [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        [childVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
        
        //修改图标位置
        navVC.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    }
    
    //添加的导航控制器数组
    self.viewControllers = controllerArray;
}

# pragma mark - Tabbar配置
- (void)configTabbar {

    if (@available(iOS 15.0, *)) {
        //修改Tabbar背景色、背景图
        UITabBarAppearance * appearance = [UITabBarAppearance new];
        appearance.shadowImage = [UIImage new];
        appearance.shadowColor = [UIColor clearColor];
        appearance.backgroundImage = [UIImage new];                 //设置背景透明
        appearance.backgroundColor = [UIColor whiteColor];          //设置背景颜色
        
        //修改文字位置
//        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffsetMake(0, 0);
//        appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffsetMake(0, 0);
        
        //设置 scrollEdgeAppearance = nil 则为透明，如果当前界面中使用可了ScrollView ，当ScrollView向上滚动时 scrollEdgeAppearance会默认使用 standardAppearance。因此 backgroundEffect 和 shadowColor 也要显式设置为 nil ，防止 backgroundEffect、shadowColor 出现变成有颜色
//        self.tabBar.scrollEdgeAppearance = nil;
//        self.tabBar.standardAppearance = appearance;
        self.tabBar.scrollEdgeAppearance = appearance;
    }else{
        //修改Tabbar背景
        [[UITabBar appearance] setBackgroundImage:[UIImage new]];
        [[UITabBar appearance] setShadowImage:[UIImage new]];
    }
    
    //Tabbar选中颜色 iOS13 及以上
    if (@available(iOS 13.0, *)) {
        self.tabBar.unselectedItemTintColor = MainUnTextColor;
        self.tabBar.tintColor = ThemeColor;
    }
    
    //修改背景颜色（改变了视图层级）
//    self.tabBar.backgroundColor = [UIColor clearColor];
//    self.tabBar.translucent = YES;
    
    //添加阴影
//    [self.tabBar addShadowColor:BorderColor shadowOpacity:0.8 shadowOffset:CGSizeMake(0, 3) shadowRadius:5];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma UITabBarController Delegate
//判断是否跳转
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
//    if (![UserModel getInfo].isLogined) {
//
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        BaseNavigationController *loginNav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
//        loginNav.modalPresentationStyle = UIModalPresentationFullScreen;
//        [self presentViewController:loginNav animated:YES completion:nil];
//        return NO;
//    }
    return YES;
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (self.indexFlag != index) {
        //添加跳动动画
//        [self animationWithIndex:index];
        self.indexFlag = index;
    }
}


// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.8];
    pulse.toValue= [NSNumber numberWithFloat:1.1];
    
    UIView *barView = (UIView *)tabbarbuttonArray[index];
    [[barView layer] addAnimation:pulse forKey:nil];
}


- (void)dropShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}

@end
