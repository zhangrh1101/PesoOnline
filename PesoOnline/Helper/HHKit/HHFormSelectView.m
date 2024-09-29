//
//  HHFormSelectView.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/27.
//

#import "HHFormSelectView.h"

@interface HHFormSelectView ()

@property (nonatomic, strong) UILabel       *  requestLB;
@property (nonatomic, strong) UILabel       *  titleLB;
@property (nonatomic, strong) UILabel       *  textLB;
@property (nonatomic, strong) UIImageView   *  arrowImgView;

@property (nonatomic, strong) UIView *  line;

@end
@implementation HHFormSelectView

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
        self.hh_textColor = MainTextColor;
        self.hh_placeholderColor = PlaceholderColor;
    }
    return self;
}

- (void)setup {

    self.backgroundColor = kColorWhite;
    [self addTapGestureWithTarget:self action:@selector(selectViewClick)];
    
    self.requestLB = [ControlTools labelWithText:@"" textColor:[UIColor redColor] font:KFONT(15)];
    [self addSubview:self.requestLB];
    
    self.titleLB = [ControlTools labelWithText:@"" textColor:MainUnTextColor font:KFONT(14)];
    [self addSubview:self.titleLB];
    
    self.textLB = [ControlTools labelWithText:@"" textColor:MainTextColor font:KFONT(14) textAlignment:NSTextAlignmentRight];
    self.textLB.numberOfLines = 1;
    [self addSubview:self.textLB];
    
    self.arrowImgView = [[UIImageView alloc] init];
    self.arrowImgView.image = [UIImage imageNamed:@"arrow_right"];
    self.arrowImgView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.arrowImgView];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = SeparationlineColor;
    [self addSubview:self.line];
    
    [self.titleLB setContentCompressionResistancePriority:750 forAxis:UILayoutConstraintAxisHorizontal];
    [self.textLB setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.requestLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLB.mas_centerY);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(10);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(self.requestLB.mas_right).offset(0);
        make.right.equalTo(self.textLB.mas_left).offset(-10);
        make.width.mas_greaterThanOrEqualTo(60);
    }];
    
    [self.textLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.equalTo(self.titleLB.mas_right).offset(10);
        make.right.equalTo(self.arrowImgView.mas_left).offset(-10);
        make.height.mas_greaterThanOrEqualTo(50);
    }];
    
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(self.textLB.mas_centerY).offset(0);
        make.width.mas_equalTo(8);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(0.5);
    }];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.arrowImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        if (self.hh_rigthImage.length > 0) {
            make.right.mas_equalTo(-5);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }
    }];
}

- (void)setIsRequest:(BOOL)isRequest {
    _isRequest = isRequest;
    self.requestLB.text = isRequest ? @"*" : @"";
}

- (void)setHh_title:(NSString *)hh_title {
    _hh_title = hh_title;
    self.titleLB.text = hh_title;
}

- (void)setHh_titleColor:(UIColor *)hh_titleColor {
    _hh_titleColor = hh_titleColor;
    self.titleLB.textColor = hh_titleColor;
}

- (void)setHh_titleFont:(UIFont *)hh_titleFont {
    _hh_titleFont = hh_titleFont;
    self.titleLB.font = hh_titleFont;
}

- (void)setHh_placeholder:(NSString *)hh_placeholder {
    _hh_placeholder = hh_placeholder;
    self.textLB.text = hh_placeholder;
}

- (void)setHh_placeholderColor:(UIColor *)hh_placeholderColor {
    _hh_placeholderColor = hh_placeholderColor;
    self.textLB.textColor = hh_placeholderColor;
}

- (void)setHh_text:(NSString *)hh_text {
    
    if (ValidStr(hh_text)) {
        self.textLB.text = hh_text;
        self.textLB.textColor = self.hh_textColor;
    }else{
        self.textLB.text = self.hh_placeholder;
        self.textLB.textColor = self.hh_placeholderColor;
    }
}

- (NSString *)hh_text {
    return self.textLB.text;
}


- (void)setHh_maxLine:(NSInteger)hh_maxLine {
    _hh_maxLine = hh_maxLine;
    self.textLB.numberOfLines = hh_maxLine;
}

- (void)setHh_textFont:(UIFont *)hh_textFont {
    _hh_textFont = hh_textFont;
    self.textLB.font = hh_textFont;
}

- (void)setHh_textColor:(UIColor *)hh_textColor {
    _hh_textColor = hh_textColor;
}

- (void)setHh_rigthImage:(NSString *)hh_rigthImage {
    _hh_rigthImage = hh_rigthImage;
    if (ValidStr(hh_rigthImage)) {
        self.arrowImgView.image = [UIImage imageNamed:hh_rigthImage];
    }else{
        self.arrowImgView.image = nil;
    }
    [self layoutIfNeeded];
}

- (void)setHh_alignment:(NSTextAlignment)hh_alignment {
    _hh_alignment = hh_alignment;
    self.textLB.textAlignment = hh_alignment;
}


- (void)setHh_rigthHidden:(BOOL)hh_rigthHidden {
    _hh_rigthHidden = hh_rigthHidden;
    self.arrowImgView.hidden = hh_rigthHidden;
}

- (void)setHh_lineColor:(UIColor *)hh_lineColor {
    _hh_lineColor = hh_lineColor;
    self.line.backgroundColor = hh_lineColor;
}

- (void)setIsLine:(BOOL)isLine {
    _isLine = isLine;
    self.line.hidden = !isLine;
}

- (void)selectViewClick {
    if (self.onClickBlock) {
        self.onClickBlock();
    }
}



@end
