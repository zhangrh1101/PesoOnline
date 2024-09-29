//
//  HHFormTextField.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/3/1.
//

#import "HHFormTextField.h"

@interface HHFormTextField () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *  iconImageView;

@property (nonatomic, strong) UILabel     *  requestLB;
@property (nonatomic, strong) UILabel     *  titleLB;
@property (nonatomic, strong) UIView      *  separeLine;
@property (nonatomic, strong) UIView      *  line;

@end

@implementation HHFormTextField

- (instancetype)init{
    
    if (self = [super init]) {
        
        _isEdit = YES;
        _isSepare = YES;
        _hh_maxNumChar = 30;
        _textMarinLeft = 0;
        [self setup];
    }
    return self;
}

- (void)setup {

    WeakSelf
    self.requestLB = [ControlTools labelWithText:@"" textColor:[UIColor redColor] font:KFONT(16)];
    [self addSubview:self.requestLB];
    
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.hidden = YES;
    [self addSubview:self.iconImageView];
    
    self.titleLB = [ControlTools labelWithText:@"" textColor:MainUnTextColor font:KFONT(14)];
    [self addSubview:self.titleLB];
    
    self.textField = [[UITextField alloc] init];
    self.textField.textColor = MainTextColor;
    self.textField.font = KFONT(14);
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.delegate = self;
    [self addSubview:self.textField];
    
    self.rightBtn = [ControlTools buttonWithImage:@"" title:@"" titleColor:ThemeColor font:KFONT(14) upInsideAction:^(id  _Nonnull sender) {
     
        weakSelf.rightBtn.selected = !weakSelf.rightBtn.selected;
        if (weakSelf.hh_rightBtnClick) {
            weakSelf.hh_rightBtnClick(weakSelf.rightBtn, weakSelf.hh_text);
        }
    }];
    [self addSubview:self.rightBtn];
    
    // | 分隔符
    self.separeLine = [[UIView alloc] init];
    self.separeLine.backgroundColor = SeparationlineColor;
    [self.rightBtn addSubview:self.separeLine];
    
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = SeparationlineColor;
    [self addSubview:self.line];
    
    [self.titleLB setContentCompressionResistancePriority:750 forAxis:UILayoutConstraintAxisHorizontal];
    [self.textField setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];

    [self.requestLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(0);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.requestLB.mas_right).offset(0);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.equalTo(self.requestLB.mas_right).offset(0);
        make.width.mas_greaterThanOrEqualTo(0);
        make.height.mas_lessThanOrEqualTo(60);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.textMarinLeft);
        make.right.equalTo(self.rightBtn.mas_left);
        make.height.mas_equalTo(36);
    }];

    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(0);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.titleLB.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isRequest) {
        [self.requestLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(10);
        }];
    }
    
    if (self.hh_title.length > 0) {
        [self.titleLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.requestLB.mas_right).offset(0);
            make.width.mas_greaterThanOrEqualTo(60);
        }];
    }
    
    CGFloat textMarinLeft = self.textMarinLeft;
    if (self.isRequest) {
        textMarinLeft = textMarinLeft + 10;
    }
    if (self.hh_icon) {
        textMarinLeft = textMarinLeft + 50;
    }
    if (self.hh_title.length > 0) {
        textMarinLeft = textMarinLeft + 60;
    }
    [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(textMarinLeft);
    }];
    
//    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        if (self.hh_rigthText.length > 0) {
//            make.width.mas_equalTo(KScale(90));
//        }else if (self.hh_normalImage.length > 0 || self.hh_selectImage.length > 0) {
//            make.width.mas_equalTo(KScale(60));
//        }
//    }];
    
    [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        if (self.hh_rigthText.length > 0) {
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(KScale(80));
        }else if (self.hh_normalImage.length > 0 || self.hh_selectImage.length > 0) {
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(KScale(40));
        }else{
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(0);
        }
    }];
    
    
    if (self.hh_rigthText.length > 0) {
        [self.separeLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(-10);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(0.5);
        }];
    }
}


- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
//    self.textField.enabled = isEdit;
}

- (void)setIsRequest:(BOOL)isRequest {
    _isRequest = isRequest;
    self.requestLB.text = isRequest ? @"*" : @"";
}

- (void)setHh_icon:(UIImage *)hh_icon {
    _hh_icon = hh_icon;
    self.iconImageView.image = hh_icon;
    self.iconImageView.contentMode = UIViewContentModeCenter;
    self.iconImageView.hidden = NO;
}

- (void)setHh_title:(NSString *)hh_title {
    
    _hh_title = hh_title;
    self.titleLB.text = hh_title;
    self.iconImageView.hidden = YES;
}

- (void)setHh_titleColor:(UIColor *)hh_titleColor {
    _hh_titleColor = hh_titleColor;
    self.titleLB.textColor = hh_titleColor;
}

- (void)setHh_titleFont:(UIFont *)hh_titleFont {
    _hh_titleFont = hh_titleFont;
    self.titleLB.font = hh_titleFont;
}

- (void)setTextMarinLeft:(float)textMarinLeft {
    _textMarinLeft = textMarinLeft;
}

- (void)setHh_text:(NSString *)hh_text {
    self.textField.text = hh_text;
}

