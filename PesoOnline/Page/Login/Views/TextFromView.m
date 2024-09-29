//
//  TextFromView.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/9.
//

#import "TextFromView.h"

@interface TextFromView () <HHFormTextFieldDelegate>

@property (nonatomic, strong) UILabel                   *   label;
@property (nonatomic, strong) HHFormTextField           *   fromTextField;

@end

@implementation TextFromView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.opaque = YES;

    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = KBOLDFONT(20);
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    self.label = label;
    
    WeakSelf
    HHFormTextField *fromTextField = [[HHFormTextField alloc] init];
    fromTextField.hh_textFont = KFONT(15);
    fromTextField.hh_textColor = MainTextColor;
    fromTextField.hh_keyboardType = UIKeyboardTypeNumberPad;
    fromTextField.hh_alignment = NSTextAlignmentLeft;
    fromTextField.isLine = YES;
    fromTextField.hh_lineColor = RGBAOF(0xffffff, 0.6);
    fromTextField.delegate = self;
    fromTextField.hh_textChangedBlock = ^(NSString * _Nonnull text) {
        weakSelf.fromTextField.hh_text = text;
    };
    fromTextField.hh_rightBtnClick = ^(UIButton * _Nonnull rightBtn, NSString * _Nonnull text) {
//        [weakSelf sendVerificationCode:rightBtn];
    };
    [self addSubview:fromTextField];
    [fromTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(5);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    self.fromTextField =fromTextField;
}

- (NSString *)text {
    return self.fromTextField.hh_text;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.fromTextField.hh_placeholder = placeholder;
    self.fromTextField.hh_placeholderColor = HH_HexColor(@"#B5B5B5");
}

- (void)setMaxChar:(NSInteger)maxChar {
    _maxChar = maxChar;
    self.fromTextField.hh_maxNumChar = maxChar;
}

#pragma HHFormTextFieldDelegate
- (BOOL)hh_textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string fieldResult:(NSString *)result {
        

    return NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
