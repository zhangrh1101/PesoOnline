//
//  HH_Utilities.h
//  B2B
//
//  Created by Zzzzzzzzz💤 on 16/3/16.
//  Copyright © 2016年 Zzzzzzzzz💤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HH_Utilities : NSObject

//n位数字
+ (BOOL)checkNum: (NSString *)number;

/**
 *  判断是否为空格或者空值
 *
 *  @param string 输入源
 *
 *  @return YES : 为真   NO:为假
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 如果没值返回空字符串
 */
+ (NSString *)blankString:(NSString *)string;

/*!
 @method
 @abstract 正则表达式验证手机号码
 @discussion BOOL valid = [HH_Utilities checkTelNumber: @"1111111111"];
 @param  telNumber  手机号码
 @result    是否正确
 */
+ (BOOL)checkTelNumber: (NSString *)telNumber;

/*!
 @method
 @abstract 正则表达式验证密码强度
 @discussion BOOL valid = [QS_CheckString checkPassword: @"1111111111"];
 @param  password  密码
 @result    是否正确
 */
+ (BOOL)checkPassword: (NSString *)password;

/*!
 @method
 @abstract 正则表达式验证首字母是数字或字母
 @discussion BOOL valid = [QS_CheckString checkPasswordFirstWord: @"1111111111"];
 @param  password  密码
 @result    是否正确
 */+ (BOOL)checkPasswordFirstWord:(NSString *)password;

/*!
 @method
 @abstract 正则表达式验证用户名格式
 @discussion BOOL valid = [QS_CheckString checkUserName: @"1111111111"];
 @param  userName  用户账号
 @result    是否正确
 */
+ (BOOL)checkUserName: (NSString *)userName;

//校验邮箱
+ (BOOL)checkEmail:(NSString*)email;

/*!
 @method
 @abstract 正则表达式验证身份证
 @discussion BOOL valid = [QS_CheckString checkUserIdentifier: @"1111111111"];
 @param  userIdentifier  用户昵称
 @result    是否正确
 */
+ (BOOL)checkUserIdentifier: (NSString *)userIdentifier;

/*!
 @method
 @abstract 正则表达式验证请求地址
 @discussion BOOL valid = [QS_CheckString checkURL: @"1111111111"];
 @param  url  链接请求地址
 @result    是否正确
 */
+ (BOOL)checkURL: (NSString *)url;

/*!
 @method
 @abstract 验证URL是否非法
 @result    是否正确
 */
+ (BOOL)validateURL: (NSString *)url;

#pragma mark - 抽象验证方法 正则
+ (BOOL)checkWithString: (NSString *)string pattern: (NSString *)pattern;

/* 由于目前的项目需要一个至多两位小数的正则表达式 */
+ (BOOL)validateMoney:(NSString *)money;

+ (NSString *)clearSpace:(NSString *)string;

// 判断字符串是否全部为数字
+ (BOOL)isAllNmubersWithText:(NSString *)text;

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)numText;

/**
 *  判断邮编
 */
+ (BOOL) isValidZipcode:(NSString*)value;


/**
 输入金额保留2位小数
 */
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**
  比较两个版本号的大小
 @param version APP Store 版本号
 @return 版本号相等,返回NO;大于 返回YES
 */
+ (BOOL)compareVesionWithServerVersion:(NSString *)version;

/**
 对图片尺寸进行压缩
 */
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;


/**
 MD5字符串加密
 */
+ (NSString *)MD5ForLower32Bate:(NSString *)str;


/**
 获取设备UUID
 */
+ (NSString *)getDeviceUUID;


/**
 倒计时
 @param countTime 时间/秒
 */
+ (void)hh_CountDownTimer:(NSInteger)countTime timeBlock:(void (^)(NSInteger time, dispatch_source_t timer))timeBlock;
/**
 倒计时
 @param countBtn 按钮
 @param countTime 时间/秒
 */
+ (void)hh_CountDownTimer:(UIButton *)countBtn CountTime:(NSInteger)countTime;



/**
 检查相机权限
 @param ctrl 控制器VC
 @param canelBlock 取消
 */
+ (void)checkCameraAuthority:(UIViewController *)ctrl cancelBlock:(void(^)(void))canelBlock;

/**
 检查联系人权限
 @param ctrl 控制器VC
 @param canelBlock 取消
 */
+ (void)checkContactsAuthority:(UIViewController *)ctrl allowlBlock:(void(^)(void))allowlBlock cancelBlock:(void(^)(void))canelBlock;

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+ (BOOL)isNineKeyBoard:(NSString *)string;


/**
 文件夹大小(字节)
 */
+ (unsigned long long)folderSizeAtPath:(NSString *)folderPath;

/**
 单个文件的大小(字节)
 */
+ (unsigned long long)fileSizeAtPath:(NSString *)filePath;


/**
 数字金额转大写
 */
+ (NSString *)getConvertMoneyByString:(NSString*)amountString;


@end











