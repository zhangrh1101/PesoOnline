//
//  HomeTodoView.m
//  WisePeople
//
//  Created by mac mini on 2022/8/18.
//

#import "HomeTodoView.h"
@class HomeTodoItemView;

@interface HomeTodoView ()

@property (nonatomic, strong) HomeTodoItemView         * leftView;
@property (nonatomic, strong) HomeTodoItemView         * rightView;

@end

/**
 待办视图
 */
@implementation HomeTodoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
        
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(KScale(80));
        make.width.mas_equalTo((SCREEN_WIDTH-KScale(15*3))/2);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(KScale(80));
        make.width.mas_equalTo((SCREEN_WIDTH-KScale(15*3))/2);
    }];
}

#pragma mark - Set
- (void)setData:(NSArray *)data {
    _data = data;
//    self.leftView.icon = @"ic_home_db";
//    self.rightView.icon = @"ic_home_dy";
}

#pragma mark - Lazy
- (HomeTodoItemView *)leftView {
    if (!_leftView) {
        _leftView = [[HomeTodoItemView alloc] init];
        _leftView.icon = @"ic_home_db";
    }
    return _leftView;
}

- (HomeTodoItemView *)rightView {
    if (!_rightView) {
        _rightView = [[HomeTodoItemView alloc] init];
        _rightView.icon = @"ic_home_dy";
    }
    return _rightView;
}

@end



/**
 子视图Item
 */
@interface HomeTodoItemView ()

@property (nonatomic, strong) UILabel             * titleLabel;
@property (nonatomic, strong) UILabel             * countLabel;
@property (nonatomic, strong) UIImageView         * iconView;

@end

@implementation HomeTodoItemView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
        
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.countLabel];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KScale(15));
        make.left.mas_equalTo(KScale(25));
    }];

    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(KScale(8));
        make.left.mas_equalTo(KScale(25));
    }];
}

#pragma mark - Set
- (void)setIcon:(NSString *)icon {
    _icon = icon;
    self.iconView.image = [UIImage imageNamed:icon];
}

#pragma mark - Lazy
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"ic_home_db"];
    }
    return _iconView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"待办";
        _titleLabel.textColor = MainTextColor;
        _titleLabel.font = KBOLDFONT(14);
    }
    return _titleLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.text = @"110";
        _countLabel.textColor = BlueTextColor;
        _countLabel.font = KBOLDFONT(22);
    }
    return _countLabel;
}


@end
