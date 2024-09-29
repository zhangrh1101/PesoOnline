//
//  HHCustomButton.m
//  RenMinWenLv
//
//  Created by Mac on 2021/8/23.
//

#import "HHCustomButton.h"

@interface HHCustomButton ()

@end

@implementation HHCustomButton

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        
        self.marginTitleTop = 10;
        [self initUIWithTitle:title];
    }
    return self;
}

- (void)initUIWithTitle:(NSString *)title {
    
    [self addTapGestureWithTarget:self action:@selector(didViewClick)];
    
    self.iconView = [[UIImageView alloc] init];
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconView];
    
    self.contentLB = [[UILabel alloc] init];
    self.contentLB.textColor = MainTextColor;
    self.contentLB.font = KFONT(20);
    self.contentLB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.contentLB];

    self.titleLB = [[UILabel alloc] init];
    self.titleLB.textColor = kColorWhite;
    self.titleLB.font = KFONT(14);
    self.titleLB.textAlignment = NSTextAlignmentCenter;
    self.titleLB.text = title;
    [self addSubview:self.titleLB];
}

- (void)setTitle:(NSString *)title {
    
    self.titleLB.text = title;
}

- (void)setIcon:(NSString *)icon {
    _icon = icon;
    self.iconView.image = [UIImage imageNamed:icon];
}

- (void)setContent:(NSString *)content {
    self.contentLB.text = content;
}


- (void)setMarginTitleTop:(CGFloat)marginTitleTop {
    _marginTitleTop = marginTitleTop;
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.icon.length > 0) {
        
        self.contentLB.hidden = YES;
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.right.mas_equalTo(0);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(self.marginTitleTop);
            make.left.right.mas_equalTo(0);
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(-5);
        }];
    }else{
        self.iconView.hidden = YES;
        
        [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.right.mas_equalTo(0);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLB.mas_bottom).offset(self.marginTitleTop);
            make.left.right.mas_equalTo(0);
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(-5);
        }];
    }
}


/**
 自定义按钮点击
 */
- (void)didViewClick {
    
    if (self.buttonClickBlock) {
        self.buttonClickBlock(self);
    }
}


@end
