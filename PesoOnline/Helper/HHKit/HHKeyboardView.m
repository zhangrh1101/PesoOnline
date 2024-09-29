//
//  HHKeyboardView.m
//  RenMinWenLv
//
//  Created by Mac on 2021/8/14.
//

#import "HHKeyboardView.h"

#define MIN_TEXTVIEW_HEIGHT 35
#define MAX_TEXTVIEW_HEIGHT 75

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)


@interface HHKeyboardView () <UITextViewDelegate>

@property (nonatomic, strong) UIView            * backView;

@end

@implementation HHKeyboardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initUI];
    }
    return self;
}


- (void)initUI {

    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = BorderColor.CGColor;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.5;
    
    self.backView = [[UIView alloc] init];
//    self.backView.backgroundColor = HHRandomColor;
    [self addSubview:self.backView];
    
    self.textView = [[HHTextView alloc] init];
    self.textView.placeholder = @"说点什么...";
    self.textView.hh_maxNumChar = 150;
    self.textView.font = KFontSemiBold(13);
    self.textView.layer.cornerRadius = 3;
    self.textView.layer.masksToBounds = YES;
    self.textView.backgroundColor = BackgroudColor_F3;
    self.textView.tintColor = ThemeColor;
    self.textView.delegate = self;
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.showsHorizontalScrollIndicator = NO;
    [self.backView addSubview:self.textView];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendBtn setImage:[UIImage imageNamed:@"news_message_send"] forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(sendMessageClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sendBtn];
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.adjustsImageWhenHighlighted = NO;
    [self.collectBtn setImage:[UIImage imageNamed:@"news_collect_unsel"] forState:UIControlStateNormal];
    [self.collectBtn setImage:[UIImage imageNamed:@"news_collect_sel"] forState:UIControlStateSelected];
    [self.collectBtn addTarget:self action:@selector(collectNewsClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.collectBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-KSafeAreaMargin);
//        make.bottom.mas_equalTo(0);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(7);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-7);
        make.left.mas_equalTo(15);
        make.right.equalTo(self.sendBtn.mas_left).offset(-10);
        make.height.mas_equalTo(MIN_TEXTVIEW_HEIGHT);
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView.mas_bottom).offset(-5);
        make.right.mas_equalTo(-55);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView.mas_bottom).offset(-5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
}


- (void)setHideCollect:(BOOL)hideCollect {
    _hideCollect = hideCollect;
    
    self.collectBtn.hidden = hideCollect;
    if (hideCollect) {
        [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
        }];
    }else{
        [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-55);
        }];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}



- (void)sendMessageClick {
    
    HHLog(@"sendMessageClick");
    if (self.delegate && [self.delegate respondsToSelector:@selector(hh_keyboardViewSendMessage:)]) {
        [self.delegate hh_keyboardViewSendMessage:self];
    }
}


- (void)collectNewsClick {
    
    HHLog(@"collectNewsClick");
    if (self.delegate && [self.delegate respondsToSelector:@selector(hh_keyboardViewCollectNews:)]) {
        [self.delegate hh_keyboardViewCollectNews:self];
    }   
}


- (void)clearText {
    
    self.textView.text = nil;

    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(MIN_TEXTVIEW_HEIGHT);
    }];
}

- (void)showKeyboard {
    
    [self.textView becomeFirstResponder];
}

- (void)hideKeyboard {
    
    [self.textView resignFirstResponder];
}

#pragma mark - textviewDelegate
- (void)textViewDidChange:(UITextView *)textView{

    CGFloat width = CGRectGetWidth(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGFloat newHeight = newSize.height;
    if (newHeight < MIN_TEXTVIEW_HEIGHT) {
        newHeight = MIN_TEXTVIEW_HEIGHT;
    }
    if (newHeight >= MAX_TEXTVIEW_HEIGHT) {
        newHeight = MAX_TEXTVIEW_HEIGHT;
    }
    
    //输入的时候字符限制
    //判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
    UITextRange *selectedRange = textView.markedTextRange;
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return;
    }
    if (textView.text.length >= 150) {
        textView.text = [textView.text substringToIndex:150];
    }

    HHLog(@"--- %f", newHeight);
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newHeight);
    }];
}


@end
