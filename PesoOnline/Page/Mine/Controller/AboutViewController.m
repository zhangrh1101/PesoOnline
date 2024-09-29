//
//  AboutViewController.m
//  FasterVpn
//
//  Created by ZRH on 2022/5/13.
//

#import "AboutViewController.h"
#import "HHWebViewController.h"
#import "MineSystemCell.h"
#import "UpdateVersionPopView.h"
#import "ApiCheckTools.h"

@interface AboutViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView                *   logoImg;
@property (nonatomic, strong) UILabel                    *   nameLB;
@property (nonatomic, strong) UILabel                    *   versionLB;
@property (nonatomic, strong) UITableView                *   tableView;
@property (nonatomic, strong) NSArray                    *   dataArray;
@property (nonatomic, strong) NSArray                    *   apiArray;

@property (nonatomic, copy) NSString                     *   officialWebUrl;


@end

/* 关于黑豹 */
@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关于我们";
    
    [self initUI];
    [self requestHttpApiListUrl];
}

//获取域名列表
- (void)requestHttpApiListUrl {
    
    WeakSelf
//    [PublicHandler requestPublicPath:HttpApiListUrl type:Get params:nil success:^(id responseObject) {
//        NSArray *array = responseObject;
//        if (array.count > 0) {
//            NSMutableArray *apiArray = [NSMutableArray array];
//            for (NSString *urlName in array) {
//                HHAlterListModel *model = [[HHAlterListModel alloc] init];
//                model.name = urlName;
//                [apiArray addObject:model];
//            }
//            weakSelf.apiArray = apiArray;
//        }
//    } failed:^(id error) {
//
//    }];
}

//获取官网地址
- (void)requestWebsiteUrl {
    WeakSelf
//    [MineHandler requestWebUrlPath:GetOfficialWebsiteUrl params:nil success:^(id responseObject) {
//        weakSelf.officialWebUrl = responseObject;
//        if (weakSelf.officialWebUrl.length > 0) {
//
//        }
//    } failed:^(id error) {
//
//    }];
}

/**
 检查更新
 */
- (void)checkAppVersion {
    WeakSelf
    NSString *versionUrl = [NSString stringWithFormat:@"%@%@",AppVersionUrl, APP_VERSION];
    [PublicHandler requestPublicPath:versionUrl type:Get params:nil success:^(id responseObject) {
        
        //是否更新，0不更新，1表示更新
        BOOL isUpate = [[responseObject objectForKey:@"isUpate"] boolValue];        // 描述
        NSString *versionStr = [responseObject objectForKey:@"appVersion"];         // 版本号
        NSString *downUrl = [responseObject objectForKey:@"downUrl"];          // App Store网址
        if (isUpate) {
            [HHSystemAlter showWithAnimationType:AlterAnimationTypeScale title:@"版本更新" subTitle:KString(@"是否立即更新到%@",versionStr) sureBlock:^{
                NSURL *downUrl = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/lu-jing-sheng-huo/id1465860914?mt=8&uo=4"];
                [[UIApplication sharedApplication] openURL:downUrl];
            }];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIAlertController showViewController:weakSelf title:@"当前已是最新版本" message:@"" titleArray:nil cancel:@"确定" style:UIAlertControllerStyleAlert alertAction:^(NSInteger tag) {
                } cancelAction:^{
                }];
            });
        }
    } failed:^(id error) {
    }];
}

- (void)getAppSwitchUrl {
    //开关接口
    WeakSelf
    [MBProgressHUD showHUD];
    NSString *switchUrl = [NSString stringWithFormat:@"%@%@",AppSwitchUrl, APP_VERSION];
    [PublicHandler requestPublicPath:switchUrl type:Get params:nil success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        HHLog(@"getAppSwitchUrl  %@", [responseObject objectForKey:@"mark"]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIAlertController showViewController:weakSelf title:@"注销账号申请成功" message:@"" titleArray:nil cancel:@"确定" style:UIAlertControllerStyleAlert alertAction:^(NSInteger tag) {
            } cancelAction:^{
                [UserModel logOut];
                [LoginManager onloginOut];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        });
    } failed:^(id error) {
        [MBProgressHUD hideHUD];
    }];
}

