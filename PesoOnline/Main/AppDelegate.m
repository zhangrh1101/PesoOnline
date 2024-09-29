//
//  AppDelegate.m
//  PesoOnline
//
//  Created by Zzzzzzzzz on 2024/9/29.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaseTabBarController.h"
#import "TestViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self saveDeviceID];
    [self setRootViewController];
    [self configKeyBoardManager];
    
    return YES;
}


#pragma mark - 初始化
- (void)setRootViewController {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = [[BaseTabBarController alloc] init];
    //    self.window.rootViewController = [[LoginViewController alloc] init];
    //    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[TestViewController new]];
    [self.window makeKeyAndVisible];
    
}

#pragma mark - 获取设备UUID
- (NSString *)getDeviceUUID {
    // 读取设备号
    NSString *UUID = [SAMKeychain passwordForService:APP_IDENTIFIER account:@"DeviceId"];
    if (!UUID) {
        // 如果没有UUID 则保存设备号
        CFUUIDRef deviceId = CFUUIDCreate(NULL);
        assert(deviceId != NULL);
        CFStringRef deviceIdStr = CFUUIDCreateString(NULL, deviceId);
        [SAMKeychain setPassword:[NSString stringWithFormat:@"%@", deviceIdStr] forService:APP_IDENTIFIER account:@"DeviceId"];
        UUID = [NSString stringWithFormat:@"%@", deviceIdStr];
    }
    return UUID;
}

#pragma mark - 存储UUID
- (void)saveDeviceID {
    
    NSString *DeviceUUID = [HH_Utilities getDeviceUUID];
    NSString *uuid = [NSString stringWithFormat:@"11-%@-%@",[DeviceTools deviceType],DeviceUUID];
    [UserDefaultsTool setObject:uuid forKey:KDefaultsPhoneDeviceUUID];
}

#pragma mark - 键盘配置
- (void)configKeyBoardManager {
    
    IQKeyboardManager* manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside=YES;
    manager.shouldToolbarUsesTextFieldTintColor=YES;
    manager.keyboardDistanceFromTextField = KScale(60);
    manager.toolbarManageBehavior = IQAutoToolbarByTag;
}

#pragma mark - 内存过高清除
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
    }];
}


@end
