//
//  LoginManager.h
//  RenMinWenLv
//
//  Created by Mac on 2021/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginManager : NSObject

/**跳转登录*/
+ (void)showLoginController;

/*登录成功后的操作*/
+ (void)onloginSuccess;

/*退出登录后的操作*/
+ (void)onloginOut;

@end

NS_ASSUME_NONNULL_END
