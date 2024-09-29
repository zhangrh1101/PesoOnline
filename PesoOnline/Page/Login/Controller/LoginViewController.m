//
//  LoginViewController.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/7.
//

#import "LoginViewController.h"
#import "ForgetPWViewController.h"
#import "RegisterViewController.h"
#import "HHWebViewController.h"
#import "TextFromView.h"

@interface LoginViewController () <HHFormTextFieldDelegate>

@property (nonatomic, strong) UIImageView                *   logoImg;
@property (nonatomic, strong) UIImageView                *   bottomImg;
@property (nonatomic, strong) UILabel                    *   titleLabel;
@property (nonatomic, strong) UILabel                    *   subtitleLabel;

@property (nonatomic, strong) HHFormTextField            *   phoneTextField;
@property (nonatomic, strong) HHFormTextField            *   passwordTextField;
@property (nonatomic, strong) UIButton                   *   loginButton;
@property (nonatomic, strong) UIButton                   *   forgetButton;
@property (nonatomic, strong) UIButton                   *   registerButton;
@property (nonatomic, strong) UIButton                   *   closeButton;
@property (nonatomic, assign) BOOL                           isAgreePolicy;

@end

/*登录页面*/
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setFd_prefersNavigationBarHidden:YES];
    self.barTintState = NavBarTintStatDefault;
    
//    self.view.backgroundColor = HH_HexColorWithAlpha(@"#E7F7FF", 1);
    
    //设置图片背景
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    self.view.layer.contents = (id) backgroundImage.CGImage;
    
    [self initUI];
}

#pragma mark - action
/**
 关闭
 */
- (void)didCloseClick {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 忘记密码
 */
- (void)didForgetClick {
    
    ForgetPWViewController *forgetVC = [[ForgetPWViewController alloc] init];
    forgetVC.navTitle = @"忘记密码";
    [self.navigationController pushViewController:forgetVC animated:YES];
}

/**
 注册账号
 */
- (void)didRegisterClick {
    
    RegisterViewController *rigisterVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:rigisterVC animated:YES];
}

/**
 查看协议
 */
- (void)didAgreementClick:(UIButton *)sender {
    
    UIButton *button = sender;
    HHLog(@" %ld", button.tag);
    
    NSString *htmlTitle = @"";
    NSString *htmlUrl = @"";
    switch (button.tag) {
        case 0:
            htmlTitle = @"用户协议";
            htmlUrl = USER_AGREEMENT_URL;
            break;
        case 1:
            htmlTitle = @"隐私政策";
            htmlUrl = USER_PRIVACY_URL;
            break;
        default:
            break;
    }
    HHWebViewController *webVC = [[HHWebViewController alloc] init];
    webVC.htmlTitle = htmlTitle;
    webVC.htmlUrl = htmlUrl;
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - network
/**
 登录事件
 */
- (void)didLoginClick {
    
    HHLog(@"didLoginClick");
    
//    [self showRootViewController];
    
    //    if (!self.isAgreePolicy) {
    //        [MBProgressHUD showMessage:@"请先阅读并勾选《用户协议》《隐私政策》"];
    //        return;
    //    }
    if ([HH_Utilities isBlankString:self.phoneTextField.hh_text]) {
        [MBProgressHUD showMessage:@"请输入账号"];
        return;
    }
    if ([HH_Utilities isBlankString:self.passwordTextField.hh_text]) {
        [MBProgressHUD showMessage:@"请输入密码"];
        return;
    }
    
    //存储登录账号密码
    [UserDefaultsTool setObject:self.phoneTextField.hh_text forKey:KDefaultsUserAccount];
    [UserDefaultsTool setObject:self.passwordTextField.hh_text forKey:KDefaultsUserPassword];
    

    
//    WeakSelf
//    NSDictionary *params = @{
//        @"userPhone": self.phoneTextField.hh_text,
//        @"password" : self.passwordTextField.hh_text,
//        @"grantType" : @"password",
//    };
//    [MBProgressHUD showHUD];
//    [LoginHandler requestLoginWithPhonePath:LoginWithPhoneUrl params:params success:^(id responseObject) {
//        [MBProgressHUD hideHUD];
//        //保存用户Token
//        UserModel *model = [UserModel modelWithDict:responseObject];
//        model.deviceUUID = [UserDefaultsTool objectForKey:KDefaultsPhoneDeviceUUID];
//        [model saveUserModel];
//
//        //记录登录手机号码
//        [UserDefaultsTool setObject:self.phoneTextField.hh_text forKey:KDefaultsUserCellPhone];
//
//        [weakSelf dismissViewControllerAnimated:YES completion:nil];
//        [LoginManager onloginSuccess];
//
//    } failed:^(id error) {
//        [MBProgressHUD hideHUD];
//    }];
}

#pragma mark - UI

- (void)initUI {
    
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.bottomImg];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.subtitleLabel];
    
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.closeButton];
    
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavBarHeight+20);
        make.centerX.equalTo(self.view);
    }];
    
    [self.bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.width.equalTo(self.view.mas_width);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImg.mas_bottom).offset(40);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(30);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(30);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(KScale(50));
    }];

    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(10);
        make.left.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];

    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(10);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(40);
    }];

    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KStatusBarHeight);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    //协议
//    [self setUserAgreementView];
    
    WeakSelf
    self.passwordTextField.hh_rightBtnClick = ^(UIButton * _Nonnull rightBtn, NSString * _Nonnull text) {
        weakSelf.passwordTextField.hh_secureTextEntry = !rightBtn.isSelected;
    };
    
    self.closeButton.hidden = YES;
    self.phoneTextField.hh_text = [UserDefaultsTool objectForKey:KDefaultsUserAccount];;
    self.passwordTextField.hh_text = [UserDefaultsTool objectForKey:KDefaultsUserPassword];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //添加阴影
    [self.loginButton addShadowColor:HH_HexColor(@"#007AFF") shadowOpacity:0.8 shadowOffset:CGSizeMake(0, 3) shadowRadius:5];
}


