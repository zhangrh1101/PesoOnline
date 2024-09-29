//
//  MineViewController.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/6.
//

#import "MineViewController.h"
#import "HHWebViewController.h"
#import "AboutViewController.h"
#import "MineSystemCell.h"
#import "MineHeaderView.h"

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView                *   topImgView;
@property (nonatomic, strong) MineHeaderView             *   headerView;

@property (nonatomic, strong) UITableView                *   tableView;
@property (nonatomic, strong) UIButton                   *   logoutButton;

@property (nonatomic, copy) NSArray                      *   dataArray;
@property (nonatomic, copy) NSString                     *   opinionWebUrl;

@end

/* 个人中心 */
@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.fd_prefersNavigationBarHidden = YES;
    self.barTintState = NavBarTintStateLight;
    
    //添加刷新用户信息通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserInfo) name:KNotificationRefreshUserInfo object:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //添加阴影
    [self.logoutButton addShadowColor:HH_HexColor(@"#007AFF") shadowOpacity:0.8 shadowOffset:CGSizeMake(0, 3) shadowRadius:5];
}

- (void)refreshUserInfo {
    [self.headerView refreshUserInfo];
    [self.tableView reloadData];
}

//获取意见反馈地址
- (void)requestFeedback {
    
    WeakSelf
//    [MineHandler requestWebUrlPath:GetOpinionFeedbackUrl params:nil success:^(id responseObject) {
//        weakSelf.opinionWebUrl = responseObject;
//
//        if (![UserModel getInfo].isLogined) {
//            BaseNavigationController *loginNav = [[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
//            loginNav.modalPresentationStyle = UIModalPresentationFullScreen;
//            [self presentViewController:loginNav animated:YES completion:nil];
//        }else{
//            NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@&memPhone=%@&deviceType=11&appType=2",weakSelf.opinionWebUrl,[UserModel getInfo].cractMobile]];
//            [[UIApplication sharedApplication] openURL:URL];
//        }
//
//    } failed:^(id error) {
//
//    }];
}

#pragma mark - UI
- (void)initUI {
    
    [self.view addSubview:self.topImgView];
    [self.view addSubview:self.tableView];
    
    [self.topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(KScale(300));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-KSafeAreaMargin - 80);
    }];
}

#pragma mark - tableview delegate & datasource
- (void)didLoginOutClick {
    HHLog(@"didLoginOutClick");

    [HHSystemAlter showWithAnimationType:AlterAnimationTypeScale title:@"退出登录" subTitle:@"您确定要退出登录吗？" sureBlock:^{

    }];
}

#pragma TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    MineSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSystemCellID" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:dict[@"icon"]];
    cell.titleLB.text = dict[@"title"];
    cell.rightLB.text = dict[@"detail"];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_black"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![UserModel getInfo].isLogined && indexPath.row == 0) {
        [LoginManager showLoginController];
        return;
    }
    
    [MBProgressHUD showMessage:@"暂未开放"];
    
//    switch (indexPath.row) {
//        default:
//        {
//            AboutViewController *aboutVC = [[AboutViewController alloc] init];
//            [self.navigationController pushViewController:aboutVC animated:YES];
//        }
//            break;
//    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footer = [[UIView alloc] init];
    if ([UserModel getInfo].isLogined) {
        footer = [[UIView alloc] init];
        footer.frame = CGRectMake(0, 0, kScreenWidth, 120);
        self.logoutButton.frame = CGRectMake(40, 50, kScreenWidth-80, 44);
        [footer addSubview:self.logoutButton];
    }
    return footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    if ([UserModel getInfo].isLogined) {
        return 140;
    }
    return 0.01;
}


#pragma mark - lazy setter & getter
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
            @{@"icon": @"mine_list_qrcode", @"title": @"扫一扫", @"detail": @""},
            @{@"icon": @"mine_list_setting", @"title": @"通用设置", @"detail": @""},
            @{@"icon": @"mine_list_help", @"title": @"帮助中心", @"detail": @""},
//            @{@"icon": @"mine_password", @"title": @"修改密码", @"detail": @""},
//            @{@"icon": @"mine_about", @"title": @"关于智慧人大", @"detail": KString(@"v%@",APP_VERSION)}
        ];
    }
    return _dataArray;
}

- (UIImageView *)topImgView {
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] init];
        _topImgView.image = [UIImage imageNamed:@"mine_background"];
    }
    return _topImgView;
}

- (MineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc] init];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:MineSystemCell.class forCellReuseIdentifier:@"MineSystemCellID"];
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableHeaderView.height = KNavBarHeight + KScale(220);
    }
    return _tableView;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_logoutButton setTitleColor:RGBAOF(0xffffff, 0.6) forState:UIControlStateHighlighted];
        _logoutButton.titleLabel.font = KBOLDFONT(20);
        [_logoutButton setTarget:self action:@selector(didLoginOutClick) forControlEvents:UIControlEventTouchUpInside];
        _logoutButton.layer.cornerRadius = 22;
        _logoutButton.backgroundColor = HH_HexColor(@"#007AFF");
    }
    return _logoutButton;
}

@end
