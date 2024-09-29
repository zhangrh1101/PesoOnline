//
//  ApiMacro.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/8.
//

#ifndef ApiMacro_h
#define ApiMacro_h

//请求成功
#define HTTP_SUCCESS            @"000000"
#define HTTP_UNLOGIN            @"501"       //用户未登录
#define HTTP_LOGIN_UNBIND       @"7038"      //第三方登录手机号未绑定

//#define HTTP_UNLOGIN          @"1001"       //未登录或会话超时
//#define HTTP_OTHERDEVLOGIN    @"1002"       //在其他设备上登录

#define HTTPErrorMessege        @"网络突然开小差了~"

/* 测试环境 */
#define  RequestBaseURL         @"http://192.168.74.100:8082/auth"               //API
#define  VideoBaseURL           @"http://192.168.74.100:8082/auth"               //视频播放API
#define  HTMLBaseURL            @"http://192.168.74.100:8082/auth"               //H5前缀
#define  ShareBaseUrl           @"http://192.168.74.100:8082/auth"               //分享

/* 正式环境 */
//#define  RequestBaseURL    @"http://192.168.74.100:8082/auth"               //API
//#define  VideoBaseURL      @"http://192.168.74.100:8082/auth"               //视频播放API
//#define  HTMLBaseURL       @"http://192.168.74.100:8082/auth"               //H5前缀
//#define  ShareBaseUrl      @"http://192.168.74.100:8082/auth"               //分享


/*版本更新*/
#define  AppVersionUrl              @"/auth_api/app/mem/ios/vers/"                     //获取最新版本配置内容
/*开关*/
#define  AppSwitchUrl               @"/auth_api/app/mem/ios/version/"
/*获取域名列表*/
#define  HttpApiListUrl             @"/pub_api/domains"                                //获取域名列表
#define  CheckApiCanUseUrl          @"auth_api/reToken"                                //检查域名是否可用

/*公开文件信息*/
#define  UploadPublicFileUrl        @"/member/upload/o_upload"                         //文件上传（图片、视频）
/*广告*/
#define  LaunchAdverImageUrl        @"/appContent/openBanner"                          //开屏广告

/*登录模块*/
#define  LoginWithPhoneUrl          @"/auth_api/auth/token"                            //手机号登录
#define  RegistWithPhoneUrl         @"/auth_api/reg/mem"                               //手机号注册
#define  ForgetWithPhoneUrl         @"/auth_api/auth/forget"                           //忘记密码
#define  RegistVerificCodeUrl       @"/auth_api/sms/send/reg"                          //获取注册验证码
#define  ForgetVerificCodeUrl       @"/auth_api/sms/send/forget"                       //获取忘记密码验证码


#endif /* ApiMacro_h */
