//
//  HH_Utilities.m
//  B2B
//
//  Created by Zzzzzzzzz💤 on 16/3/16.
//  Copyright © 2016年 Zzzzzzzzz💤. All rights reserved.
//

#import "HH_Utilities.h"
#import "UIAlertController+Extension.h"
#import <AVFoundation/AVFoundation.h>
#import <Contacts/Contacts.h>

#import "DESCode.h"
#import <CommonCrypto/CommonDigest.h>
#import <SAMKeychain/SAMKeychain.h>

@implementation HH_Utilities

/**
 *  判断是否为空格或者空值
 *
 *  @param string 输入源
 *
 *  @return 空 : 为真   非空:为假
 */

+ (BOOL)isBlankString:(NSString *)string{
    
    if (!string) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!string.length) {
        return YES;
    }
    NSString *trimmedStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}


/**
 如果没值返回空字符串
 */
+ (NSString *)blankString:(NSString *)string {
    if (!string) {
        return @"";
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (!string.length) {
        return @"";
    }
    NSString *trimmedStr = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!trimmedStr.length) {
        return @"";
    }
    return string;
}

//n位数字
+ (BOOL)checkNum:(NSString *)number
{
    //n位数字
    NSString *MOBILE = @"^\\d{4}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:number];
    
}


//匹配手机号码
+ (BOOL)checkTelNumber: (NSString *)telNumber
{
    //1 + [3.4.5.7.8.9]任意一位 + 9位数字
//    NSString *MOBILE = @"^[1][0-9][0-9]{9}$";
    NSString *MOBILE = @"^1(3[0-9]|4[579]|5[0-35-9]|6[6]|7[0-35-9]|8[0-9]|9[89])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:telNumber];
    
}

//匹配用户密码6-15位数字和字母结合
+ (BOOL)checkPassword:(NSString *)password
{
    return [self checkWithString: password pattern: @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,15}$"];
}

//密码的首字母是数字或字母
+ (BOOL)checkPasswordFirstWord:(NSString *)password
{
    NSString *firstword = [password substringToIndex:1];
    return [self checkWithString:firstword pattern:@"^[a-zA-Z0-9]"];
}

//匹配用户名，20位以下的中文或英文
+ (BOOL)checkUserName: (NSString *)userName
{
    return [self checkWithString: userName pattern: @"^[a-zA-Z一-龥]{1,20}"];
}

//校验邮箱
+ (BOOL)checkEmail:(NSString*)email {
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self checkWithString:email pattern:emailRegex];
}

//匹配用户身份证
+ (BOOL)checkUserIdentifier: (NSString *)userIdentifier
{
    return [self checkWithString: userIdentifier pattern: @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X|x)$)"];
}

//匹配URL
+ (BOOL)checkURL: (NSString *)url
{
    return [self checkWithString: url pattern: @"^[0-9A-Za-z]{1,50}"];
}

//验证URL是否非法
+ (BOOL)validateURL: (NSString *)url
{
    NSString *pattern = @"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *regexArray = [regex matchesInString:url options:0 range:NSMakeRange(0, url.length)];
  
    if (regexArray.count > 0) return YES;
    
    return NO;
}

#pragma mark - 抽象验证方法
+ (BOOL)checkWithString: (NSString *)string pattern: (NSString *)pattern
{
    NSPredicate * pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject: string];
}

+ (BOOL)validateMoney:(NSString *)money
{
    NSString *phoneRegex = @"^[0-9]+(\\.[0-9]{1,2})?$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:money];
}

+ (NSString *)clearSpace:(NSString *)string{
    
    NSString *newStr1 = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *newStr2 = [newStr1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newStr2;
}

// 判断字符串是否全部为数字
+ (BOOL)isAllNmubersWithText:(NSString *)text
{
    //^[0-9]*$
    NSString *numbers = @"^[0-9]+$";
    NSPredicate *numbersTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numbers];
    return [numbersTest evaluateWithObject:text];
}


//判断字符串是否为整形：
+ (BOOL)isPureInt:(NSString*)numText{
    
    if ([numText hasPrefix:@"0"]) {
        return NO;
    }
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < numText.length) {
        NSString * string = [numText substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            
//            [MBProgressHUD showMessage:@"填写金额请为整数"];
            return NO;
        }
        i++;
    }
    return YES;
}


+ (BOOL)validateMobile:(NSString *)mobileNum{
    
    NSString *MOBILE = @"^1[34578]\\d{9}$";
    
    NSPredicate *regexTestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    
    if ([regexTestMobile evaluateWithObject:mobileNum]) {
        
        return YES;
    }else {
            
        return NO;
    }
}
    
