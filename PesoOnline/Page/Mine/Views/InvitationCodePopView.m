//
//  InvitationCodePopView.m
//  FasterVpn
//
//  Created by mac mini on 2022/6/9.
//

#import "InvitationCodePopView.h"

#define ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height

@interface InvitationCodePopView ()

@property (nonatomic, strong) UIView                * whiteBack;
@property (nonatomic, strong) UILabel               * titleLabel;
@property (nonatomic, strong) UITextField           * passwordTF;
@property (nonatomic, strong) UIButton              * sureBtn;
@property (nonatomic, strong) UIButton              * cancelBtn;
@property (nonatomic, strong) UIView                * horizonalLine;
@property (nonatomic, strong) UIView                * separateLine;

@property (nonatomic, strong) UIButton              * forgetPasswordBtn;
@property (nonatomic, strong) UILabel               * promptLabel;

@property (nonatomic, copy) NSArray<UIView *>       * grayBackArr;
@property (nonatomic, copy) NSArray<UIView *>       * pointArr;

@property (nonatomic, copy) void (^btnBlock)(NSString *code);

@end

/* 邀请码弹窗 */
@implementation InvitationCodePopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

+ (void)showWithblock:(void(^)(NSString *))block {
    
    InvitationCodePopView *alertView = [InvitationCodePopView new];
    alertView.btnBlock = block;
    [alertView show];
}

- (void)setupUI {
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    [self addSubview:self.whiteBack];
    [self.whiteBack addSubview:self.passwordTF];
    [self.whiteBack addSubview:self.sureBtn];
    [self.whiteBack addSubview:self.cancelBtn];
    [self.whiteBack addSubview:self.horizonalLine];
    [self.whiteBack addSubview:self.separateLine];
    [self.whiteBack addSubview:self.titleLabel];
    [self.whiteBack addSubview:self.promptLabel];
//    [self.whiteBack addSubview:self.forgetPasswordBtn];
    
    CGFloat width = KScale(220/5);
    CGFloat diameter = KScale(12);
    NSMutableArray *backArr = [NSMutableArray new];
    NSMutableArray *pointArr = [NSMutableArray new];
    for (int i = 0; i < 5; i++) {
        UIView *grayBack = [UIView new];
        grayBack.frame = CGRectMake(KScale(20)+(width+5)*i, KScale(60), width, KScale(53));
        grayBack.backgroundColor = [UIColor colorWithHexString:@"#E8FAFF"];
        [self.whiteBack addSubview:grayBack];
        [backArr addObject:grayBack];
        
        UILabel *point = [UILabel new];
//        point.frame = CGRectMake((width-diameter)/2, (width-diameter)/2, diameter, diameter);
        point.frame = CGRectMake(0, 0, grayBack.width, grayBack.height);
        point.font = [UIFont boldSystemFontOfSize:KScale(25)];
        point.textColor = BlueSystemTextColor;
        point.textAlignment = NSTextAlignmentCenter;
//        point.layer.cornerRadius = KScale(6);
        [pointArr addObject:point];
        
        [grayBack addTapGestureWithTarget:self action:@selector(becomeKeyBorad)];
    }
    self.grayBackArr = backArr.copy;
    self.pointArr = pointArr.copy;
}


//弹出键盘
- (void) becomeKeyBorad{
    [self.passwordTF becomeFirstResponder];
}


- (void)refreshUI {
    
    
}

#pragma mark - Animation

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    [self shakeToShow:self.whiteBack];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    } completion:^(BOOL finished) {
        [self.passwordTF becomeFirstResponder];
    }];
}

- (void)hidden {
    [self.passwordTF resignFirstResponder];
    [self shakeToHide:self.whiteBack];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)shakeToShow:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.25;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4,   0.4,    0.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1,   1.1,    0.25)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95,  0.95,   0.5)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,   1.0,    1.0)]];
    
    animation.values = values;
    
    [aView.layer addAnimation:animation forKey:@"ShakeToShow"];
}

- (void)shakeToHide:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.25;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,   1.0,    1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95,  0.95,   0.8)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1,   1.1,    0.6)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3,   0.3,    0.4)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01,  0.01f,  0.2)]];
    
    animation.values = values;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [aView.layer addAnimation:animation forKey:@"ShakeToHide"];
}

#pragma mark - Action

- (void)sureBtnClick {
    NSString *password = self.passwordTF.text;
    
    // 超出5位数截断
    if (password.length >= 5) {
        password = [password substringToIndex:5];
        self.passwordTF.text = password;
        if (self.btnBlock) {
            self.btnBlock(password);
            [self hidden];
        }
    } else {
        self.promptLabel.hidden = NO;
    }
}

- (void)cancleBtnClick {
    [self hidden];
}

- (void)passwordTFDidChanged {
    
    NSString *password = self.passwordTF.text.uppercaseString;
    self.promptLabel.hidden = YES;
    
    // 超出5位数截断
    if (password.length > 5) {
        password = [password substringToIndex:5];
        self.passwordTF.text = password;
    }
    
    for (int i = 0; i < 5; i ++) {
        if (password.length > i) {
            
            UILabel *label = (UILabel *)self.pointArr[i];
            label.text = [password substringWithRange:NSMakeRange(i, 1)];
            
            [self.grayBackArr[i] addSubview:self.pointArr[i]];
        } else {
            [self.pointArr[i] removeFromSuperview];
        }
    }
}



/**
 忘记密码
 */
- (void)forgetPasswordBtnClick {
    
    [self hidden];
    
//    ForgetLoginPWOneController *forgetOneVC = [[ForgetLoginPWOneController alloc] init];
//    forgetOneVC.isForgetTradePw = YES;
//    [[ControlTools navigationViewController] pushViewController:forgetOneVC animated:YES];
}



#pragma mark - Setter and getter

- (UIView *)whiteBack {
    if (!_whiteBack) {
        _whiteBack = [UIView new];
        _whiteBack.backgroundColor = UIColor.whiteColor;
        _whiteBack.layer.cornerRadius = KScale(10);
        _whiteBack.layer.masksToBounds = YES;
        _whiteBack.frame = CGRectMake(0, 0, KScale(280), KScale(200));
        _whiteBack.centerX = self.centerX;
        _whiteBack.y = KScale(220);
    }
    return _whiteBack;
}

- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [UITextField new];
        _passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
        [_passwordTF addTarget:self action:@selector(passwordTFDidChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTF;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(0, 5, KScale(280), KScale(50));
        _titleLabel.font = [UIFont boldSystemFontOfSize:KScale(15)];
        _titleLabel.textColor = MainTextColor;
        _titleLabel.text = @"请输入你的邀请码";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

//提示文字
- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [UILabel new];
        _promptLabel.frame = CGRectMake(0, KScale(100), KScale(280), KScale(46));
        _promptLabel.font = [UIFont systemFontOfSize:KScale(13)];
        _promptLabel.textColor = ThemeColor;
//        _promptLabel.text = @"验证码至少为5位";
        _promptLabel.textAlignment = NSTextAlignmentCenter;
        _promptLabel.hidden = YES;
    }
    return _promptLabel;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setBackgroundImage:[UIImage imageNamed:@"btn_blue"] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KScale(16)];
        _sureBtn.frame = CGRectMake(KScale(280/2)-50, KScale(140), 100, 40);
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:[UIImage imageNamed:@"close_black_s"] forState:UIControlStateNormal];
        _cancelBtn.imageView.contentMode = UIViewContentModeCenter;
        [_cancelBtn setTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.frame = CGRectMake(KScale(280)-50, 5, 50, 50);
    }
    return _cancelBtn;
}


@end
