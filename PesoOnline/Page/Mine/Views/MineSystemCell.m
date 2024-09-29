//
//  MineSystemCell.m
//  FasterVpn
//
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import "MineSystemCell.h"

@implementation MineSystemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)uploadConstraints {
    
    CGFloat space = self.imageView.image ? 10 : 0;
    [self.titleLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(space);
    }];
}

- (void)initUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColor.clearColor;
    
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.titleLB];
    [self.contentView addSubview:self.rightLB];
    [self.contentView addSubview:self.arrowImage];
    [self.contentView addSubview:self.line];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightLB.mas_right).offset(10);
        make.right.mas_equalTo(-30);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(7, 12));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - setter & getter
- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = SeparationlineColor;
    }
    return _line;
}
- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.textColor = UIColor.blackColor;
        _titleLB.font = KFONT(15);
    }
    return _titleLB;
}

- (UILabel *)rightLB {
    if (!_rightLB) {
        _rightLB = [[UILabel alloc] init];
        _rightLB.textColor = MainUnTextColor;
        _rightLB.font = KFONT(12);
    }
    return _rightLB;
}

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] init];
    }
    return _arrowImage;
}

- (void)setIcon:(NSString *)icon {
    _icon = icon;
    
    if (icon.length > 0) {
        UIImage *img = [UIImage imageNamed:icon];
        if ((!self.imageView.image && !img) || (self.imageView.image && img)) {
            [self uploadConstraints];
        }
        self.imageView.image = [UIImage imageNamed:icon];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLB.text = title;
}

- (void)setDetail:(NSString *)detail {
    _detail = detail;
    self.rightLB.text = detail;
}

- (void)setRightIcon:(NSString *)rightIcon {
    _rightIcon = rightIcon;
    if (rightIcon.length > 0) {
        self.arrowImage.image = [UIImage imageNamed:rightIcon];
    }
}

- (void)setHideLine:(BOOL *)hideLine {
    _hideLine = hideLine;
    self.line.hidden = hideLine;
}

@end