#pragma mark - tableview delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSystemCellID" forIndexPath:indexPath];
    NSDictionary *dict = self.dataArray[indexPath.row];
    cell.icon = dict[@"icon"];
    cell.title = dict[@"title"];
    cell.detail = dict[@"detail"];
    cell.rightIcon = @"arrow_right_white";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger index = [[self.dataArray[indexPath.row] objectForKey:@"index"] integerValue];
    switch (index) {
        case 0:{    //切换域名
            //            [HHAlterListPopView showWithDataArray:self.apiArray sureBlock:^(id data) {
            //                HHAlterListModel *model = (HHAlterListModel *)data;
            //                [[AFHttpManager sharedManager] setValue:[NSURL URLWithString:model.name] forKey:@"baseURL"];
            //            }];
            
            [[ApiCheckTools shareManager] checkApi];
        }
            break;
        case 1:{    //用户协议
            HHWebViewController *webVC = [[HHWebViewController alloc] init];
            webVC.htmlTitle = @"用户协议";
            webVC.htmlUrl = USER_AGREEMENT_URL;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 2:{    //隐私政策
            HHWebViewController *webVC = [[HHWebViewController alloc] init];
            webVC.htmlTitle = @"隐私政策";
            webVC.htmlUrl = USER_PRIVACY_URL;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 3:{    //官网地址
            [self requestWebsiteUrl];
        }
            break;
        case 4:{    //检查更新
            [self checkAppVersion];
        }
            break;
        case 5:{    //注销账号
            if (![UserModel getInfo].isLogined) {
                [LoginManager showLoginController];
            }else{
                WeakSelf
                [HHSystemAlter showWithAnimationType:AlterAnimationTypeScale title:@"注销账号" subTitle:@"您确定要注销账号吗？" sureBlock:^{
                    [weakSelf getAppSwitchUrl];
                }];
            }
        }
            break;
        default:
            break;
    }
    
    //        UpdateVersionPopView *updatePopView = [[UpdateVersionPopView alloc] initWithVersion:@"1.1.1" detail:@"红红火火恍恍惚惚" openUrl:nil status:1];
    //        [updatePopView showAlertView];
}

#pragma mark - initUI

- (void)initUI {
    
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.nameLB];
    [self.view addSubview:self.versionLB];
    [self.view addSubview:self.tableView];
    
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavBarHeight);
        make.centerX.equalTo(self.view);
    }];
    
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImg.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
    }];
    
    [self.versionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLB.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.versionLB.mas_bottom).offset(30);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
}

#pragma mark - setter & getter

- (NSArray *)dataArray {
    if (!_dataArray) {
        
        BOOL isSwitch = [UserDefaultsTool boolForKey:KDefaultsLineVersion];
        if (isSwitch) {
            _dataArray = @[@{@"index": @(0), @"icon": @"", @"title": @"更新连接", @"detail": @""},
                           @{@"index": @(1), @"icon": @"", @"title": @"用户协议", @"detail": @""},
                           @{@"index": @(2), @"icon": @"", @"title": @"隐私政策", @"detail": @""},
                           @{@"index": @(3), @"icon": @"", @"title": @"官方网址", @"detail": @""},
                           @{@"index": @(4), @"icon": @"", @"title": @"当前版本", @"detail": APP_VERSION},
                           @{@"index": @(5), @"icon": @"", @"title": @"注销账户", @"detail": @""}];
        }else{
            _dataArray = @[@{@"index": @(0), @"icon": @"", @"title": @"更新连接", @"detail": @""},
                           @{@"index": @(1), @"icon": @"", @"title": @"用户协议", @"detail": @""},
                           @{@"index": @(2), @"icon": @"", @"title": @"隐私政策", @"detail": @""},
                           @{@"index": @(3), @"icon": @"", @"title": @"官方网址", @"detail": @""},
                           @{@"index": @(4), @"icon": @"", @"title": @"当前版本", @"detail": APP_VERSION}];
        }
        
        
    }
    return _dataArray;
}

- (UIImageView *)logoImg {
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"logo_x49"];
    }
    return _logoImg;
}

- (UILabel *)nameLB {
    if (!_nameLB) {
        _nameLB = [[UILabel alloc] init];
        _nameLB.text = @"黑豹加速器";
        _nameLB.textColor = UIColor.whiteColor;
        _nameLB.font = KBOLDFONT(16);
    }
    return _nameLB;
}

- (UILabel *)versionLB {
    if (!_versionLB) {
        _versionLB = [[UILabel alloc] init];
        _versionLB.text = [NSString stringWithFormat:@"版本号：v%@",APP_VERSION];
        _versionLB.textColor = UIColor.whiteColor;
        _versionLB.font = KFONT(14);
    }
    return _versionLB;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:MineSystemCell.class forCellReuseIdentifier:@"MineSystemCellID"];
    }
    return _tableView;
}

@end