- (NSString *)hh_text {
    return self.textField.text;
}

- (void)setHh_textFont:(UIFont *)hh_textFont {
    _hh_textFont = hh_textFont;
    self.textField.font = hh_textFont;
}

- (void)setHh_textColor:(UIColor *)hh_textColor {
    _hh_textColor = hh_textColor;
    self.textField.textColor = hh_textColor;
}

- (void)setHh_placeholder:(NSString *)hh_placeholder {
    _hh_placeholder = hh_placeholder;
    self.textField.placeholder = hh_placeholder;
}

- (void)setHh_placeholderColor:(UIColor *)hh_placeholderColor {
    _hh_placeholderColor = hh_placeholderColor;
    
    if (self.hh_placeholder.length > 0) {
        NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:self.hh_placeholder
                                                                                              attributes:@{NSForegroundColorAttributeName:hh_placeholderColor}];
        self.textField.attributedPlaceholder = placeholderString;
    }
}

- (void)setHh_keyboardType:(UIKeyboardType)hh_keyboardType {
 
    _hh_keyboardType = hh_keyboardType;
    self.textField.keyboardType = hh_keyboardType;
}


- (void)setHh_normalImage:(NSString *)hh_normalImage {
    _hh_normalImage = hh_normalImage;
    [self.rightBtn setImage:[UIImage imageNamed:hh_normalImage] forState:UIControlStateNormal];
//    [self layoutIfNeeded];
}

- (void)setHh_selectImage:(NSString *)hh_selectImage {
    _hh_selectImage = hh_selectImage;
    [self.rightBtn setImage:[UIImage imageNamed:hh_selectImage] forState:UIControlStateSelected];
//    [self layoutIfNeeded];
}

- (void)setHh_rigthText:(NSString *)hh_rigthText {
    _hh_rigthText = hh_rigthText;
    [self.rightBtn setTitle:hh_rigthText forState:UIControlStateNormal];
//    [self layoutIfNeeded];
}


- (void)setHh_tag:(NSInteger)hh_tag {
    _hh_tag = hh_tag;
    self.textField.tag = hh_tag;
}

- (void)setHh_maxNumChar:(NSInteger)hh_maxNumChar {
    _hh_maxNumChar = hh_maxNumChar;
}

- (void)setHh_alignment:(NSTextAlignment)hh_alignment {
    _hh_alignment = hh_alignment;
    self.textField.textAlignment = _hh_alignment;
}

- (void)setHh_clearButtonMode:(UITextFieldViewMode)hh_clearButtonMode {
    _hh_clearButtonMode = hh_clearButtonMode;
    self.textField.clearButtonMode = _hh_clearButtonMode;
}

- (void)setHh_secureTextEntry:(BOOL)hh_secureTextEntry {
    
    _hh_secureTextEntry = hh_secureTextEntry;
    self.textField.secureTextEntry = hh_secureTextEntry;
}


- (void)setHh_lineColor:(UIColor *)hh_lineColor {
    _hh_lineColor = hh_lineColor;
    self.line.backgroundColor = hh_lineColor;
}

- (void)setIsLine:(BOOL)isLine {
    _isLine = isLine;
    self.line.hidden = !isLine;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
   
    if (!self.isEdit) {
        if (self.hh_rightBtnClick) {
            self.hh_rightBtnClick(self.rightBtn ,self.hh_text);
        }
        return NO;
    }
    if ([self.delegate respondsToSelector:@selector(hh_textFieldShouldBeginEditing:)]) {
       return [self.delegate hh_textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(hh_textFieldDidBeginEditing:)]) {
        
        [self.delegate hh_textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
 
    if ([self.delegate respondsToSelector:@selector(hh_textFieldShouldEndEditing:)]) {
        
        return [self.delegate hh_textFieldShouldEndEditing:textField];
    }
    return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if ([self.delegate respondsToSelector:@selector(hh_textFieldShouldClear:)]) {
        
        return [self.delegate hh_textFieldShouldClear:textField];
    }
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
    }
    
    //禁止输入标签
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;
    }

    //判断键盘是不是九宫格键盘 字母、数字、中文
//    if ([HH_Utilities isNineKeyBoard:string]){
//        return YES;
//    }

    if (textField.text.length - range.length + string.length > self.hh_maxNumChar && self.hh_maxNumChar > 0) {
        return NO;
    }

    if (self.hh_textChangedBlock) {
        self.hh_textChangedBlock(text);
    }
    
    if ([self.delegate respondsToSelector:@selector(hh_textField:shouldChangeCharactersInRange:replacementString:fieldResult:)]) {
        [self.delegate hh_textField:textField shouldChangeCharactersInRange:range replacementString:string fieldResult:text];
    }
    
    if (self.hh_textChangedBlock) {
        return NO;
    }
    
    NSCharacterSet *charSet = [[NSCharacterSet characterSetWithCharactersInString:@"_/:&@.?!-|~#%^*()"] invertedSet];
    NSString *filteredStr = [[string componentsSeparatedByCharactersInSet:charSet] componentsJoinedByString:@""];
    if ([string isEqualToString:filteredStr]) {
        return YES;
    }
    
    //判断键盘是不是九宫格键盘 字母、数字、中文
    return [HH_Utilities isNineKeyBoard:string];
}

@end
