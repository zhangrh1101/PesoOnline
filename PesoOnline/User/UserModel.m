//
//  UserModel.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/7.
//

#import "UserModel.h"

#define ArchiveModelPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"UserModel.archive"]

@implementation UserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"accessToken" : @"accessToken",
    };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
//        @"corporations":[Corporations class],
    };
}


+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    UserModel *model = [UserModel mj_objectWithKeyValues:dict];
//    model.accessToken = dict[@"accessToken"];
//    model.cractUuid = dict[@"cractUuid"];
//    model.cractCreator = dict[@"cractCreator"];
//    model.cractCode = dict[@"cractCode"];
//    model.cractName = dict[@"cractName"];
//    model.cractMobile = dict[@"cractMobile"];
//    model.cractEmail = dict[@"cractEmail"];
//    model.cractOrgOwners = dict[@"cractOrgOwners"];
    model.logined = YES;
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"......................%@",key);
}


/*更新个人信息*/
+ (void)requestUserInfo {
//    [MineHandler requestUserInfoPath:GetUserInfoUrl params:nil success:^(id responseObject) {
//        HHLog(@"获取个人信息成功")
//        UserModel *model = (UserModel *)responseObject;
//
//        //设置推送别名
//        [AliCloudPush setAliCloudPushAlias:KString(@"%@%@", AliPushAlias, model.tid)];
//
//    } failed:^(id error) {
//
//    }];
}


MJCodingImplementation
- (void)saveUserModel
{
    [NSKeyedArchiver archiveRootObject:self toFile:ArchiveModelPath];
}

+ (instancetype)getInfo
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:ArchiveModelPath];
}

+ (void)removeToken
{
    [[AFHttpManager sharedManager].requestSerializer clearAuthorizationHeader];
    
    UserModel *model = [UserModel getInfo];
    model.accessToken = @"";
    model.cractCode = @"";
    model.cractName = @"";
    model.logined = NO;
    [model saveUserModel];
}

+ (void)removeModel
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:ArchiveModelPath]) {
        [defaultManager removeItemAtPath:ArchiveModelPath error:nil];
    }
}

/**
 退出登录
 */
+ (void)logOut {
    
    [UserModel removeToken];
    [UserModel removeModel];
    
    //删除别名
//    [AliCloudPush removeAliCloudPushAlias];
//    NSString *aliaName = [NSString stringWithFormat:@"%@%@", UMengPushAlias, [UserModel getInfo].cractCode];
//    [UMessage removeAlias:aliaName type:@"WishProple" response:^(id  _Nullable responseObject, NSError * _Nullable error) {
//        HHLog(@"别名移除成功 %@", aliaName);
//    }];
}


/**
 回到登录页
 */
- (void)goBackLogin {
    
    /*清楚Token*/
    
}

@end
