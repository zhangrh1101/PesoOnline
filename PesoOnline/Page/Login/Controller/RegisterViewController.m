//
//  RegisterViewController.m
//  FasterVpn
//
//  Created by Zzzzzzzzz💤 on 2022/5/9.
//

#import "RegisterViewController.h"

@interface RegisterViewController () <HHFormTextFieldDelegate>

@property (nonatomic, strong) UIImageView                *   logoImg;
@property (nonatomic, strong) HHFormTextField            *   phoneTextField;
@property (nonatomic, strong) HHFormTextField            *   smsTextField;
@property (nonatomic, strong) HHFormTextField            *   passwordTextField;
@property (nonatomic, strong) HHFormTextField            *   password2TextField;
@property (nonatomic, strong) UIButton                   *   registerButton;
@property (nonatomic, strong) UIButton                   *   codeButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    [self initUI];
}

#pragma mark - action
/**
 发送验证码
 */
- (void)sendRegistVerificCode:(UIButton *)codeBtn {
    
    if (![HH_Utilities checkTelNumber:self.phoneTextField.hh_text]) {
        [MBProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    
    [MBProgressHUD showHUD];
    [LoginHandler requestSendVerificationCodePath:KString(@"%@/%@",RegistVerificCodeUrl, self.phoneTextField.hh_text) params:nil success:^(id responseObject) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"短信已发送"];
        [HH_Utilities hh_CountDownTimer:codeBtn CountTime:60];
        
    } failed:^(id error) {
        [MBProgressHUD hideHUD];
    }];
}

/**
 注册
 */
- (void)didClickRegisterBtn {
    
    [self.view endEditing:YES];
    if (![HH_Utilities checkTelNumber:self.phoneTextField.hh_text]) {
        [MBProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    if (self.smsTextField.hh_text.length < 6) {
        [MBProgressHUD showMessage:@"请输入验证码"];
        return;
    }
    if (self.passwordTextField.hh_text.length < 6 || self.password2TextField.hh_text.length < 6) {
        [MBProgressHUD showMessage:@"请输入新密码"];
        return;
    }
    if (![self.passwordTextField.hh_text isEqualToString:self.password2TextField.hh_text]) {
        [MBProgressHUD showMessage:@"两次密码不一致"];
        return;
    }
    
    WeakSelf
    NSDictionary *params = @{
        @"userPhone": self.phoneTextField.hh_text,
        @"password" : self.passwordTextField.hh_text,
        @"smsCode" : self.smsTextField.hh_text,
        @"terminalType" : @"3",
        //        @"channelCode" : @"3",
    };
    [MBProgressHUD showHUD];
    [LoginHandler requestRegistWithPhonePath:RegistWithPhoneUrl params:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        //保存用户Token
        UserModel *model = [UserModel modelWithDict:responseObject];
        model.deviceUUID = [UserDefaultsTool objectForKey:KDefaultsPhoneDeviceUUID];
        [model saveUserModel];
        
        //记录登录手机号码
        [UserDefaultsTool setObject:self.phoneTextField.hh_text forKey:KDefaultsUserCellPhone];

        UIViewController *loginVC = weakSelf.navigationController.viewControllers[0];
        if ([loginVC isKindOfClass:[LoginViewController class]]) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        [LoginManager onloginSuccess];
        
    } failed:^(id error) {
        [MBProgressHUD hideHUD];
    }];
}

#pragma mark - UI

- (void)initUI {
    
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.smsTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.password2TextField];
    [self.view addSubview:self.registerButton];
    
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavBarHeight);
        make.centerX.equalTo(self.view);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImg.mas_bottom).offset(50);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    
    [self.smsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.smsTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    
    [self.password2TextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(60);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.password2TextField.mas_bottom).offset(50);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(KScale(70));
    }];
}

#pragma mark - setter & getter

- (UIImageView *)logoImg {
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"public_login"];
    }
    return _logoImg;
}

- (HHFormTextField *)phoneTextField {
    WeakSelf
    if (!_phoneTextField) {
        _phoneTextField = [[HHFormTextField alloc] init];
        _phoneTextField.hh_icon = [UIImage imageNamed:@"login_phone"];
        _phoneTextField.hh_textFont = KFONT(13);
        _phoneTextField.hh_textColor = kColorWhite;
        _phoneTextField.hh_placeholder = @"请输入手机号";
        _phoneTextField.hh_placeholderColor = RGBAOF(0xffffff, 0.6);
        _phoneTextField.hh_maxNumChar = 11;
        _phoneTextField.hh_keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.hh_alignment = NSTextAlignmentLeft;
        _phoneTextField.delegate = self;
        _phoneTextField.hh_textChangedBlock = ^(NSString * _Nonnull text) {
            weakSelf.phoneTextField.hh_text = text;
        };
    }
    return _phoneTextField;
}

