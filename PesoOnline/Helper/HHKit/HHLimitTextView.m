//
//  HHLimitTextView.m
//  RenMinWenLv
//
//  Created by Mac on 2021/8/26.
//

#import "HHLimitTextView.h"

@interface HHLimitTextView () <UITextViewDelegate>

@property (nonatomic, strong) HHAutoHeightTextView           *  textView;
@property (nonatomic, strong) UILabel                        *  limitLabel;

@end

@implementation HHLimitTextView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.hh_maxLimit = 0;
        self.hh_placeholderColor = PlaceholderColor;
        
        [self initUI];
    }
    return self;
}

- (void)initUI {

    WeakSelf
    self.textView = [[HHAutoHeightTextView alloc] init];
    self.textView.maxMarginSpace = KScale(60);
    self.textView.textColor = MainTextColor;
    self.textView.tintColor = ThemeColor;
    self.textView.font = KFontHarmonyOSMedium(14);
    self.textView.delegate = self;
    self.textView.textAlignment = NSTextAlignmentLeft;
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.backgroundColor = self.backgroundColor;
    [self addSubview:self.textView];
    
    self.textView.textHeightChangeBlock = ^(NSString *text, CGFloat textHeight) {
        [weakSelf.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(@(textHeight)).priority(888);
        }];
        //block回调
        if (weakSelf.hh_textChangedBlock) {
            weakSelf.hh_textChangedBlock(text,  textHeight);
        }
        [weakSelf layoutIfNeeded];
    };
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-20);
        make.right.mas_equalTo(-15);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    
    
    self.limitLabel = [[UILabel alloc] init];
    self.limitLabel.text = [NSString stringWithFormat:@"0/%ld", _hh_maxLimit];
    self.limitLabel.textColor = LightTextColor;
    self.limitLabel.font = KFontHarmonyOSMedium(10);
    self.limitLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.limitLabel];
    
    [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-8);
    }];
}


- (void)setHh_text:(NSString *)hh_text {
    if (ValidStr(hh_text)) {
        self.textView.text = hh_text;
    }
    self.limitLabel.text = [NSString stringWithFormat:@"%ld/%ld", hh_text.length, self.hh_maxLimit];
}

- (NSString *)hh_text {
    return self.textView.text;
}

- (void)setHh_placeholder:(NSString *)hh_placeholder {
    _hh_placeholder = hh_placeholder;
    self.textView.placeholder = hh_placeholder;
}

- (void)setHh_placeholderColor:(UIColor *)hh_placeholderColor {
    _hh_placeholderColor = hh_placeholderColor;
    self.textView.placeholderColor = hh_placeholderColor;
}

/**最大字数限制*/
- (void)setHh_maxLimit:(NSInteger)hh_maxLimit {
    _hh_maxLimit = hh_maxLimit;
    self.limitLabel.text = [NSString stringWithFormat:@"0/%ld", hh_maxLimit];
}


- (void)setHh_maxLine:(NSInteger)hh_maxLine {
    _hh_maxLine = hh_maxLine;
    self.textView.maxNumOfLines = hh_maxLine;
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    
    //输入的时候字符限制
    //判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
    UITextRange *selectedRange = textView.markedTextRange;
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    
    if (position) {
        return;
    }

    if (_hh_maxLimit > 0 && textView.text.length > _hh_maxLimit) {
        textView.text = [textView.text substringToIndex:_hh_maxLimit];
    }
    
    //显示当前字数
    HHLog(@" 显示当前字数--- >  %@, %ld", textView.text, textView.text.length);
    self.limitLabel.text = [NSString stringWithFormat:@"%ld/%ld", textView.text.length, _hh_maxLimit];

    HHLog(@"---- %@", self.textView.text);
    if (self.delegate && [self.delegate respondsToSelector:@selector(textView:textChange:)]) {
        [self.delegate textView:self textChange:self.textView.text];
    }
}


@end
