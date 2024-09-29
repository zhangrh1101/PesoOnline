//
//  UserModel.h
//  FasterVpn
//
//  Created by mac mini on 2022/5/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//用户Model
@interface UserModel : NSObject

@property (nonatomic , copy) NSString              * deviceUUID;

//正式令牌
@property (nonatomic , copy) NSString              * scope;
@property (nonatomic , copy) NSString              * accessToken;

@property (nonatomic , copy) NSString              * cractUuid;
@property (nonatomic , copy) NSString              * cractCreator;
@property (nonatomic , copy) NSString              * cractCode;
@property (nonatomic , copy) NSString              * cractName;
@property (nonatomic , copy) NSString              * cractMobile;
@property (nonatomic , copy) NSString              * cractEmail;
@property (nonatomic , copy) NSString              * cractOrgOwners;


//是否登陆
@property (nonatomic , assign , getter = isLogined) BOOL  logined;

//提供这个接口封装MJExtension这个框架
+ (instancetype)modelWithDict:(NSDictionary *)dict;

/**
 更新个人信息
 */
+ (void)requestUserInfo;

/**
 保存用户信息
 */
- (void)saveUserModel;
/**
 获取当前用户信息对象
 */
+ (instancetype)getInfo;

/**
 清除Token
 */
+ (void)removeToken;

/**
 清除本地用户信息
 */
+ (void)removeModel;

/**
 退出登录
 */
+ (void)logOut;

@end


NS_ASSUME_NONNULL_END
