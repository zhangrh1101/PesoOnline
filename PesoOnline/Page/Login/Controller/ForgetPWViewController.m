//
//  ForgetPWViewController.m
//  FasterVpn
//
//  Created by Zzzzzzzzz💤 on 2022/5/9.
//

#import "ForgetPWViewController.h"

@interface ForgetPWViewController () <HHFormTextFieldDelegate>

@property (nonatomic, strong) UIImageView                *   logoImg;
@property (nonatomic, strong) HHFormTextField            *   phoneTextField;
@property (nonatomic, strong) HHFormTextField            *   smsTextField;
@property (nonatomic, strong) HHFormTextField            *   passwordTextField;
@property (nonatomic, strong) UIButton                   *   saveButton;
@property (nonatomic, strong) UIButton                   *   codeButton;

@end

//修改密码、 忘记密码
@implementation ForgetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
    [self initUI];
}

#pragma mark - action
/**
 发送验证码
 */
- (void)sendForgetVerificCode:(UIButton *)codeBtn {
    
    if (![HH_Utilities checkTelNumber:self.phoneTextField.hh_text]) {
        [MBProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    [HH_Utilities hh_CountDownTimer:codeBtn CountTime:60];
    
//    [MBProgressHUD showHUD];
    [LoginHandler requestSendVerificationCodePath:KString(@"%@/%@",ForgetVerificCodeUrl, self.phoneTextField.hh_text) params:nil success:^(id responseObject) {
        
//        [MBProgressHUD hideHUD];
//        [MBProgressHUD showMessage:@"短信已发送"];
//        [HH_Utilities hh_CountDownTimer:codeBtn CountTime:60];
        
    } failed:^(id error) {
        [MBProgressHUD hideHUD];
    }];
}

- (void)didClickSaveBtn {
    [self.view endEditing:YES];
    if (![HH_Utilities checkTelNumber:self.phoneTextField.hh_text]) {
        [MBProgressHUD showMessage:@"请输入正确的手机号"];
        return;
    }
    if (self.smsTextField.hh_text.length < 6) {
        [MBProgressHUD showMessage:@"请输入验证码"];
        return;
    }
    if (self.passwordTextField.hh_text.length < 6) {
        [MBProgressHUD showMessage:@"请输入新密码"];
        return;
    }
    
    WeakSelf
    NSDictionary *params = @{
        @"userPhone": self.phoneTextField.hh_text,
        @"password" : self.passwordTextField.hh_text,
        @"smsCode" : self.smsTextField.hh_text,
    };
    [MBProgressHUD showHUD];
    [LoginHandler requestForgetWithPhonePath:ForgetWithPhoneUrl params:params success:^(id responseObject) {
        [MBProgressHUD hideHUD];

        UIViewController *loginVC = weakSelf.navigationController.viewControllers[0];
        if ([loginVC isKindOfClass:[LoginViewController class]]) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        //保存用户Token
//        UserModel *model = [UserModel modelWithDict:responseObject];
//        model.deviceUUID = [UserDefaultsTool objectForKey:KDefaultsPhoneDeviceUUID];
//        [model saveUserModel];
//        [LoginManager onloginSuccess];
        
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
    [self.view addSubview:self.saveButton];
    
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
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(50);
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
        _smsTextField.hh_maxNumChar = 11;
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
            [weakSelf sendForgetVerificCode:rightBtn];
        };
        self.codeButton = _smsTextField.rightBtn;
        [self.codeButton setTitleColor:ThemeColor forState:UIControlStateNormal];
    }
    return _smsTextField;
}

- (HHFormTextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[HHFormTextField alloc] init];
        _passwordTextField.hh_icon = [UIImage imageNamed:@"login_lock"];
        _passwordTextField.hh_textFont = KFONT(13);
        _passwordTextField.hh_textColor = kColorWhite;
        _passwordTextField.hh_placeholder = @"请输入新密码";
        _passwordTextField.hh_placeholderColor = RGBAOF(0xffffff, 0.6);
        _passwordTextField.hh_maxNumChar = 20;
        _passwordTextField.hh_keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.hh_alignment = NSTextAlignmentLeft;
        _passwordTextField.hh_secureTextEntry = YES;
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"完成" forState:UIControlStateNormal];
        [_saveButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_saveButton setTitleColor:RGBAOF(0xffffff, 0.6) forState:UIControlStateHighlighted];
        [_saveButton setBackgroundImage:[UIImage imageNamed:@"btn_bg_purple"] forState:UIControlStateNormal];
        _saveButton.titleLabel.font = KBOLDFONT(20);
        [_saveButton setTarget:self action:@selector(didClickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.layer.cornerRadius = KScale(25);
        _saveButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 7, 0);
    }
    return _saveButton;
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
