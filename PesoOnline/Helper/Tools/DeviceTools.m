//
//  DeviceTools.m
//  Vmess
//
//  Created by qiaofeng wu on 2020/11/2.
//  Copyright © 2020 wxflyme. All rights reserved.
//

#import "DeviceTools.h"
#import <sys/utsname.h>

@implementation DeviceTools

//获取ios设备号
+ (NSString *)deviceType {

//    padType = @"";
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone5c";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone5s";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone6Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone6sPlus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhoneSE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone7Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone7Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone8";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone8";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone8Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone8Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhoneX";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhoneX";
    if ([deviceString isEqualToString:@"iPhone11,8"])   return @"iPhoneXR";
    if ([deviceString isEqualToString:@"iPhone11,2"])   return @"iPhoneXS";
    if ([deviceString isEqualToString:@"iPhone11,6"])   return @"iPhoneXSMax";
    if ([deviceString isEqualToString:@"iPhone11,4"])   return @"iPhoneXSMax";

    if ([deviceString isEqualToString:@"iPhone12,1"])   return @"iPhone11";
    if ([deviceString isEqualToString:@"iPhone12,3"])   return @"iPhone11Pro";
    if ([deviceString isEqualToString:@"iPhone12,5"])   return @"iPhone11ProMax";
    if ([deviceString isEqualToString:@"iPhone12,8"])   return @"iPhoneSE2";

    
    if ([deviceString isEqualToString:@"iPhone13,1"])   return @"iPhone12mini";
    if ([deviceString isEqualToString:@"iPhone13,2"])   return @"iPhone12";
    if ([deviceString isEqualToString:@"iPhone13,3"])   return @"iPhone12Pro";
    if ([deviceString isEqualToString:@"iPhone13,4"])   return @"iPhone12ProMax";
    
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPodTouch1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPodTouch2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPodTouch3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPodTouch4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPodTouch(5Gen)";

    if ([deviceString isEqualToString:@"iPad1,1"]){
        
        return @"iPad";
    }
    if ([deviceString isEqualToString:@"iPad1,2"]){
        
        return @"iPad3G";
    }
    if ([deviceString isEqualToString:@"iPad2,1"]){
        
        return @"iPad2(WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad2,2"]){
        
        return @"iPad2";
    }
    if ([deviceString isEqualToString:@"iPad2,3"]){
        
        return @"iPad2(CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad2,4"]){
        
        return @"iPad2";
    }
    if ([deviceString isEqualToString:@"iPad2,5"]){
        
        return @"iPadMini(WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad2,6"]){
        
        return @"iPadMini";
    }
    if ([deviceString isEqualToString:@"iPad2,7"]){
        
        return @"iPadMini(GSM+CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad3,1"]){
        
        return @"iPad3(WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad3,2"]){
        
        return @"iPad3(GSM+CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad3,3"]){
        
        return @"iPad3";
    }
    if ([deviceString isEqualToString:@"iPad3,4"]){
        
        return @"iPad4(WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad3,5"]){
        
        return @"iPad4";
    }
    if ([deviceString isEqualToString:@"iPad3,6"]){
        
        return @"iPad4(GSM+CDMA)";
    }
    if ([deviceString isEqualToString:@"iPad4,1"]){
        
        return @"iPadAir(WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad4,2"]){
        
        return @"iPadAir(Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad4,4"]){
        
        return @"iPadMini2(WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad4,5"]){
        
        return @"iPadMini2(Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad4,6"]){
        
        return @"iPadMini2";
    }
    if ([deviceString isEqualToString:@"iPad4,7"]){
        
        return @"iPadMini3";
    }
    if ([deviceString isEqualToString:@"iPad4,8"]){
        
        return @"iPadMini3";
    }
    if ([deviceString isEqualToString:@"iPad4,9"]){
        
        return @"iPadMini3";
    }
    if ([deviceString isEqualToString:@"iPad5,1"]){
        
        return @"iPadMini4(WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad5,2"]){
        
        return @"iPadMini4(LTE)";
    }
    if ([deviceString isEqualToString:@"iPad5,3"]){
        
        return @"iPadAir2";
    }
    if ([deviceString isEqualToString:@"iPad5,4"]){
        
        return @"iPadAir2";
    }
    if ([deviceString isEqualToString:@"iPad6,3"]){
        
        return @"iPadPro9.7";
    }
    if ([deviceString isEqualToString:@"iPad6,4"]){
        
        return @"iPadPro9.7";
    }
    if ([deviceString isEqualToString:@"iPad6,7"]){
        
        return @"iPadPro12.9";
    }
    if ([deviceString isEqualToString:@"iPad6,8"]){
        
        return @"iPadPro12.9";
    }
    if ([deviceString isEqualToString:@"iPad6,11"]){
        return @"iPad5(WiFi)";
    }
    if ([deviceString isEqualToString:@"iPad6,12"]){
        return @"iPad5(Cellular)";
    }
    if ([deviceString isEqualToString:@"iPad7,1"]){
        return @"iPadPro";
    }
    if ([deviceString isEqualToString:@"iPad7,2"]){
        return @"iPadPro";
    }
    if ([deviceString isEqualToString:@"iPad7,3"]){
        return @"iPadPro";
    }
    if ([deviceString isEqualToString:@"iPad7,4"]){
        return @"iPadPro";
    }
    if ([deviceString isEqualToString:@"iPad8,1"] || [deviceString isEqualToString:@"iPad8,2"] || [deviceString isEqualToString:@"iPad8,3"] || [deviceString isEqualToString:@"iPad8,4"] ){
        return @"iPadPro11inch";
    }
    if ([deviceString isEqualToString:@"iPad8,9"] ||[deviceString isEqualToString:@"iPad8,10"]){
        return @"iPadPro11inch2";
    }
    
    if ([deviceString isEqualToString:@"iPad8,5"] ||[deviceString isEqualToString:@"iPad8,6"]||[deviceString isEqualToString:@"iPad8,7"] ||[deviceString isEqualToString:@"iPad8,8"] ){
        return @"iPadPro";
    }
    
    if ([deviceString isEqualToString:@"iPad8,11"] ||[deviceString isEqualToString:@"iPad8,12"]){
        return @"iPadPro";
    }
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"AppleTV2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"AppleTV3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"AppleTV3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"AppleTV4";

    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";

    return deviceString;


}


+ (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

@end
