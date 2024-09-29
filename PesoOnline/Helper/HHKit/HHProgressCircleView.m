//
//  HHProgressCircleView.m
//  RenMinWenLv
//
//  Created by Mac on 2021/9/16.
//

#import "HHProgressCircleView.h"


#define HHCircleLineWidth 6.0f
#define HHCircleFont [UIFont boldSystemFontOfSize:15.0f]

@interface HHProgressCircleView ()

@property (nonatomic, strong) CAShapeLayer      * progressLayer;

@property (nonatomic, weak)   UILabel           * contentLabel;

@property (nonatomic, strong) NSTimer           * timer;
//上一次的进度值
@property (nonatomic, assign) CGFloat             lastProgress;

@end

@implementation HHProgressCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _progress = 0.0;
        _lastProgress = 0.0;
        
        self.lineWidth = HHCircleLineWidth;
        self.lightColor = GreenLightColor;
        self.darkColor = GreenDarkColor;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        self.layer.cornerRadius = 65;
        
        //百分比标签
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        contentLabel.font = KFONT(14);
        contentLabel.textColor = [UIColor whiteColor];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
//        [self addProgressCycle];
    }
    return self;
}


- (void)addProgressCycle{
    
    CGPoint arcCenter = CGPointMake(self.frame.size.width/2, self.frame.size.width/2);
    CGFloat radius = self.frame.size.width/2 - self.lineWidth;
    CGFloat startA = -M_PI_2;  //圆起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2;  //圆终点位置
    //圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    
    //CAShapeLayer
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = path.CGPath;
    shapLayer.fillColor = [UIColor clearColor].CGColor;//图形填充色
    shapLayer.strokeColor = [UIColor whiteColor].CGColor;//边线颜色
    shapLayer.lineWidth = self.lineWidth;
    [self.layer addSublayer:shapLayer];
    
    //进度layer
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.path = path.CGPath;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;        //图形填充色
    _progressLayer.strokeColor = self.lightColor.CGColor;          //边线颜色
    _progressLayer.lineWidth = self.lineWidth;
    _progressLayer.strokeEnd = 0.0f;
    _progressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_progressLayer];
    
    
    //渐变图层 渐变：RYUIColorWithRGB(140, 94, 0)   >>  RYUIColorWithRGB(229, 168, 46)   >>    RYUIColorWithRGB(140, 94, 0)
    CALayer * gradientLayer = [CALayer layer];
    //左边的渐变图层
    CAGradientLayer *leftGradientLayer = [CAGradientLayer layer];
    leftGradientLayer.frame = CGRectMake(0, 0, self.width / 2, self.height);
    [leftGradientLayer setColors:[NSArray arrayWithObjects:(id)self.darkColor.CGColor, (id)self.lightColor.CGColor, nil]];
    [leftGradientLayer setLocations:@[@0,@.9]];
    [leftGradientLayer setStartPoint:CGPointMake(0.5, 0)];
    [leftGradientLayer setEndPoint:CGPointMake(0.5, 1)];
    [gradientLayer addSublayer:leftGradientLayer];
    
    CAGradientLayer *rightGradientLayer = [CAGradientLayer layer];
    rightGradientLayer.frame = CGRectMake(self.width / 2, 0, self.width / 2, self.height);
    [rightGradientLayer setColors:[NSArray arrayWithObjects:(id)self.darkColor.CGColor, self.lightColor.CGColor, nil]];
    [rightGradientLayer setLocations:@[@0.2, @1]];
    [rightGradientLayer setStartPoint:CGPointMake(0.5, 0)];
    [rightGradientLayer setEndPoint:CGPointMake(0.5, 1)];
    [gradientLayer addSublayer:rightGradientLayer];
    //渐变图层映射到进度条路径上面
    [self.layer addSublayer:gradientLayer];
    
    //设置遮盖层
    [gradientLayer setMask:_progressLayer];
}


- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self startAninationWithPro:progress];
    //    self.contentLabel.text = @"跳过";
}


-(void)startAninationWithPro:(CGFloat)progress {
    
    NSLog(@"startAninationWithPro %lf %lf", self.lastProgress,  _progressLayer.strokeEnd);
    
    float duration = progress - self.lastProgress;

    //增加动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = [NSNumber numberWithFloat:self.lastProgress];
    pathAnimation.toValue = [NSNumber numberWithFloat:progress];
    pathAnimation.autoreverses = NO;
    
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = 1;
    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    self.lastProgress = self.progress;
}

//-(void)startAnimateFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
//    //增加动画
//    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 1.0;
//    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    pathAnimation.fromValue=[NSNumber numberWithFloat:fromValue];
//    pathAnimation.toValue=[NSNumber numberWithFloat:toValue];
//    pathAnimation.autoreverses=NO;
//    
//    pathAnimation.fillMode = kCAFillModeForwards;
//    pathAnimation.removedOnCompletion = NO;
//    pathAnimation.repeatCount = 1;
//    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
//}

- (void)animateToProgress:(CGFloat)progress {
        
    if(_progressLayer.strokeEnd != 0){
//        [self animateToZero];
    }
    float duration = progress - self.lastProgress;
    NSLog(@"%lf---%lf--%lf",self.lastProgress, progress, duration);

    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration), dispatch_get_main_queue(), ^{
        [weakSelf deleteTimer];
        NSString *progressStr = [NSString stringWithFormat:@"%lf",progress];
        NSDictionary *userInfo = @{@"progressStr":progressStr};
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:weakSelf selector:@selector(animate:) userInfo:userInfo repeats:YES];
    });
    
    self.lastProgress = progress;
}

- (void)animate:(NSTimer *)time {
    
    CGFloat progress = [[time.userInfo objectForKey:@"progressStr"]  floatValue];
    if(_progressLayer.strokeEnd <= progress) {
        _progressLayer.strokeEnd += 0.01;
//        NSLog(@"----> %f", _progressLayer.strokeEnd);
        if (_progressLayer.strokeEnd >= 1.0) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didProgressAnmateEnd)]) {
                [self.delegate didProgressAnmateEnd];
            }
        }
    }else{
        [self deleteTimer];
    }
}
//回滚到0  先判断 timer 有没有存在 存在 就把timer 删除
- (void)animateToZero {
    [self deleteTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(animateReset) userInfo:nil repeats:YES];
}

//动画重置
- (void)animateReset {
    if(_progressLayer.strokeEnd > 0){
        _progressLayer.strokeEnd -= 0.01;
    }else{
        [self deleteTimer];
    }
}

//重置
- (void)reset {
    self.lastProgress = 0;
//    [self startAninationWithPro:0];
    
    self.progressLayer.strokeEnd = 0;
    [self deleteTimer];
}

- (void)deleteTimer {
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark - set
- (void)setLightColor:(UIColor *)lightColor {
    _lightColor = lightColor;
}

- (void)setDarkColor:(UIColor *)darkColor {
    _darkColor = darkColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
}


- (void)layoutSubviews {
    
    [self addProgressCycle];
    [self layoutIfNeeded];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
