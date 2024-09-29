//
//  ConstHeader.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/8.
//

#ifndef ConstMacro_h
#define ConstMacro_h

#import <UIKit/UIKit.h>

//本地缓存版本号
#define LOACL_APP_VERSION       @"RMWL_APP_VERSION"
//是否同意用户隐私
#define LOACL_AGREE_PRIVACY     @"LOACL_AGREE_PRIVACY"

//客服电话☎️
#define SERVICE_TEL_PHONE    @"4008113883"


//用户协议
#define USER_AGREEMENT_URL   @"https://www.kuaijiasu.xyz/priv.html"
//隐私协议
#define USER_PRIVACY_URL     @"https://www.kuaijiasu.xyz/private.html"

//阿里云一键登录Key
#define AliCloud_AuthKey @"93HNXS84hxtxUVJhQidGzsI/q1wtVwJW1IMuF/Crmgw+BUQ26qrO2D5m/dPZyYGWFdVB/QPOxW6DeGR5tBe1RU5DGhWRfgq0+5LlhcNuC2lydH5Vg+ZknMGn/IBC8QwQQ27jqBl3Ei6L++j9HfhpNYl4E13cLceJW5vF0tigODxrWfVr25uao2DKs7os4jRbZOVMQOfROEKHHnZ5fOJ6ioAdA8i7dRHSylXW21FzJ3UnQTo+mtSEZBeDmn+DwX/Qow2PiVbM0uQ="


/* 友盟推送配置 */
#define UMengPushKey            @"631995a99855331be1658dc5"
#define UMengPushSecret         @"zcemnwsjl7znuu0fcyrgi2zcwd8wfezn"
#define UMengPushAlias          @"test_"         //测试环境推送别名前缀
//#define UMengPushAlias          @"prod_"         //生产环境推送别名前缀

/* 高德地图配置 */
#define AMapServices_KEY     @"a5194f796defa06e821f11b5ba1117b5"

//https://api.rmwl.cn/app/rmwl/
//https://new.peopletrip.cn/app/rmwl/
#define WX_UNIVERSAL_LINK    @"https://api.rmwl.cn/app/rmwl/"
#define QQ_UNIVERSAL_LINK    @"https://new.peopletrip.cn/qq_conn/1109168857"
#define WB_UNIVERSAL_LINK    @"https://new.peopletrip.cn/apps/3791286239/privilege/oauth"

#define QQAppId              @"1109168857"
#define QQAppKey             @"8qgzc1rTnSTIVBNx"

#define WXAppId              @"wx62903fb8db1f7e3b"
#define WXAppSecret          @"7418926d57bf843c01de19967a233b33"

#define WBAppKey             @"3791286239"
#define WBAppSecret          @"e0e5ea77aba18bb89597f687b31af0f5"

#define ShareIdentify        @"group.com.znxi.cash.ImageShare"

#define AliPushAppKey        @"28038815"
#define AliPushAppSecret     @"f5b3ff786a385537257863972ec95d0d"


//默认占位图
#define PlaceHolderAvatar        [UIImage imageNamed:@"placeholder_user"]
#define PlaceHolderImage_80      [UIImage imageNamed:@"placeholder_80"]
#define PlaceHolderImage_90      [UIImage imageNamed:@"placeholder_90"]
#define PlaceHolderImage_195     [UIImage imageNamed:@"placeholder_195"]
#define PlaceHolderImage_375     [UIImage imageNamed:@"placeholder_375"]



//账号登陆状态类型
#define   LOGIN_NONE        @"NONE"
#define   LOGIN_LOGIN       @"LOGIN"
#define   LOGIN_CAPTCHA     @"CAPTCHA"         //需要验证码
#define   LOGIN_PERFECT     @"PERFECT"         //账号信息需要补全
#define   LOGIN_NO_CORP     @"NO_CORP"         //账号无企业
#define   LOGIN_OK          @"OK"              //账号有企业信息

//获取验证码类型
#define   SMS_LOGIN        @"LOGIN"
#define   SMS_FORGET       @"FORGET"


#define PushCenter  @"test_"     //测试环境推送别名前缀
//#define PushCenter  @"prod_"     //生产环境推送别名前缀


//static NSString * const kUserPhoneNumber = @"kUserPhoneNumber";   //用户标识
//static NSString * const kAppIsOnLine = @"kAppIsOnLine";   //记录上线状态
//static NSString * const kRememberPassWord = @"kRememberPassWord";   //记录密码状态
//static NSString * const kUserIsLogin = @"kUserIsLogin";   //记录登录状态
//static NSString * const kFirstStartApp = @"firstStartApp";   //第一次启动APP


