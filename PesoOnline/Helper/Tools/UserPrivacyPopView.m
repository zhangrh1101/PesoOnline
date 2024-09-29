//
//  UserPrivacyPopView.m
//  RenMinWenLv
//
//  Created by Mac on 2021/9/17.
//

#import "UserPrivacyPopView.h"

@interface UserPrivacyPopView ()

@property (nonatomic, strong) UIView                   * whiteView;
@property (nonatomic, strong) UIImageView              * shareImageView;
@property (nonatomic, strong) NSArray                  * dataArray;

@end

//用户隐私协议弹框
@implementation UserPrivacyPopView

- (instancetype)init {
    if(self=[super init]) {
        [self initUI];
    }
    return self;
}


- (void)initUI {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    //蒙版
    UIView *maskView = [[UIView alloc] init];
//    [maskView addTapGestureWithTarget:self action:@selector(hide)];
    [self addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    //底图
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.alpha = 0;
    self.whiteView.layer.cornerRadius = 8;
    self.whiteView.clipsToBounds = YES;
    [self addSubview:self.whiteView];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth-70);
        make.center.mas_equalTo(0);
    }];
    
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"个人隐私保护指引";
    titleLB.font = KBOLDFONT(18);
    titleLB.textColor = MainTextColor;
    titleLB.textAlignment = NSTextAlignmentCenter;
    [self.whiteView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    
    UILabel *privacyLB = [[UILabel alloc] init];
    privacyLB.text = @"欢迎您使用人民文旅客户端!\n为了更好地为您提供阅读新闻、发布评论等相关服务，我们根据您使用服务的具体功能需要，收集必要的用户信息。您可通过阅读《隐私协议》和《用户协议》了解我们收集、使用、存储和共享个人信息的情况，以及对您个人隐私的保护措施。人民文旅客户端深知个人信息对您的重要性，我们将以最高标准遵守法律法规要求，尽全力保护您的个人信息安全。\n如您同意，请点击“同意”开始接受。";
    privacyLB.font = KFONT(15);
    privacyLB.textColor = MainTextColor;
    privacyLB.numberOfLines = 0;
    [self.whiteView addSubview:privacyLB];
    [privacyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLB.mas_bottom);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    NSString * showText = privacyLB.text;
    privacyLB.attributedText = [self getAttributeWith:@[@"《隐私协议》",@"《用户协议》"] string:showText orginFont:15 orginColor:[UIColor darkGrayColor] attributeFont:16 attributeColor:BlueSystemTextColor];
    
    [privacyLB yb_addAttributeTapActionWithStrings:@[@"《隐私协议》",@"《用户协议》"] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {

        if (index == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:KString(@"%@%@",HTMLBaseURL,USER_PRIVACY_URL)]];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:KString(@"%@%@",HTMLBaseURL,USER_AGREEMENT_URL)]];
        }
    }];
    
    
    UIView *levelLine = [[UIView alloc] init];
    levelLine.backgroundColor = SeparationlineColor;
    [self.whiteView addSubview:levelLine];
    [levelLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(privacyLB.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    WeakSelf
    UIButton *cancelBtn = [ControlTools buttonWithImage:nil title:@"暂不使用" titleColor:BlueSystemTextColor font:KFONT(18) upInsideAction:^(id  _Nonnull sender) {
       
        [weakSelf hide];
        exit(0);
    }];
    [self.whiteView addSubview:cancelBtn];
    
    UIButton *sureBtn = [ControlTools buttonWithImage:nil title:@"同意" titleColor:BlueSystemTextColor font:KBOLDFONT(18) upInsideAction:^(id  _Nonnull sender) {
       
        [weakSelf hide];
        if (weakSelf.agreeBlock) {
            weakSelf.agreeBlock();
        }
        }];
    [self.whiteView addSubview:sureBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(levelLine.mas_bottom);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.equalTo(sureBtn.mas_left);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(levelLine.mas_bottom);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.equalTo(cancelBtn.mas_right);
        make.width.equalTo(cancelBtn.mas_width);
    }];
    
    
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = SeparationlineColor;
    [self.whiteView addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.whiteView.mas_centerX);
        make.centerY.equalTo(sureBtn.mas_centerY);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(35);
    }];
    
}



/*一键关注*/
- (void)onceFollowBtnClick {
    
    [self hide];
}


- (void)show {
    //显示动画
    [self scaleToShow:self.whiteView];
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteView.alpha = 1;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:nil];
}


//隐藏
- (void)hide {
    
    [self scaleToHide:self.whiteView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteView.alpha = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


//显示
+ (void)showWithAgree:(void (^)(void))agreeBlock {
    
    //创建弹出视图
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    UserPrivacyPopView *alter = [[UserPrivacyPopView alloc] init];
    alter.agreeBlock = agreeBlock;
    [window addSubview:alter];
    [alter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    //显示动画
    [alter scaleToShow:alter.whiteView];
    [UIView animateWithDuration:0.3 animations:^{
        alter.whiteView.alpha = 1;
        alter.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:nil];
}


- (void)scaleToShow:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0,  0.0,  0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4,   0.4,    0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1,   1.1,    0.25)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95,  0.95,   0.5)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0,   1.0,    1.0)]];
    animation.values = values;
    
    [aView.layer addAnimation:animation forKey:@"ShakeToShow"];
}

- (void)scaleToHide:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8,  0.8,   0.8)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1,   1.1,    1.1)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6,   0.6,    0.5)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3,   0.3,    0.3)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0,  0,  0)]];
    
    animation.values = values;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [aView.layer addAnimation:animation forKey:@"ShakeToHide"];
}


- (NSAttributedString *)getAttributeWith:(id)sender
                                  string:(NSString *)string
                               orginFont:(CGFloat)orginFont
                              orginColor:(UIColor *)orginColor
                           attributeFont:(CGFloat)attributeFont
                          attributeColor:(UIColor *)attributeColor
{
    __block  NSMutableAttributedString *totalStr = [[NSMutableAttributedString alloc] initWithString:string];
    [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:orginFont] range:NSMakeRange(0, string.length)];
    [totalStr addAttribute:NSForegroundColorAttributeName value:orginColor range:NSMakeRange(0, string.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5.0f]; //设置行间距
//    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [paragraphStyle setFirstLineHeadIndent:0.0];
    [paragraphStyle setAlignment:NSTextAlignmentJustified];
    [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
    [paragraphStyle setAllowsDefaultTighteningForTruncation:YES];
    [totalStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalStr length])];
    
    if ([sender isKindOfClass:[NSArray class]]) {
        
        __block NSString *oringinStr = string;
        __weak typeof(self) weakSelf = self;
        
        [sender enumerateObjectsUsingBlock:^(NSString *  _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSRange range = [oringinStr rangeOfString:str];
            [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributeFont] range:range];
            [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
            oringinStr = [oringinStr stringByReplacingCharactersInRange:range withString:[weakSelf getStringWithRange:range]];
        }];
        
    }else if ([sender isKindOfClass:[NSString class]]) {
        
        NSRange range = [string rangeOfString:sender];
        
        [totalStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attributeFont] range:range];
        [totalStr addAttribute:NSForegroundColorAttributeName value:attributeColor range:range];
    }
    return totalStr;
}

- (NSString *)getStringWithRange:(NSRange)range
{
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < range.length ; i++) {
        [string appendString:@" "];
    }
    return string;
}


@end
