//
//  ColorMacro.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/8.
//

#ifndef ColorMacro_h
#define ColorMacro_h

//************************* Color ************************//

#define HHRandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 取色值相关的方法
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:1.f]

#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:(a)]

#define RGBOF(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define RGBA_OF(rgbValue)   [UIColor colorWithRed:((float)(((rgbValue) & 0xFF000000) >> 24))/255.0 \
green:((float)(((rgbValue) & 0x00FF0000) >> 16))/255.0 \
blue:((float)(rgbValue & 0x0000FF00) >> 8)/255.0 \
alpha:((float)(rgbValue & 0x000000FF))/255.0]

#define RGBAOF(v, a)        [UIColor colorWithRed:((float)(((v) & 0xFF0000) >> 16))/255.0 \
green:((float)(((v) & 0x00FF00) >> 8))/255.0 \
blue:((float)(v & 0x0000FF))/255.0 \
alpha:a]


#define kColorWhite      [UIColor whiteColor]
#define kColorBlack      [UIColor blackColor]

//主色调
#define ThemeColor           [UIColor colorWithHexString:@"#007AFF"]
#define ThemeLightColor      [UIColor colorWithHexString:@"#A654F1"]
#define ThemeDisableColor    [UIColor colorWithHexString:@"#9062E9"]
#define DisableBackColor     [UIColor colorWithHexString:@"#D8D8D8"]

#define RedThemeColor        [UIColor colorWithHexString:@"#D84323"]

#define BackgroudColor_F3    [UIColor colorWithHexString:@"#F3F3F3"]
#define BackgroudColor_F5    [UIColor colorWithHexString:@"#F5F5F5"]
#define BackGroundColor      [UIColor colorWithHexString:@"#F7F7F7"]

#define SeparationlineColor  [UIColor colorWithHexString:@"#EEEEEE"]
#define InvestBlackColor     [UIColor colorWithHexString:@"#222222"]
#define YellowBackColor      [UIColor colorWithHexString:@"#FFA10E"]
#define RedTipTextColor      [UIColor colorWithHexString:@"#F55200"]
#define BorderColor          [UIColor colorWithHexString:@"#CCCCCC"]

#define MainTextColor        [UIColor colorWithHexString:@"#262626"]
#define MainUnTextColor      [UIColor colorWithHexString:@"#808080"]
#define MainLightTextColor   [UIColor colorWithHexString:@"#A4A4A4"]
#define DarkTextColor        [UIColor colorWithHexString:@"#333333"]
#define DarkSubTextColor     [UIColor colorWithHexString:@"#666666"]
#define LightTextColor       [UIColor colorWithHexString:@"#999999"]
#define OrangeTextColor      [UIColor colorWithHexString:@"#FE5E13"]
#define PlaceholderColor     [UIColor colorWithHexString:@"#C5C5C5"]

#define BlueTextColor        [UIColor colorWithHexString:@"#4589FF"]
#define BlueLightTextColor   [UIColor colorWithHexString:@"#537BA9"]
#define BlueSystemTextColor  [UIColor colorWithHexString:@"#1677FF"]


//渐变色
#define GreenLightColor      [UIColor colorWithHexString:@"#00E0C5"]
#define GreenDarkColor       [UIColor colorWithHexString:@"#00AEC7"]


#endif /* ColorMacro_h */
