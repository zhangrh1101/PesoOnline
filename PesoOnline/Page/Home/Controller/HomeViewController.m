//
//  HomeViewController.m
//  WisePeople
//
//  Created by mac mini on 2022/8/17.
//

#import "HomeViewController.h"
#import "AboutViewController.h"
#import "SearchView.h"
#import "HomeTableHeaderView.h"
#import "HomeTableCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) SearchView                     *   searchView;
@property (nonatomic, strong) HomeTableHeaderView            *   headerView;
@property (nonatomic, strong) UITableView                    *   tableView;
@property (nonatomic, strong) NSArray                        *   dataArray;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //    self.barTintColor = HHRandomColor;
    //    self.barTitleColor = HHRandomColor;
    //    self.barFont = [UIFont boldSystemFontOfSize:26];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setFd_prefersNavigationBarHidden:YES];
    self.barTintState = NavBarTintStateLight;
    
    [self initUI];
    [self initSearchBar];
}

#pragma mark - UI
- (void)initUI {
    
    //设置图片背景
    UIImage *backgroundImage = [UIImage imageNamed:@"home_background"];
    self.view.layer.contents = (id) backgroundImage.CGImage;
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [ControlTools labelWithText:@"黄冈市“智慧人大”信息化平台" textColor:[UIColor whiteColor] font:KBOLDFONT(22) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavBarHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(70);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KNavBarHeight+70);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-KTabBarHeight);
    }];
}

- (void)initSearchBar {
    WeakSelf
    SearchView *searchView = [[SearchView alloc] init];
    searchView.placeholder = @"黄冈人大";
    searchView.textField.returnKeyType = UIReturnKeySearch;
    searchView.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public_search"]];
    searchView.edgeInsets = UIEdgeInsetsMake(5, 20, 5, 20);
    searchView.searchBlock = ^(NSString *content) {
        //        weakSelf.searchKey = content;
        //        [weakSelf changeBtnTitle];
    };
    searchView.returnBlock = ^{
        //        [weakSelf didSearchClick];
    };
    searchView.clearBlock = ^{
    };
    [self.view addSubview:searchView];
    self.searchView = searchView;
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(KStatusBarHeight);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - Lazy
- (HomeTableHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[HomeTableHeaderView alloc] init];
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
        _tableView.contentInset = HHEdge(130-KNavBarHeight, 0, 0, 0);
    }
    return _tableView;
}

#pragma mark - UITableViewDeleDate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableCell *cell = [HomeTableCell cellForTableView:tableView];
    cell.title = self.dataArray[indexPath.row][@"title"];
    cell.dataArray = self.dataArray[indexPath.row][@"data"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (![UserModel getInfo].isLogined && indexPath.row != 3) {
//        [LoginManager showLoginController];
//        return;
//    }
//
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
    return self.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footer = [[UIView alloc] init];
    return footer;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return KScale(160);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return KScale(15);
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[
            
            @{
                @"title" : @"常用应用",
                @"data" : @[
                    @{@"icon" : @"icon_swgl", @"name" : @"收文管理", @"url" : @"http://192.168.5.103:8086/pcip-mobile/custom-form-list?uuid=D1FD60821CC0486FA3B1D05BEC804CDC", @"type" : @(1)},
                    @{@"icon" : @"icon_hytz", @"name" : @"会议通知", @"url" : @"http://192.168.5.103:8086/szhw-mobile/meeting-apply-list", @"type" : @(1)},
                    @{@"icon" : @"icon_szhy", @"name" : @"数字会议", @"url" : @"", @"type" : @(1)},
                    @{@"icon" : @"icon_dbssp", @"name" : @"代表随手拍", @"url" : @"https://192.168.6.200:20003/jdgz/app/#/", @"type" : @(1)},
                ]
            },
            @{
                @"title" : @"OA办公",
                @"data" : @[
                    @{@"icon" : @"icon_swgl", @"name" : @"收文管理", @"url" : @"http://192.168.5.103:8086/pcip-mobile/custom-form-list?uuid=D1FD60821CC0486FA3B1D05BEC804CDC", @"type" : @(1)},
                    @{@"icon" : @"icon_rcap", @"name" : @"日程安排", @"url" : @"http://192.168.5.103:8086/pcip-mobile/calendar", @"type" : @(1)},
                    @{@"icon" : @"icon_nbyj", @"name" : @"内部邮件", @"url" : @"http://192.168.5.103:8086/pcip-mobile/mail-list", @"type" : @(1)},
                    @{@"icon" : @"icon_djgl", @"name" : @"党建管理", @"url" : @"", @"type" : @(1)},
                ]
            },
            @{
                @"title" : @"数字会务",
                @"data" : @[
                    @{@"icon" : @"icon_hytz", @"name" : @"会议通知", @"url" : @"http://192.168.5.103:8086/szhw-mobile/meeting-apply-list", @"type" : @(1)},
                    @{@"icon" : @"icon_szhy", @"name" : @"数字会议", @"url" : @"", @"type" : @(1)},
                    @{@"icon" : @"icon_hysyy", @"name" : @"会议室预约", @"url" : @"http://192.168.5.103:8086/szhw-mobile/meeting-order-apply-list", @"type" : @(1)},
                    @{@"icon" : @"icon_hqbz", @"name" : @"后勤保障", @"url" : @"", @"type" : @(1)},
                ]
            },
            @{
                @"title" : @"代表履职服务",
                @"data" : @[
                    @{@"icon" : @"icon_dbssp", @"name" : @"代表随手拍", @"url" : @"https://192.168.6.200:20003/jdgz/app/#/", @"type" : @(1)},
                    @{@"icon" : @"icon_lzda", @"name" : @"履职档案", @"url" : @"", @"type" : @(1)},
                    @{@"icon" : @"icon_zsc", @"name" : @"知识窗", @"url" : @"", @"type" : @(1)},
                    @{@"icon" : @"icon_jdz", @"name" : @"监督站", @"url" : @"", @"type" : @(1)}
                ]
            },
            @{
                @"title" : @"立法工作",
                @"data" : @[
                    @{@"icon" : @"icon_yjzj", @"name" : @"意见征集", @"type" : @(1)},
                    @{@"icon" : @"icon_xmsc", @"name" : @"项目审查", @"type" : @(1)},
                    @{@"icon" : @"icon_lfzjk", @"name" : @"立法专家库", @"type" : @(1)},
                    @{@"icon" : @"icon_flfgk", @"name" : @"法律法规库", @"type" : @(1)},
                ]
            },
            @{
                @"title" : @"监督工作",
                @"data" : @[
                    @{@"icon" : @"icon_ytzj", @"name" : @"议题征集", @"type" : @(1)},
                    @{@"icon" : @"icon_zfjc", @"name" : @"执法检查", @"type" : @(1)},
                    @{@"icon" : @"icon_msss", @"name" : @"民生实事", @"type" : @(1)},
                    @{@"icon" : @"icon_jdjh", @"name" : @"监督计划", @"type" : @(1)},
                ]
            },
        ];
    }
    return _dataArray;
}

@end
