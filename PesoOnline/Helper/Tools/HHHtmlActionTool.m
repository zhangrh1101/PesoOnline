//
//  HHHtmlActionTool.m
//  RenMinSanNong
//
//  Created by Mac on 2021/9/16.
//

#import "HHHtmlActionTool.h"
#import <WebKit/WebKit.h>

#define EncryPassword_Key    @"getPsdFromWeb"
#define ShareLongImage_Key   @"getPostersUrl"


@interface HHHtmlActionTool () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic , strong) HHHtmlActionTool              * htmlActionTool;

@property (nonatomic , strong) WKWebView                     * webView;

//需要回调的类型
@property (nonatomic , assign) HHHtmlActionToolType            type;
@property (nonatomic , copy) void(^resultBlock)(id _Nullable result);

@end

//调用HTML方法
@implementation HHHtmlActionTool

static HHHtmlActionTool *htmlActionTool = nil;
+ (HHHtmlActionTool *)actionTool {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        htmlActionTool = [[HHHtmlActionTool alloc] init];
    });
    return htmlActionTool;
}


- (void)removeTool {
    
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:EncryPassword_Key];
    self.webView = nil;
}


- (void)loadFileWithType:(HHHtmlActionToolType)type resultBlock:(void (^)(id _Nullable result))resultBlock{
    
    self.type = type;
    
    if (type == HHHtmlActionToolPassword) {
        //加载本地Html文件
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"EncryPassword" ofType:@"html"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]];
        [self.webView loadRequest:request];
        
    }
    else if (type == HHHtmlActionToolLiveShare) {
        //加载本地Html文件 带参数拼接
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"PostersToShare" ofType:@"html"];
        NSURL *fileUrl = [NSURL URLWithString:KString(@"?id=%@&contentType=live",self.contentId) relativeToURL:[NSURL fileURLWithPath:filePath]];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
        [self.webView loadRequest:request];
    }
    else {
        //加载本地Html文件 带参数拼接
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"PostersToShare" ofType:@"html"];
        NSURL *fileUrl = [NSURL URLWithString:KString(@"?id=%@",self.contentId) relativeToURL:[NSURL fileURLWithPath:filePath]];
        NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
        [self.webView loadRequest:request];
    }
    
    self.resultBlock = resultBlock;
}


/*登录密码加密*/
- (void)html_loginPassword:(NSString *)password {
    
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"putPsdFromApp('%@')", password] completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"result");
    }];
}

/*修改密码加密*/
- (void)html_encryPassword:(NSString *)password {
    
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"putChangePwdFromApp('%@')", password] completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"result");
    }];
}



/*初始化web*/
- (WKWebView *)webView {
    if (!_webView) {
        if (_webView == nil) {
            WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
            config.preferences = [[WKPreferences alloc] init];
            config.preferences.javaScriptEnabled = YES;
            config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
            config.processPool = [[WKProcessPool alloc] init];
            config.userContentController = [[WKUserContentController alloc] init];
            [config.userContentController addScriptMessageHandler:self name:EncryPassword_Key];
            [config.userContentController addScriptMessageHandler:self name:ShareLongImage_Key];

            _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
            _webView.navigationDelegate = self;
            _webView.UIDelegate = self;
        }
    }
    return _webView;
}


//WKWebView代理方法    @"generate()"()为需要调用的js方法
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
   
    if (self.type == HHHtmlActionToolPassword) {
        
    } else {
        /*绘制长图*/
        [webView evaluateJavaScript:@"putPostersUrl()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            NSLog(@"绘制长图 result %@  %@", result, error);
        }];
    }
}


//JS调用的OC回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:EncryPassword_Key]) {

        NSLog(@"EncryPassword_Key - body为： %@", message.body);
        if (self.resultBlock) {
            self.resultBlock(message.body);
        }
    }
    
    if ([message.name isEqualToString:ShareLongImage_Key]) {
      
        NSLog(@"ShareLongImage_Key - body为： %@", message.body);
        if (self.resultBlock) {
            self.resultBlock(message.body);
        }
    }
    
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"EncryPassword_Key" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
//        [alert addAction:action];
//        [[ControlTools getCurrentVC] presentViewController:alert animated:YES completion:nil];
}


//接收到警告面板
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();//此处的completionHandler()就是调用JS方法时，`evaluateJavaScript`方法中的completionHandler
//    }];
//    [alert addAction:action];
//    [[ControlTools getCurrentVC] presentViewController:alert animated:YES completion:nil];
//}




@end