/**
 *  判断邮编
 */
+ (BOOL) isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    NSInteger len = strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return NO;
        }
    }
    return YES;
}



/**
 输入金额保留2位小数
 */
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSString * str = [NSString stringWithFormat:@"%@%@",textField.text,string];
    //匹配以0开头的数字
    NSPredicate * predicate0 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^[0][0-9]+$"];
    //匹配两位小数、整数
    NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"^(([1-9]{1}[0-9]*|[0]).?[0-9]{0,2})$"];
    
    return ![predicate0 evaluateWithObject:str] && [predicate1 evaluateWithObject:str] && ![str isEqualToString:@"0.00"] ? YES : NO;
}


/**
  比较两个版本号的大小
 @param version APP Store 版本号
 @return 版本号相等,返回NO;大于 返回YES
 */
+ (BOOL)compareVesionWithServerVersion:(NSString *)version {
    NSArray *versionArray = [version componentsSeparatedByString:@"."];//拿到iTunes获取App的版本
    NSArray *currentVesionArray = [APP_VERSION componentsSeparatedByString:@"."];//当前版本
    NSInteger a = (versionArray.count > currentVesionArray.count)?currentVesionArray.count : versionArray.count;
    BOOL haveNew = NO;
    for (int i = 0; i < a; i++) {
        NSInteger a = [[versionArray objectAtIndex:i] integerValue];
        NSInteger b = [[currentVesionArray objectAtIndex:i] integerValue];
        if (a > b) {
            haveNew = YES;
        }else{
            haveNew = NO;
        }
    }
    if (haveNew) {
        NSLog(@"APP store 版本号大于当前版本号：有新版本更新");
    }else{
        NSLog(@"APP store 版本号小于等于当前版本号：没有新版本");
    }
    return haveNew;
}


//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}


//MD5字符串加密
+ (NSString *)MD5ForLower32Bate:(NSString *)str{

    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}



/**
 获取设备UUID
 */
+ (NSString *)getDeviceUUID {
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



/**
 倒计时
 @param countTime 时间/秒
 */
+ (void)hh_CountDownTimer:(NSInteger)countTime timeBlock:(void (^)(NSInteger time, dispatch_source_t timer))timeBlock {
    
    __block int time = countTime - 1; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                timeBlock(0, _timer);
            });
            
        }else{
            
            int seconds = time % countTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                timeBlock(seconds, _timer);
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

/**
 倒计时
 @param countBtn 按钮
 @param countTime 时间/秒
 */
+ (void)hh_CountDownTimer:(UIButton *)countBtn CountTime:(NSInteger)countTime{
    
    __block NSInteger time = countTime - 1; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [countBtn setTitle:@"重新获取" forState:UIControlStateNormal];
//                [countBtn setTitleColor:MainRedColor forState:UIControlStateNormal];
                countBtn.enabled = YES;
                countBtn.alpha = 1;//透明度
            });
            
        }else{
            
            int seconds = time % countTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [countBtn setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
//                [countBtn setTitleColor:MainRedColor forState:UIControlStateNormal];
                countBtn.enabled = NO;
                countBtn.alpha = 0.5;//透明度
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}



/**
 检查相机权限
 @param ctrl 控制器VC
 @param canelBlock 取消
 */
+ (void)checkCameraAuthority:(UIViewController *)ctrl cancelBlock:(void(^)(void))canelBlock {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {//第一次使用
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!granted) {//第一次，用户选择拒绝
                    canelBlock();
                }
            });
        }];
    }else if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIAlertController showViewController:ctrl title:@"相机权限未开启" message:@"\n请进入系统【设置】>【隐私】>【相机】中打开开关,开启相机功能" titleArray:@[@"去设置"] cancel:@"取消" style:UIAlertControllerStyleAlert alertAction:^(NSInteger tag) {
                switch (tag) {
                    case 0:
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                        break;
                    default:
                        break;
                }
            } cancelAction:^{
                canelBlock();
            }];
        });
    }
}


/**
 检查联系人权限
 @param ctrl 控制器VC
 @param canelBlock 取消
 */
+ (void)checkContactsAuthority:(UIViewController *)ctrl allowlBlock:(void(^)(void))allowlBlock cancelBlock:(void(^)(void))canelBlock {
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusNotDetermined) {
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
                if (!granted) {//第一次，用户选择拒绝
                    canelBlock();
                }else{
                    allowlBlock();
                }
            }];
        }
        else if (status == CNAuthorizationStatusAuthorized) {
            allowlBlock();
        }
        else if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIAlertController showViewController:ctrl title:@"通讯录权限未开启" message:@"\n请进入系统【设置】>【隐私】>【通讯录】中打开开关,开启联系人功能" titleArray:@[@"去设置"] cancel:@"取消" style:UIAlertControllerStyleAlert alertAction:^(NSInteger tag) {
                    switch (tag) {
                        case 0:
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                            break;
                        default:
                            break;
                    }
                } cancelAction:^{
                    canelBlock();
                }];
            });
        }
    }
}


