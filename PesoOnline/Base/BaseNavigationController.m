//
//  BaseNavigationController.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/6.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        __weak typeof(self) weakSelf = self;
        self.delegate = weakSelf;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    
    //设置背景图为空
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //导航条黑线问题
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (animated) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if (animated) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return  [super popToRootViewControllerAnimated:animated];
}


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate {
    self.interactivePopGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer
        && self.viewControllers.count < 2) {
        return NO;
    }
    return YES;
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
