//
//  IntiveViewController.m
//  FasterVpn
//
//  Created by mac mini on 2022/5/31.
//

#import "IntiveViewController.h"

@interface IntiveViewController ()

@property (nonatomic, copy) NSString                     *   intiveUrl;
@property (nonatomic, strong) UILabel                    *   intiveLB;
@property (nonatomic, strong) UIImageView                *   QRCodeImgView;

@end

/* 邀请页面 */
@implementation IntiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

#pragma mark - network
//获取邀请地址
- (void)requestShareIntive {
    WeakSelf
//    [MineHandler requestWebUrlPath:GetShareIntiveUrl params:nil success:^(id responseObject) {
//        if (responseObject) {
//            weakSelf.intiveUrl = responseObject;
//            weakSelf.QRCodeImgView.image = [UIImage creatQRcodeWithUrl:weakSelf.intiveUrl size:140];
//        }
//    } failed:^(id error) {
//
//    }];
}

#pragma mark - action
- (void)didClickCopyBtn {
    [MBProgressHUD showMessage:@"复制成功"];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.intiveLB.text;
}

#pragma mark - UI
- (void)initUI {
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"invite_background"];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    backImageView.layer.masksToBounds = YES;
    [self.view addSubview:backImageView];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    UIImageView *whiteImageView = [[UIImageView alloc] init];
    whiteImageView.userInteractionEnabled = YES;
    whiteImageView.image = [UIImage imageNamed:@"intive_white"];
    whiteImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:whiteImageView];

    [whiteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-KTabBarHeight);
    }];

    UILabel *title = [[UILabel alloc] init];
    title.text = @"邀请码";
    title.textColor = MainUnTextColor;
    [whiteImageView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];

    UILabel *intiveLB = [[UILabel alloc] init];
//    intiveLB.text = [UserModel getInfo].inviterCode;
    intiveLB.textColor = BlueTextColor;
    intiveLB.font = KBOLDFONT(30);
    [whiteImageView addSubview:intiveLB];
    [intiveLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo(50);
    }];

    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyButton setTitle:@"复制" forState:UIControlStateNormal];
    [copyButton setTitleColor:kColorWhite forState:UIControlStateNormal];
    [copyButton setBackgroundColor:[UIColor colorWithHexString:@"#F8396F"]];
    copyButton.titleLabel.font = KFONT(13);
    [copyButton setTarget:self action:@selector(didClickCopyBtn) forControlEvents:UIControlEventTouchUpInside];
    copyButton.layer.cornerRadius = 15;
    [whiteImageView addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];

    UIImageView *QRCodeImgView = [[UIImageView alloc] init];
    QRCodeImgView.contentMode = UIViewContentModeScaleAspectFit;
    [whiteImageView addSubview:QRCodeImgView];
    [QRCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-35);
        make.size.mas_equalTo(CGSizeMake(140, 140));
    }];

    self.intiveLB = intiveLB;
    self.QRCodeImgView = QRCodeImgView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