/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+ (BOOL)isNineKeyBoard:(NSString *)string {
    
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        unichar a=[string characterAtIndex:i];
        if(!((isalpha(a))
             ||(isalnum(a))
             ||((a=='_') || (a == '-'))
             ||((a >= 0x4e00 && a <= 0x9fa6))
             ||([other rangeOfString:string].location != NSNotFound)
             ))
            return NO;
    }
    return YES;
}



/**
 文件夹大小(字节)
 */
+ (unsigned long long)folderSizeAtPath:(NSString *)folderPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString *fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

/**
 单个文件的大小(字节)
 */
+ (unsigned long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


/**
 数字金额转大写
 */
+ (NSString *)getConvertMoneyByString:(NSString*)amountString {
    
    if (!amountString || ([amountString doubleValue] == [@"0.00" doubleValue]))
    {
        return @"零元整";
    }
    //首先转化成标准格式        “200.23”
    NSString *doubleStr = nil;
    doubleStr = [NSString stringWithFormat:@"%.2f",[amountString doubleValue]];
    NSMutableString *tempStr= nil;
    tempStr = [[NSMutableString alloc] initWithString:doubleStr];
    //位
    NSArray *carryArr1=@[@"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ,@"京",@"十京",@"百京",@"千京垓",@"十垓",@"百垓",@"千垓秭",@"十秭",@"百秭",@"千秭穰",@"十穰",@"百穰",@"千穰"];
    NSArray *carryArr2=@[@"分",@"角"];
    //数字
    NSArray *numArr=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];

    NSArray *temarr = [tempStr componentsSeparatedByString:@"."];
    //小数点前的数值字符串
    NSString *firstStr=[NSString stringWithFormat:@"%@",temarr[0]];
    //小数点后的数值字符串
    NSString *secondStr=[NSString stringWithFormat:@"%@",temarr[1]];

    //是否拼接了“零”，做标记
    bool zero=NO;
    //拼接数据的可变字符串
    NSMutableString *endStr= [[NSMutableString alloc] init];

    //首先遍历firstStr，从最高位往个位遍历    高位----->个位
    for(int i=(int)firstStr.length;i>0;i--)
    {
        //取最高位数
        NSInteger MyData=[[firstStr substringWithRange:NSMakeRange(firstStr.length-i, 1)]
                          integerValue];

        if ([numArr[MyData] isEqualToString:@"零"])
        {
            if ([carryArr1[i-1] isEqualToString:@"万"]||[carryArr1[i-1] isEqualToString:@"亿"]||[carryArr1[i-1] isEqualToString:@"元"]||[carryArr1[i-1] isEqualToString:@"兆"])
            {
                if (zero) //去除有“零万”
                {
                    endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:(endStr.length-1)]];
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }
                else
                {
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }

                //去除有“亿万”、"兆万"的情况
                if ([carryArr1[i-1] isEqualToString:@"万"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"亿"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                }
                //去除“兆亿”
                if ([carryArr1[i-1] isEqualToString:@"亿"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                }
            }else{
                if (!zero) {
                    [endStr appendString:numArr[MyData]];
                    zero=YES;
                }
            }
        }else{
            //拼接数字
            [endStr appendString:numArr[MyData]];
            //拼接位
            [endStr appendString:carryArr1[i-1]];
            //不为“零”
            zero=NO;
        }
    }

    //再遍历secondStr    角位----->分位
    if ([secondStr isEqualToString:@"00"]) {
        [endStr appendString:@"整"];
    }else{
       //如果最后一位位0就把它去掉
        if (secondStr.length > 1 && [secondStr hasSuffix:@"0"])
        {
            secondStr = [secondStr substringToIndex:(secondStr.length - 1)];
        }
        for(int i=(int)secondStr.length;i>0;i--)
        {
            //取最高位数
            NSInteger MyData=[[secondStr substringWithRange:NSMakeRange(secondStr.length-i, 1)] integerValue];
            [endStr appendString:numArr[MyData]];
            [endStr appendString:carryArr2[i-1]];
        }
    }
    //add song
    if ([endStr hasPrefix:@"元"])
    {
        return  (NSString *)[endStr substringFromIndex:1];
    }
    return endStr;
}

@end


