#pragma mark - setter & getter

- (UIImageView *)logoImg {
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"login_emblem"];
    }
    return _logoImg;
}

- (UIImageView *)bottomImg {
    if (!_bottomImg) {
        _bottomImg = [[UIImageView alloc] init];
        _bottomImg.image = [UIImage imageNamed:@"login_bottom_img"];
    }
    return _bottomImg;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KBOLDFONT(24);
        _titleLabel.textColor = MainTextColor;
        _titleLabel.text = @"欢迎登录";
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = KBOLDFONT(18);
        _subtitleLabel.textColor = MainTextColor;
        _subtitleLabel.text = @"黄冈市“智慧人大”信息化平台";
    }
    return _subtitleLabel;
}

- (HHFormTextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[HHFormTextField alloc] init];
        _phoneTextField.hh_textFont = KFONT(16);
        _phoneTextField.hh_textColor = MainTextColor;
        _phoneTextField.hh_placeholder = @"请输入账号";
        _phoneTextField.hh_placeholderColor = HH_HexColor(@"#B5B5B5");
        _phoneTextField.hh_maxNumChar = 20;
        _phoneTextField.hh_keyboardType = UIKeyboardTypeDefault;
        _phoneTextField.hh_alignment = NSTextAlignmentLeft;
        _phoneTextField.delegate = self;
        _phoneTextField.hh_text = [UserDefaultsTool objectForKey:KDefaultsUserCellPhone];
    }
    return _phoneTextField;
}

- (HHFormTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[HHFormTextField alloc] init];
        _passwordTextField.hh_textFont = KFONT(16);
        _passwordTextField.hh_textColor = MainTextColor;
        _passwordTextField.hh_placeholder = @"请输入6-20位密码";
        _passwordTextField.hh_placeholderColor = HH_HexColor(@"#B5B5B5");
        _passwordTextField.hh_maxNumChar = 20;
        _passwordTextField.hh_keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.hh_alignment = NSTextAlignmentLeft;
        _passwordTextField.delegate = self;
        _passwordTextField.hh_normalImage = @"eye_close";
        _passwordTextField.hh_selectImage = @"eye_open";
        _passwordTextField.hh_secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_loginButton setTitleColor:RGBAOF(0xffffff, 0.6) forState:UIControlStateHighlighted];
        _loginButton.titleLabel.font = KBOLDFONT(20);
        [_loginButton setTarget:self action:@selector(didLoginClick) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.cornerRadius = KScale(25);
        _loginButton.backgroundColor = HH_HexColor(@"#007AFF");
    }
    return _loginButton;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [[UIButton alloc] init];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        _registerButton.titleLabel.font = KFONT(14);
        [_registerButton setTarget:self action:@selector(didRegisterClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UIButton *)forgetButton {
    if (!_forgetButton) {
        _forgetButton = [[UIButton alloc] init];
        [_forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = KFONT(14);
        [_forgetButton setTarget:self action:@selector(didForgetClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetButton;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setImage:[UIImage imageNamed:@"close_white"] forState:UIControlStateNormal];
        _closeButton.imageView.contentMode = UIViewContentModeCenter;
        [_closeButton setTarget:self action:@selector(didCloseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}


/** 登录即同意、用户协议 */
- (void)setUserAgreementView {
    
    UIView *agreementView = [[UIView alloc] init];
    [self.view addSubview:agreementView];
    [agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-50);
        make.left.right.mas_equalTo(0);
    }];

    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [agreeBtn setImage:[UIImage imageNamed:@"login_cycle_unsel"] forState:UIControlStateNormal];
//    [agreeBtn setImage:[UIImage imageNamed:@"login_cycle_sel"] forState:UIControlStateSelected];
    [agreeBtn setTitle:@"登录即同意" forState:UIControlStateNormal];
    [agreeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [agreeBtn setImagePosition:ImagePositionLeft spacing:5];
    agreeBtn.selected = YES;
//    [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [agreementView addSubview:agreeBtn];
    
    UIButton *userAgreement = [UIButton buttonWithType:UIButtonTypeCustom];
    userAgreement.tag = 0;
    [userAgreement setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [userAgreement setTitleColor:MainTextColor forState:UIControlStateNormal];
    userAgreement.titleLabel.font = [UIFont systemFontOfSize:13];
    [userAgreement setTarget:self action:@selector(didAgreementClick:) forControlEvents:UIControlEventTouchUpInside];
    [agreementView addSubview:userAgreement];

    UIButton *privacyPolicy = [UIButton buttonWithType:UIButtonTypeCustom];
    privacyPolicy.tag = 1;
    [privacyPolicy setTitle:@"《隐私政策》" forState:UIControlStateNormal];
    [privacyPolicy setTitleColor:MainTextColor forState:UIControlStateNormal];
    privacyPolicy.titleLabel.font = [UIFont systemFontOfSize:13];
    [privacyPolicy setTarget:self action:@selector(didAgreementClick:) forControlEvents:UIControlEventTouchUpInside];
    [agreementView addSubview:privacyPolicy];
    
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.view).offset(KScale(70));
        make.height.mas_equalTo(30);
    }];
    
    [userAgreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(agreeBtn.mas_right);
        make.centerY.mas_equalTo(agreeBtn);
        make.height.mas_equalTo(30);
    }];
    
    [privacyPolicy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userAgreement.mas_right);
        make.centerY.mas_equalTo(agreeBtn);
        make.height.mas_equalTo(30);
    }];
}



@end
