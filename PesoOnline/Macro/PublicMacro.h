//
//  PublicMacro.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/8.
//

#ifndef PublicMacro_h
#define PublicMacro_h

/**
 *  Get App name
 */
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
/**
 *  Get App Identifier
 */
#define APP_IDENTIFIER   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
/**
 *  Get App version
 */
#define APP_VERSION     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/**
 *  Get App build
 */
#define APP_BUILD [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/**
 *  Get KeyWindow
 */
#define APP_KeyWindow [UIApplication sharedApplication].keyWindow


//最大最小值
#define MaxX(frame) CGRectGetMaxX(frame)
#define MaxY(frame) CGRectGetMaxY(frame)
#define MinX(frame) CGRectGetMinX(frame)
#define MinY(frame) CGRectGetMinY(frame)

//宽度高度
#define Width(frame)    CGRectGetWidth(frame)
#define Height(frame)   CGRectGetHeight(frame)

#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

//宏定义
#define KFontSize(size) FontSize(size)
/**
 *  字体适配 我在PCH文件定义了一个方法
 */
static inline CGFloat FontSize(CGFloat fontSize){
    if (SCREEN_WIDTH < 375) {
        return fontSize - 1;
    }else if (SCREEN_WIDTH == 375){
        return fontSize;
    }else{
        return fontSize + 1;
    }
}
//字体
#define KFONT(R)                     [UIFont systemFontOfSize:KFontSize((R))]
#define KBOLDFONT(R)                 [UIFont boldSystemFontOfSize:KFontSize((R))]
#define KNAMEFONT(N, R)              [UIFont fontWithName:(N) size:KFontSize(R)]

#define KFontHarmonyOSLight(R)      [UIFont fontWithName:@"HarmonyOS_Sans_SC_Light" size:KFontSize((R))]
#define KFontHarmonyOSMedium(R)     [UIFont fontWithName:@"HarmonyOS_Sans_SC_Medium" size:KFontSize((R))]
#define KFontSemiBold(R)            [UIFont fontWithName:@"SourceHanSerifCN-SemiBold" size:KFontSize((R))]
#define KFontFZYaSong(R)            [UIFont fontWithName:@"FZYaSong-R-GBK" size:KFontSize((R))]

//判断刘海屏
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)
#define IS_IPHONE_X (IS_IOS_11 && IS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 812))

//状态栏高度
#define KStatusBarHeight   [[UIApplication sharedApplication] statusBarFrame].size.height
#define KNavigationHeight  44.0
//整个导航栏高度
#define KNavBarHeight      (KStatusBarHeight + KNavigationHeight)
//底部tabbar高度
#define KTabBarHeight      (IS_IPHONE_X ? 83 : 49)
//底部安全距离
#define KSafeAreaMargin    (IS_IPHONE_X ? 34 : 0)

//系统版本号
#define VersionLargerThan(R)  ([[[UIDevice currentDevice] systemVersion] floatValue] >= (R))

//是否为iPhone X机型
#define KIsiPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? YES : NO)


#define ValidStr(f)       (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define ValidDict(f)      (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f)     (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f)       (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f)      (f!=nil && [f isKindOfClass:[NSData class]])

#define DomainMaskPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define HHAlertShow(messageText,buttonName) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:(messageText) \
delegate:nil cancelButtonTitle:(buttonName) otherButtonTitles: nil];\
[alert show];

//推荐用这个打印我们的日志:功能、行数
#ifdef DEBUG

#define HHLog( s, ... ) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
[dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss:SSSSSS"]; \
NSString *time = [dateFormatter stringFromDate:[NSDate date]];\
printf("%s <%s:(%d)> %s\n", [time UTF8String], [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String]); }

#else
#define HHLog( s, ... )
#endif

//#ifdef DEBUG
//
//#define HHLog(FORMAT, ...)  (stderr, "%s:%ld\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);
//#else
//#define HHLog(FORMAT, ...) nil
//#endif


//弱引用
#define WeakSelf    __weak __typeof(self)weakSelf = self;
#define StrongSelf  __strong typeof(weakSelf) strongSelf = weakSelf;

//字符串相等
#define IsEqualStr(str1,str2) ([str1 isEqualToString:str2])
//数字转转string
#define S_Interger(num1) ([NSString stringWithFormat:@"%ld",(long)num1])
//NSNumber转转string
#define S_Number(R) ([NSString stringWithFormat:@"%@",(R)])

//字符串
#define KString( s, ... )            ([NSString stringWithFormat:(s), ##__VA_ARGS__])
#define KIntString(int)              ([NSString stringWithFormat:@"%d",(int)int])
#define KIntegerString(integer)      ([NSString stringWithFormat:@"%ld",(long)integer])
#define KFloatString(float)          ([NSString stringWithFormat:@"%.2f",float])

//图片
#define KIMAGE(imgName) [UIImage imageNamed:imgName]

#define KURL(url) [NSURL URLWithString:url]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]



#define  AdjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)


//单例
// @interface
#define singleton_interface(className) \
+ (className *)shared##className;

// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}



#endif /* PublicMacro_h */
