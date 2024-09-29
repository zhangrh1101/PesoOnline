//
//  LoginManager.m
//  RenMinWenLv
//
//  Created by Mac on 2021/11/5.
//

#import "LoginManager.h"

@implementation LoginManager

/**跳转登录*/
+ (void)showLoginController {
    
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
//    [[ControlTools navigationViewController] presentViewController:loginVC animated:YES completion:nil];
}

/*登录成功后的操作*/
+ (void)onloginSuccess {

    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRefreshUserInfo object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRefreshConnectStatus object:nil];
}

/*退出登录后的操作*/
+ (void)onloginOut {
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRefreshUserInfo object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationRefreshConnectStatus object:nil];
    
//    [Intercom logout];
}

@end
