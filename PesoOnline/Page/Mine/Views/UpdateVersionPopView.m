//
//  UpdateVersionPopView.m
//  FasterVpn
//
//  Created by mac mini on 2022/7/1.
//


#import "UpdateVersionPopView.h"

@interface UpdateVersionPopView ()
{
    NSString *_version;
    NSString *_detail;
    NSString *_url;
    NSInteger _status;
}
@property (nonatomic, strong) UIView  *maskView;
@property (nonatomic, strong) UIView  *backView;

@end

/* 更新弹窗 */
@implementation UpdateVersionPopView

// 366 503
- (instancetype)initWithVersion:(NSString *)version detail:(NSString *)detail openUrl:(NSString *)url status:(NSInteger)status {
    
    if (self = [super init]) {
        
        _version = version;
        _detail  = detail;
        _url     = url;
        _status  = status;
        
        if (status > 0) {
            [self createUI];
        }
    }
    return self;
}


- (void)createUI {
    
    self.frame = [[UIApplication sharedApplication].windows lastObject].bounds;
    
    UIView *maskView = [[UIView alloc] initWithFrame:self.bounds];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [self addSubview:maskView];
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScale(280), KScale(400))];
    backView.image = [UIImage imageNamed:@"adver_pop_bg"];
    backView.userInteractionEnabled = YES;
    backView.center = maskView.center;
    backView.layer.cornerRadius = 5;
    [maskView addSubview:backView];
    backView.userInteractionEnabled = YES;
    
    UILabel *versionLB = [[UILabel alloc] init];
    versionLB.font = [UIFont boldSystemFontOfSize:16.0];
    versionLB.textAlignment = NSTextAlignmentCenter;
    versionLB.textColor = [UIColor blackColor];
    [backView addSubview:versionLB];
//    versionLB.layer.cornerRadius = 2;
//    versionLB.layer.borderColor = [[UIColor colorWithHexString:@"#fd9500"] CGColor];
//    versionLB.layer.borderWidth = 0.5;
    [versionLB sizeToFit];
    
    NSString *version = KString(@"（%@）", _version);
    versionLB.attributedText = [NSString attributeString:KString(@"发现新版本%@",version) needText:version font:[UIFont systemFontOfSize:16] color:MainUnTextColor];
    [versionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KScale(30));
        make.top.mas_equalTo(KScale(160));
    }];
    
    
    UITextView *detailLB = [[UITextView alloc] init];
    detailLB.backgroundColor = HHRandomColor;
    detailLB.text = _detail;
    detailLB.text = @"全新界面上线啦\n社区功能震撼来袭～\n全新邀友活动，新老用户均有福利哦！\n众多改进优化和性能提升\n众多改进优化和性能提升\n众多改进优化和性能提升\n众多改进优化和性能提升\n众多改进优化和性能提升\n";
    detailLB.font = [UIFont systemFontOfSize:14.0];
    detailLB.textColor = MainUnTextColor;
    detailLB.editable = NO;
    detailLB.selectable = NO;
    [backView addSubview:detailLB];
    
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineSpacing = 10 - (detailLB.font.lineHeight - detailLB.font.pointSize);
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
//    [attributes setObject:[UIFont boldSystemFontOfSize:KScale(15)] forKey:NSFontAttributeName];
//    detailLB.attributedText = [[NSAttributedString alloc] initWithString:detailLB.text attributes:attributes];
//
//    CGSize size = [detailLB.text sizeWithAttributes:attributes];
 
    [detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(versionLB.mas_bottom).offset(5);
        make.left.mas_equalTo(KScale(30));
        make.right.mas_equalTo(-KScale(30));
        make.bottom.mas_equalTo(-KScale(80));
    }];
    
    
    UIButton *toUpdataBtn = [[UIButton alloc] init];
    [toUpdataBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [toUpdataBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [toUpdataBtn setBackgroundImage:[UIImage imageNamed:@"btn_bg_purple"] forState:UIControlStateNormal];
    toUpdataBtn.titleLabel.font = [UIFont boldSystemFontOfSize:KScale(16)];
    [toUpdataBtn addTarget:self action:@selector(toUpdateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:toUpdataBtn];
    [toUpdataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(KScale(-25));
        make.size.mas_equalTo(CGSizeMake(KScale(220), KScale(60)));
    }];
    toUpdataBtn.layer.cornerRadius = 5;
    toUpdataBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 7, 0);


    if (_status < 2) {
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.imageView.contentMode = UIViewContentModeCenter;
        [closeBtn setImage:[UIImage imageNamed:@"close_white_s"] forState:UIControlStateNormal];
        [closeBtn setTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:closeBtn];
        
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(35, 35));
        }];
    }
    backView.hidden = YES;
    
    
    self.maskView = maskView;
    self.backView = backView;
}


#pragma mark - 弹出

- (void)showAlertView
{
    self.backView.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self creatShowAnimation];
}


- (void)creatShowAnimation
{
    // 动画由小变大
    self.backView.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.86 initialSpringVelocity:20 options:UIViewAnimationOptionCurveLinear animations:^{
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.backView.alpha = 1.0f;
        self.backView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}


- (void)dismiss {
    
    self.backView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.86 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        self.backView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.backView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}



/**
 立即更新
 */
- (void)toUpdateBtnClick {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_url]];
//    [self dismiss];
}


//检测新版本
-(void)onCheckVersion{
    
    //初始化版本号
//    _newVersion = 0;
//    _oldVersion = [APP_VERSION keepNumbers];
    //这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1465860914"];
    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"通过appStore获取的数据信息：%@",jsonResponseString);
    if (jsonResponseString.length) {
        NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
        //解析json数据
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

//        NSArray *array = json[@"results"];
//        for (NSDictionary *dic in array) {
//            _newVersion = [[dic valueForKey:@"version"] keepNumbers];
//        }
        //获取本地软件的版本号        APP_VERSION
//        NSLog(@"通过appStore获取的版本号是：线上版本%ld  新版本%ld",_newVersion,_oldVersion);
        //对比发现的新版本和本地的版本
//        if (_newVersion > _oldVersion)
//        {
            NSString *subTitle = @"有新的版本更新，是否前往更新？";
            [HHSystemAlter showWithAnimationType:AlterAnimationTypeScale title:@"发现新版本" subTitle:subTitle sureBlock:^{
//                SafeCodeViewController *codeVC = [[SafeCodeViewController alloc] init];
//                codeVC.smsType = SendSMSCodeTypeChangeBind;
//                [weakSelf.navigationController pushViewController:codeVC animated:YES];
                
                NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/lu-jing-sheng-huo/id1465860914?mt=8&uo=4"];
                [[UIApplication sharedApplication] openURL:url];
            }];
//        }
    }
}

@end

