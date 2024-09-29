//
//  HomeNotiveView.m
//  WisePeople
//
//  Created by mac mini on 2022/8/17.
//

#import "HomeNotiveView.h"
#import "HHMarqueeView.h"

@interface HomeNotiveView ()

@property (nonatomic, strong) UIImageView                * leftIcon;
@property (nonatomic, strong) UILabel                    * titleLabel;
@property (nonatomic, strong) UIView                     * line;

@property (nonatomic, strong) HHMarqueeView              * marqueeView;
@property (nonatomic, strong) NSArray                    * dataArray;

@end

/**
 公告视图
 */
@implementation HomeNotiveView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.leftIcon];
    [self addSubview:self.titleLabel];
    [self addSubview:self.line];
    
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(KScale(15));
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(KScale(70));
        make.right.mas_equalTo(-KScale(10));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(KScale(60));
        make.size.mas_equalTo(CGSizeMake(0.5, 30));
    }];
    
    HHMarqueeView *marqueeBar = [HHMarqueeView marqueeBarWithFrame:CGRectMake(70, 0, SCREEN_WIDTH-KScale(110), 50) title:@"黄冈市“智慧人大”信息化系统已经上线，欢迎大家踊跃提出宝贵意见！"];
    [self addSubview:marqueeBar];
}


#pragma mark - Lazy
- (UIImageView *)leftIcon {
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc] init];
        _leftIcon.image = [UIImage imageNamed:@"home_notice"];
    }
    return _leftIcon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = MainTextColor;
        _titleLabel.font = KFONT(14);
    }
    return _titleLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = SeparationlineColor;
    }
    return _line;
}


@end
