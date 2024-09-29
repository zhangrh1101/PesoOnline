//
//  TestViewController.m
//  WisePeople
//
//  Created by mac mini on 2022/8/17.
//

#import "TestViewController.h"
#import "HHWebViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HHRandomColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 60);
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:kColorWhite forState:UIControlStateNormal];
    [button setTitleColor:RGBAOF(0xffffff, 0.6) forState:UIControlStateHighlighted];
    button.titleLabel.font = KBOLDFONT(20);
    [button setTarget:self action:@selector(didLoginClick) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = KScale(25);
    button.backgroundColor = HH_HexColor(@"#007AFF");
    [self.view addSubview:button];
}

- (void)didLoginClick {
    
    HHWebViewController *webVC = [[HHWebViewController alloc] init];
    webVC.htmlTitle = @"";
    webVC.htmlUrl = @"https://192.168.6.200:20003/jdgz/app/#/";
    [self.navigationController pushViewController:webVC animated:YES];
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
