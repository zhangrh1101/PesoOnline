//
//  HHVersionPopView.m
//  RenMinWenLv
//
//  Created by mac mini on 2022/1/12.
//

#import "HHVersionPopView.h"

@interface HHVersionPopView ()
{
    NSString *_version;
    NSString *_detail;
    NSString *_url;
    NSInteger _status;
}

@property (nonatomic, strong) UIView  *maskView;
@property (nonatomic, strong) UIView  *backView;

@end

@implementation HHVersionPopView


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
    
    UIView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScale(290), KScale(360))];
    backView.backgroundColor = [UIColor whiteColor];
    backView.center = maskView.center;
    backView.layer.cornerRadius = 5;
    [maskView addSubview:backView];
    backView.userInteractionEnabled = YES;

    UIImageView *backImage = [[UIImageView alloc] init];
    backImage.image = [UIImage imageNamed:@"public_version"];
    backImage.center = maskView.center;
    backImage.userInteractionEnabled = YES;
    [backView addSubview:backImage];
    
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-30);
        make.centerX.mas_equalTo(0);
    }];
    
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
        make.top.equalTo(backImage.mas_bottom).offset(20);
    }];
    
    
    UITextView *detailLB = [[UITextView alloc] init];
    detailLB.text = _detail;
//    detailLB.text = @"全新界面上线啦\n社区功能震撼来袭～\n全新邀友活动，新老用户均有福利哦！\n众多改进优化和性能提升\n众多改进优化和性能提升\n众多改进优化和性能提升\n众多改进优化和性能提升\n众多改进优化和性能提升\n";
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
        make.centerX.mas_equalTo(0);
        make.top.equalTo(versionLB.mas_bottom).offset(KScale(5));
        make.left.mas_equalTo(KScale(30));
        make.right.mas_equalTo(-KScale(30));
        make.bottom.mas_equalTo(-KScale(80));
    }];
    
    
    UIButton *toUpdataBtn = [[UIButton alloc] init];
    [toUpdataBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [toUpdataBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    toUpdataBtn.backgroundColor = ThemeColor;
    [toUpdataBtn addTarget:self action:@selector(toUpdateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:toUpdataBtn];
    [toUpdataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(backImage);
        make.bottom.mas_equalTo(KScale(-25));
        make.size.mas_equalTo(CGSizeMake(KScale(220), KScale(40)));
    }];
    toUpdataBtn.layer.cornerRadius = 5;

    if (_status < 2) {
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.imageView.contentMode = UIViewContentModeCenter;
        [closeBtn setImage:[UIImage imageNamed:@"public_version_close"] forState:UIControlStateNormal];
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


@end
