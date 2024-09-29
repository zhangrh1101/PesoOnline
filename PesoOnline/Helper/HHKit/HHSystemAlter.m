//
//  HHSystemAlter.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/3/16.
//

#import "HHSystemAlter.h"

@interface HHSystemAlter ()

@property (nonatomic, strong) UIView        *  whiteView;

@property (nonatomic, copy) NSString        *  title;
@property (nonatomic, copy) NSString        *  subtitle;

@property (nonatomic, copy)  void (^sureBlock)(void);
@property (nonatomic, copy)  void (^cancleBlock)(void);

@end

@implementation HHSystemAlter

- (instancetype)init{
    if(self=[super init]) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    if(self=[super init]) {
        
        self.title = title;
        self.subtitle = subTitle;
        [self createUI];
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
    return self;
}

- (void)createUI {
    
    WeakSelf
    UIView *maskView = [[UIView alloc] init];
    [maskView addTapGestureWithTarget:self action:@selector(hide)];
    [self addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    

    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.alpha = 0;
    self.whiteView.layer.cornerRadius = 8;
    self.whiteView.clipsToBounds = YES;
    [self addSubview:self.whiteView];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth-80);
        make.center.mas_equalTo(0);
    }];
    
    
    /*标题*/
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = self.title;
    titleLB.font = KBOLDFONT(16);
    titleLB.textColor = DarkTextColor;
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.numberOfLines = 0;
    [self.whiteView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    /*子标题*/
    UILabel *subTitleLB = [[UILabel alloc] init];
    subTitleLB.text = self.subtitle;
    subTitleLB.font = KFONT(14);
    subTitleLB.textColor = DarkTextColor;
    subTitleLB.textAlignment = NSTextAlignmentCenter;
    subTitleLB.numberOfLines = 0;
    [self.whiteView addSubview:subTitleLB];
    [subTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLB.mas_bottom).offset(15);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    UIView *levelLine = [[UIView alloc] init];
    levelLine.backgroundColor = SeparationlineColor;
    [self.whiteView addSubview:levelLine];
    [levelLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subTitleLB.mas_bottom).offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *cancelBtn = [ControlTools buttonWithImage:nil title:@"取消" titleColor:DarkSubTextColor font:KFONT(14) upInsideAction:^(id  _Nonnull sender) {
        [weakSelf hide];
    }];
    [self.whiteView addSubview:cancelBtn];
    
    UIButton *sureBtn = [ControlTools buttonWithImage:nil title:@"确定" titleColor:DarkTextColor font:KFONT(14) upInsideAction:^(id  _Nonnull sender) {
        [weakSelf hide];
        
        weakSelf.sureBlock();
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



- (void)hide {
    
    switch (self.animationType) {
        case AlterAnimationTypeDefault:
            [self shakeToHide:self.whiteView];
            break;
        case AlterAnimationTypeScale:
            [self scaleToHide:self.whiteView];
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteView.alpha = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

+ (void)showWithAnimationType:(AlterAnimationType)type title:(NSString *)title subTitle:(NSString *)subTitle sureBlock:(void (^)(void))sureBlock {
    
    [HHSystemAlter showWithAnimationType:type title:title subTitle:subTitle sureBlock:sureBlock cancleBlock:nil];
}

+ (void)showWithAnimationType:(AlterAnimationType)type title:(NSString *)title subTitle:(NSString *)subTitle sureBlock:(void (^)(void))sureBlock cancleBlock:(nullable void (^)(void))cancleBlock {
    
    //创建弹出视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    HHSystemAlter *alter = [[HHSystemAlter alloc] initWithTitle:title subTitle:subTitle];
    alter.sureBlock = sureBlock;
    alter.cancleBlock = cancleBlock;
    alter.animationType = type;
    [window addSubview: alter];
    [alter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    switch (type) {
        case AlterAnimationTypeDefault:
            [alter shakeToShow:alter.whiteView];
            break;
        case AlterAnimationTypeScale:
            [alter scaleToShow:alter.whiteView];
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        alter.whiteView.alpha = 1;
        alter.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    } completion:nil];
}


- (void)shakeToShow:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.8, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.5, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.2, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];

    animation.values = values;
    
    [aView.layer addAnimation:animation forKey:@"ShakeToShow"];
}

- (void)shakeToHide:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.2, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.5, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight*0.8, 0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, kScreenHeight, 0)]];
    
    animation.values = values;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [aView.layer addAnimation:animation forKey:@"ShakeToHide"];
}



- (void)scaleToShow:(UIView *)aView {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    
    NSMutableArray *values = [NSMutableArray array];
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
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5,   0.5,    0.5)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0,  0,  0)]];
    
    animation.values = values;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [aView.layer addAnimation:animation forKey:@"ShakeToHide"];
}


@end
