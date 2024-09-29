//
//  UIColor+HHExtension.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/23.
//

#import "UIColor+HHExtension.h"

@implementation UIColor (HHExtension)

+ (UIColor *)hh_ColorWithString:(NSString *)hexString
{
    return [[self class] hh_ColorWithString:hexString alpha:1.0];
}

+ (UIColor *)hh_ColorWithString:(NSString *)hexString alpha:(CGFloat)alpha
{
    // We found an empty string, we are returning nothing
    if (hexString.length == 0) {
        return nil;
    }
    
    // Check for hash and add the missing hash
    if('#' != [hexString characterAtIndex:0]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    
    // returning no object on wrong alpha values
    NSArray *validHexStringLengths = @[@4, @5, @7, @9];
    NSNumber *hexStringLengthNumber = [NSNumber numberWithUnsignedInteger:hexString.length];
    if ([validHexStringLengths indexOfObject:hexStringLengthNumber] == NSNotFound) {
        return nil;
    }
    
    // if the hex string is 5 or 9 we are ignoring the alpha value and we are using the value from the hex string instead
    CGFloat handedInAlpha = alpha;
    if (5 == hexString.length || 9 == hexString.length) {
        NSString *alphaHex;
        if (5 == hexString.length) {
            alphaHex = [hexString substringWithRange:NSMakeRange(4, 1)];
        } else {
            alphaHex = [hexString substringWithRange:NSMakeRange(7, 2)];
        }
        if (1 == alphaHex.length) alphaHex = [NSString stringWithFormat:@"%@%@", alphaHex, alphaHex];
        //hexString = [NSString stringWithFormat:@"#%@", [hexString substringFromIndex:9 == hexString.length ? 7 : 3]];
        hexString = [NSString stringWithFormat:@"#%@", [hexString substringWithRange:NSMakeRange(1, 9 == hexString.length ? 6 : 3)]];
        unsigned alpha_u = [[self class] hh_HexValueToUnsigned:alphaHex];
        handedInAlpha = ((CGFloat) alpha_u) / 255.0;
    }
    
    // check for 3 character HexStrings
    hexString = [hexString hh_HexStringTransformFromThreeCharacters];
    
    NSString *redHex    = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt = [[self class] hh_HexValueToUnsigned:redHex];
    
    NSString *greenHex  = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt = [[self class] hh_HexValueToUnsigned:greenHex];
    
    NSString *blueHex   = [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt = [[self class] hh_HexValueToUnsigned:blueHex];
    
    UIColor *color = [UIColor hh_ColorWith8BitRed:redInt green:greenInt blue:blueInt alpha:handedInAlpha];
    
    return color;
}

+ (UIColor *)hh_ColorWith8BitRed:(NSInteger)red
                           green:(NSInteger)green
                            blue:(NSInteger)blue {
    return [[self class] hh_ColorWith8BitRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)hh_ColorWith8BitRed:(NSInteger)red
                           green:(NSInteger)green
                            blue:(NSInteger)blue
                           alpha:(CGFloat)alpha {
    UIColor *color = nil;
#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
    color = [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
#else
    color = [UIColor colorWithCalibratedRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
#endif
    
    return color;
}

+ (unsigned)hh_HexValueToUnsigned:(NSString *)hexValue
{
    unsigned value = 0;
    
    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];
    
    return value;
}



UIColor * HH_RGBColor(NSInteger r,NSInteger g,NSInteger b) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}
UIColor * HH_RGBColorWithAlpha(NSInteger r,NSInteger g,NSInteger b,CGFloat alpha) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}
UIColor * HH_HexColor(NSString *hexString) {
    return [UIColor hh_ColorWithString:hexString];
}

UIColor * HH_HexColorAlpha(NSString *hexString,CGFloat alpha) {
    return [UIColor hh_ColorWithString:hexString alpha:alpha];
}


/**
 返回系统cell的分割线的颜色
 */
+ (nonnull UIColor *)hh_CellSeparatorColor {
    return [self hh_ColorWithString:@"cccccc" alpha:1.0];
}

/**
 根据图片获取图片的主色调
 */
+ (UIColor *)mostColor:(UIImage*)image{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(image.size.width/2, image.size.height/2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}


@end


@implementation NSString (hh_StringTansformer)

- (NSString *)hh_HexStringTransformFromThreeCharacters;
{
    if(self.length == 4)
    {
        NSString * hexString = [NSString stringWithFormat:@"#%1$c%1$c%2$c%2$c%3$c%3$c",
                                [self characterAtIndex:1],
                                [self characterAtIndex:2],
                                [self characterAtIndex:3]];
        return hexString;
    }
    
    return self;
}

@end