- (HHFormTextField *)smsTextField {
    WeakSelf
    if (!_smsTextField) {
        _smsTextField = [[HHFormTextField alloc] init];
        _smsTextField.hh_icon = [UIImage imageNamed:@"login_shield"];
        _smsTextField.hh_textFont = KFONT(13);
        _smsTextField.hh_textColor = kColorWhite;
        _smsTextField.hh_placeholder = @"请输入验证码";
        _smsTextField.hh_placeholderColor = RGBAOF(0xffffff, 0.6);
        _smsTextField.hh_maxNumChar = 6;
        _smsTextField.hh_keyboardType = UIKeyboardTypePhonePad;
        _smsTextField.hh_alignment = NSTextAlignmentLeft;
        _smsTextField.delegate = self;
        _smsTextField.hh_rigthText = @"获取验证码";
        _smsTextField.hh_rightBtnClick = ^(UIButton * _Nonnull rightBtn, NSString * _Nonnull text) {
            if (![HH_Utilities checkTelNumber:weakSelf.phoneTextField.hh_text]) {
                [MBProgressHUD showMessage:@"请输入正确的手机号"];
                [weakSelf.view endEditing:YES];
                return;
            }
            [weakSelf sendRegistVerificCode:rightBtn];
        };
        self.codeButton = _smsTextField.rightBtn;
        [self.codeButton setTitleColor:ThemeColor forState:UIControlStateNormal];
//        self.codeButton.enabled = NO;
    }
    return _smsTextField;
}

- (HHFormTextField *)passwordTextField {
    WeakSelf
    if (!_passwordTextField) {
        _passwordTextField = [[HHFormTextField alloc] init];
        _passwordTextField.hh_icon = [UIImage imageNamed:@"login_lock"];
        _passwordTextField.hh_textFont = KFONT(13);
        _passwordTextField.hh_textColor = kColorWhite;
        _passwordTextField.hh_placeholder = @"请输入密码";
        _passwordTextField.hh_placeholderColor = RGBAOF(0xffffff, 0.6);
        _passwordTextField.hh_maxNumChar = 20;
        _passwordTextField.hh_keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.hh_alignment = NSTextAlignmentLeft;
        _passwordTextField.hh_secureTextEntry = YES;
        _passwordTextField.delegate = self;
        _passwordTextField.hh_textChangedBlock = ^(NSString * _Nonnull text) {
            weakSelf.passwordTextField.hh_text = text;
        };
    }
    return _passwordTextField;
}

- (HHFormTextField *)password2TextField {
    WeakSelf
    if (!_password2TextField) {
        _password2TextField = [[HHFormTextField alloc] init];
        _password2TextField.hh_icon = [UIImage imageNamed:@"login_lock"];
        _password2TextField.hh_textFont = KFONT(13);
        _password2TextField.hh_textColor = kColorWhite;
        _password2TextField.hh_placeholder = @"请再次输入密码";
        _password2TextField.hh_placeholderColor = RGBAOF(0xffffff, 0.6);
        _password2TextField.hh_maxNumChar = 20;
        _password2TextField.hh_keyboardType = UIKeyboardTypeDefault;
        _password2TextField.hh_alignment = NSTextAlignmentLeft;
        _password2TextField.hh_secureTextEntry = YES;
        _password2TextField.delegate = self;
        _password2TextField.hh_textChangedBlock = ^(NSString * _Nonnull text) {
            weakSelf.password2TextField.hh_text = text;
        };
    }
    return _password2TextField;
}

- (UIButton *)registerButton {
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_registerButton setTitleColor:RGBAOF(0xffffff, 0.6) forState:UIControlStateHighlighted];
        [_registerButton setBackgroundImage:[UIImage imageNamed:@"btn_bg_purple"] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = KBOLDFONT(20);
        [_registerButton setTarget:self action:@selector(didClickRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.layer.cornerRadius = KScale(25);
        _registerButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 7, 0);
    }
    return _registerButton;
}

#pragma HHFormTextFieldDelegate
- (BOOL)hh_textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string fieldResult:(NSString *)result {
    
//    if ([HH_Utilities checkTelNumber:self.phoneTextField.hh_text]) {
//        [self.codeButton setTitleColor:ThemeColor forState:UIControlStateNormal];
//        self.codeButton.enabled = YES;
//    }else{
//        [self.codeButton setTitleColor:DisableBackColor forState:UIControlStateNormal];
//        self.codeButton.enabled = NO;
//    }
    return NO;
}


@end