/* 本地存储 */
//开关
static NSString * const KDefaultsSwitch = @"KDefaultsSwitch";
//存储是否为最新版本
static NSString * const KDefaultsLineVersion = @"KDefaultsLineVersion";
//手机号码
static NSString * const KDefaultsUserCellPhone = @"KDefaultsUserCellPhone";
//登录账号
static NSString * const KDefaultsUserAccount = @"KDefaultsUserAccount";
//登录密码
static NSString * const KDefaultsUserPassword = @"KDefaultsUserPassword";
//获取手机DeviceID
static NSString * const KDefaultsPhoneDeviceUUID = @"KDefaultsPhoneDeviceUUID";
//存储是否全局
static NSString * const KDefaultsStatusGlobal = @"KDefaultsStatusGlobal";
//存储默认线路
static NSString * const KDefaultsPathModel = @"KDefaultsPathModel";
//存储默认Config配置
static NSString * const KDefaultsConfigDict = @"KDefaultsConfigDict";

/* 通知 */
//刷新用户Token
static NSString * const KNotificationRefreshUserToken = @"KNotificationRefreshUserToken";
//链接状态
static NSString * const KNotificationRefreshConnectStatus = @"KNotificationRefreshConnectStatus";
//回到登陆页
static NSString * const KNotificationGoBackLogin = @"KNotificationGoBackLogin";
//刷新用户信息
static NSString * const KNotificationRefreshUserInfo = @"KNotificationRefreshUserInfo";
//刷新手机号
static NSString * const KNotificationRefreshUserPhone = @"KNotificationRefreshUserPhone";


/* 新闻列表样式类型 XG-小图广告，DG-大图广告， WT-无图,SP-视频，MI-多图，DI-单图 */
static NSString * const NEWS_STYLE_WT = @"WT";                        //无图
static NSString * const NEWS_STYLE_DI = @"DI";                        //单图
static NSString * const NEWS_STYLE_MI = @"MI";                        //多图
static NSString * const NEWS_STYLE_SP = @"SP";                        //视频
static NSString * const NEWS_STYLE_XG = @"XG";                        //小图广告
static NSString * const NEWS_STYLE_DG = @"DG";                        //大图广告

static NSString * const NEWS_TYPE_NEWS  = @"NEWS";                    //新闻—NEWS
static NSString * const NEWS_TYPE_SP    = @"SP";                      //视频—SP
static NSString * const NEWS_TYPE_WLH   = @"WLH";                     //文旅号—WLH
static NSString * const NEWS_TYPE_GC    = @"GC";                      //观察—GC
static NSString * const NEWS_TYPE_GD    = @"GD";                      //观点访谈—GD
static NSString * const NEWS_TYPE_RW    = @"RW";                      //人物发声—RW
static NSString * const NEWS_TYPE_ZT    = @"ZT";                      //专题—ZT
static NSString * const NEWS_TYPE_ZTZY  = @"ZTZY";                    //专题主页—ZTZY
static NSString * const NEWS_TYPE_ZTLM  = @"ZTLM";                    //专题栏目—ZTLM


static NSString * const NEWSPOINT_STYLE_RW = @"RW";                   //人物发声
static NSString * const NEWSPOINT_STYLE_GD = @"GD";                   //观点访谈



//员工状态
static NSString * const Employee_State_WORKING        = @"WORKING";           //在职
static NSString * const Employee_State_DISSMISSION    = @"DISSMISSION";       //离职
static NSString * const Employee_State_RETIRE         = @"RETIRE";            //退休

//账号状态
static NSString * const Account_State_OK              = @"OK";                //正常
static NSString * const Account_State_DISABLED        = @"DISABLED";          //已移除

//性别
static NSString * const User_Sex_MALE                 = @"1";               //男
static NSString * const User_Sex_FEMALE               = @"2";               //女
static NSString * const User_Sex_SECRECY              = @"3";               //保密


//发送短信类型
typedef NS_ENUM(NSInteger, SendSMSCodeType) {
    SendSMSCodeTypePublic = 1,
    SendSMSCodeTypeLogin,                   //登录
    SendSMSCodeTypeRegister,                //注册
    SendSMSCodeTypeBindPhone,               //绑定
    SendSMSCodeTypeChangeBind,              //换绑
    SendSMSCodeTypeChangePassword,          //改密
};


//新闻类型
typedef NS_ENUM(NSInteger, NewsDetailType) {
    NewsDetailTypeWLH = 1,          //文旅号
    NewsDetailTypeGD,               //观点访谈
    NewsDetailTypeRW,               //人物发声
    NewsDetailTypeGC,               //观察
    NewsDetailTypeZT,               //专题
};



#endif /* ConstHeader_h */
