//
//  MineHeaderView.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/16.
//

#import "MineHeaderView.h"
#import "MineOperationView.h"

@interface MineHeaderView () <MineOperationViewDelegate>

@property (nonatomic, strong) UILabel                    *   titleLB;

@property (nonatomic, strong) UIImageView                *   avatarImage;
@property (nonatomic, strong) UILabel                    *   nameLB;
@property (nonatomic, strong) UILabel                    *   subNameLB;
@property (nonatomic, strong) UIButton                   *   editBtn;
@property (nonatomic, strong) UIView                     *   buttonView;

@property (nonatomic, strong) UIButton                   *   loginBtn;

//操作视图
@property (nonatomic, strong) MineOperationView          *   operationView;

@end

//我的 - 头部用户信息
@implementation MineHeaderView

- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
        [self refreshUserInfo];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.titleLB];
    [self addSubview:self.avatarImage];
    [self addSubview:self.nameLB];
    [self addSubview:self.subNameLB];
    [self addSubview:self.operationView];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KStatusBarHeight + 10);
        make.centerX.mas_equalTo(self);
    }];

    
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavBarHeight + 10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(HHSize(65, 65));
    }];

    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImage.mas_top).offset(8);
        make.left.equalTo(self.avatarImage.mas_right).offset(15);
    }];
    
    [self.subNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLB.mas_bottom).offset(8);
        make.left.equalTo(self.avatarImage.mas_right).offset(15);
    }];
    
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImage.mas_right).offset(30);
        make.centerY.equalTo(self.avatarImage);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(55);
    }];

    
    [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImage.mas_bottom).offset(30);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH-30);
        make.height.mas_equalTo(KScale(100));
    }];
}

#pragma mark - action
//登录按钮
- (void)loginBtnClick {
    [LoginManager showLoginController];
}


#pragma MineHeaderViewDelegate
//消息通知
- (void)didMineOperationMessageButtonClick {
    HHLog(@"消息通知");
    [MBProgressHUD showMessage:@"暂未开放"];
}
//我的文件
- (void)didMineOperationMyfileButtonClick {
    HHLog(@"我的文件");
    [MBProgressHUD showMessage:@"暂未开放"];
    
//    NSDictionary *params = @{
//        @"CMD" : @"LIST",
//        @"TYPE" : @"jsn_grid",
//        @"modelUuid" : @"98BCBAD6FE9D4EAF95687FA492E6DD18",
//        @"groupUuid" : @"AD937C2508344A41AE9B19495146E6E5",
//        @"strMap.CQ" : @"{OF: [{colName: oaanIsTop,OP: ASC}, {colName: oaanCreateTime,OP: DESC}],CF: [{colName: oaanStatus,OP: EQ,value: 1},{OP: AND},{colName: oaanOutdate,OP: GTE,value: --Date--}]}",
//        @"strMap.ECQ" : @"{OF:[],CF:[]}",
//        @"page" : @"1",
//        @"limit" : @"4",
//        @"start" : @"0",
//        @"strMap.publish" : @"History",
//    };
//
//    [HttpTools requestJsonDataWithMethedType:Post path:@"http://192.168.5.103:8086/oa/risen/core/flex/modapp/showAppModel.do" params:params isFormData:YES success:^(id responseObject) {
//
//    } failure:^(id error) {
//
//    }];
}
//账号设置
- (void)didMineOperationSettingButtonClick {
    HHLog(@"账号设置");
    [MBProgressHUD showMessage:@"暂未开放"];
}

#pragma mark - lazy
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.textColor = UIColor.whiteColor;
        _titleLB.font = KBOLDFONT(18);
        _titleLB.text = @"我的";
    }
    return _titleLB;
}

- (UIImageView *)avatarImage {
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] init];
        _avatarImage.image = [UIImage imageNamed:@"user_default_icon"];
    }
    return _avatarImage;
}

- (UILabel *)nameLB {
    if (!_nameLB) {
        _nameLB = [[UILabel alloc] init];
        _nameLB.textColor = UIColor.whiteColor;
        _nameLB.font = KBOLDFONT(18);
        _nameLB.text = @"用户名";
    }
    return _nameLB;
}

- (UILabel *)subNameLB {
    if (!_subNameLB) {
        _subNameLB = [[UILabel alloc] init];
        _subNameLB.textColor = UIColor.whiteColor;
        _subNameLB.font = KFONT(14);
        _subNameLB.text = @"职位";
    }
    return _subNameLB;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        WeakSelf
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"btn_login_small"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KScale(16)];
        _loginBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _loginBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 7, 0);
    }
    return _loginBtn;
}


- (MineOperationView *)operationView {
    if (!_operationView) {
        _operationView = [[MineOperationView alloc] init];
        _operationView.delegate = self;
        _operationView.backgroundColor = UIColor.whiteColor;
    }
    return _operationView;
}


#pragma mark - setter & getter
- (void)setModel:(UserModel *)model {
    
}


/**
 刷新信息
 */
- (void)refreshUserInfo {
    
    UserModel *model = [UserModel getInfo];
    HHLog(@"refreshUserInfo -- %@", model);

    if (model.isLogined) {
        self.loginBtn.hidden = YES;
        self.nameLB.text = model.cractCode;
        self.subNameLB.text = model.cractName;
    }else {
        self.loginBtn.hidden = NO;
        self.nameLB.text = @"";
        self.subNameLB.text = @"";
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
