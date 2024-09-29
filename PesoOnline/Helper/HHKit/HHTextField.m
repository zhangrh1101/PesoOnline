//
//  HHTextField.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/18.
//

#import "HHTextField.h"

@interface HHTextField ()

@property (nonatomic, strong) UILabel *  titleLB;

@end
@implementation HHTextField

- (instancetype)init
{
    if (self = [super init]) {
        
        self.backgroundColor = kColorWhite;
        self.tintColor = ThemeColor;
        self.textColor = DarkTextColor;
        self.font = KFONT(16);
        
        self.marginLeft = 5;
        self.lineColor = SeparationlineColor;

        [self initSubViews];
    }
    return self;
}


- (void)initSubViews {
    
    self.titleLB = [ControlTools labelWithText:@"" textColor:DarkTextColor font:KFONT(16)];
    [self addSubview:self.titleLB];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.mas_left).offset(5);
    }];
    
}


- (void)setHh_tintColor:(UIColor *)hh_tintColor {
    _hh_tintColor = hh_tintColor;
    self.tintColor = hh_tintColor;
}

- (void)setHh_textColor:(UIColor *)hh_textColor {
    _hh_textColor = hh_textColor;
    self.textColor = hh_textColor;
}

- (void)setMarginLeft:(CGFloat)marginLeft {
    _marginLeft = marginLeft;
}

-(void)setMarginRight:(CGFloat)marginRight {
    _marginRight = marginRight;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLB.text = title;
}

- (void)setAlignment:(NSTextAlignment)alignment {
    self.textAlignment = alignment;
}

//- (void)setHh_placeholder:(NSString *)hh_placeholder {
//
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
//        attrs[NSForegroundColorAttributeName] = PlaceholderColor;
//    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:hh_placeholder attributes:attrs];
//    self.attributedPlaceholder = placeholder;
//}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


/**
 底部线条
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, SeparationlineColor.CGColor);
    
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame)-0.5, CGRectGetWidth(self.frame), 0.5));
}


- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.origin.x += bounds.origin.x + 10 + self.titleLB.width;
    bounds.size.width -= 30 +  self.titleLB.width;
    return bounds;
}


//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x + 10 + self.titleLB.width, bounds.origin.y, bounds.size.width - self.titleLB.width - 20, bounds.size.height);//更好理解些
    return inset;
}


-(CGRect)editingRectForBounds:(CGRect)bounds {
    //更好理解些return inset
    CGRect inset = CGRectMake(bounds.origin.x + 10 + self.titleLB.width, bounds.origin.y, bounds.size.width- self.titleLB.width - 20, bounds.size.height);
    return inset;
}


//控制右视图位置
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect rect = CGRectMake(bounds.size.width-40, self.height/2-self.rightView.height/2, self.rightView.width, self.rightView.height);
    return rect;
}

@end
