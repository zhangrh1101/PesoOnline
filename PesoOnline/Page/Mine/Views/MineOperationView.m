//
//  MineOperationView.m
//  WisePeople
//
//  Created by mac mini on 2022/8/29.
//

#import "MineOperationView.h"

@interface MineOperationView ()

@property (nonatomic, strong) HHCustomButton             *   messageBtn;
@property (nonatomic, strong) HHCustomButton             *   myfileBtn;
@property (nonatomic, strong) HHCustomButton             *   settingBtn;

@end

//我的 - 操作视图
@implementation MineOperationView

- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.messageBtn];
    [self addSubview:self.myfileBtn];
    [self addSubview:self.settingBtn];

//    [self.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KScale(70) leadSpacing:15 tailSpacing:15];
    
    [self.subviews mas_distributeSudokuViewsWithFixedLineSpacing:10 fixedInteritemSpacing:10 warpCount:3 topSpacing:10 bottomSpacing:10 leadSpacing:20 tailSpacing:20];
    
//    [self.subviews mas_distributeSudokuViewsWithFixedItemWidth:KScale(70) fixedItemHeight:KScale(70) warpCount:3 topSpacing:15 bottomSpacing:15 leadSpacing:30 tailSpacing:30];
    
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.top.mas_equalTo(15);
//        make.bottom.mas_equalTo(-15);
//        make.height.mas_equalTo(KScale(70));
//    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //添加阴影
    self.layer.cornerRadius = KScale(10);
    [self addShadowColor:BorderColor shadowOpacity:0.6 shadowOffset:CGSizeMake(0, 5) shadowRadius:5];
}

#pragma mark - lazy
- (HHCustomButton *)messageBtn {
    if (!_messageBtn) {
        WeakSelf
        _messageBtn = [[HHCustomButton alloc] initWithTitle:@"消息通知"];
        _messageBtn.titleLB.textColor = MainTextColor;
        _messageBtn.icon = @"mine_message";
        _messageBtn.buttonClickBlock = ^(HHCustomButton * _Nonnull customButton) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didMineOperationMessageButtonClick)]) {
                [weakSelf.delegate didMineOperationMessageButtonClick];
            }
        };
    }
    return _messageBtn;
}

- (HHCustomButton *)myfileBtn {
    if (!_myfileBtn) {
        WeakSelf
        _myfileBtn = [[HHCustomButton alloc] initWithTitle:@"我的文件"];
        _myfileBtn.titleLB.textColor = MainTextColor;
        _myfileBtn.icon = @"mine_file";
        _myfileBtn.buttonClickBlock = ^(HHCustomButton * _Nonnull customButton) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didMineOperationMyfileButtonClick)]) {
                [weakSelf.delegate didMineOperationMyfileButtonClick];
            }
        };
    }
    return _myfileBtn;
}

- (HHCustomButton *)settingBtn {
    if (!_settingBtn) {
        WeakSelf
        _settingBtn = [[HHCustomButton alloc] initWithTitle:@"账号设置"];
        _settingBtn.titleLB.textColor = MainTextColor;
        _settingBtn.icon = @"mine_account";
        _settingBtn.buttonClickBlock = ^(HHCustomButton * _Nonnull customButton) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(didMineOperationSettingButtonClick)]) {
                [weakSelf.delegate didMineOperationSettingButtonClick];
            }
        };
    }
    return _settingBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
