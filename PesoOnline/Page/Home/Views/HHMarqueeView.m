//
//  HHMarqueeView.m
//  WisePeople
//
//  Created by mac mini on 2022/8/18.
//

#import "HHMarqueeView.h"

@interface HHMarqueeView ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) NSMutableArray *labelArray;

@end

// 跑马灯
@implementation HHMarqueeView

+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString*)title
{
    HHMarqueeView * marqueeBar = [[HHMarqueeView alloc] initWithFrame:frame];
    marqueeBar.title = title;
    return marqueeBar;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.firstLabel];
        [self addSubview:self.secondLabel];
        
        [self.labelArray addObject:_firstLabel];
        [self.labelArray addObject:_secondLabel];
        
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    NSString *raceStr = [NSString stringWithFormat:@"%@    ",title];
    _firstLabel.text = raceStr;
    _secondLabel.text = raceStr;
    
    CGFloat width = [raceStr widthForFont:KFONT(14)] + 100;
    self.firstLabel.frame = CGRectMake(0, 0, width, self.frame.size.height);
    self.secondLabel.frame = CGRectMake(_firstLabel.frame.origin.x + _firstLabel.bounds.size.width, _firstLabel.frame.origin.y, _firstLabel.bounds.size.width, _firstLabel.bounds.size.height);
    _secondLabel.hidden = ![self isNeedRaceAnimate];
    if ([self isNeedRaceAnimate]) {
        [self startAnimation];
    }
}

- (void)updateTitle:(NSString *)title
{
    self.title = title;
}

- (BOOL)isNeedRaceAnimate{
    return !(_firstLabel.bounds.size.width <= self.bounds.size.width);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_firstLabel && _secondLabel) {
        _firstLabel.frame = CGRectMake(0, 0, _firstLabel.bounds.size.width, self.bounds.size.height);
        _secondLabel.frame = CGRectMake(_firstLabel.frame.origin.x + _firstLabel.bounds.size.width, _firstLabel.frame.origin.y, _firstLabel.bounds.size.width, _firstLabel.bounds.size.height);
    }
    _secondLabel.hidden = ![self isNeedRaceAnimate];
}

- (void)startAnimation {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        //1.手动开启定时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(raceLabelFrameChanged:) userInfo:nil repeats:YES];
        //2.手动加入到事件循环中
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        //3.手动开启定时器
        [self.timer fire];
        //NSRunLoop 事件循环 处理的事件有：1.输入源事件（滑动事件、触摸事件）2.定时源事件
        //NSDefaultRunLoopMode 模式中 优先处理输入源事件，处理输入源事件时，不能处理定时源事件
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)raceLabelFrameChanged:(NSTimer *)timer {

    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *firstLabel = [self.labelArray firstObject];
        UILabel *secondLabel = [self.labelArray lastObject];
        CGRect frameOne = firstLabel.frame;
        CGRect frameTwo = secondLabel.frame;
        CGFloat firstX = firstLabel.frame.origin.x;
        CGFloat secondX = secondLabel.frame.origin.x;
        firstX -= 8.0;
        secondX -= 8.0;
        
        frameOne.origin.x = firstX;
        frameTwo.origin.x = secondX;
    
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            firstLabel.frame = frameOne;
            secondLabel.frame = frameTwo;
        } completion:^(BOOL finished) {
            if (ABS(firstX) >= firstLabel.bounds.size.width) {
                firstLabel.x = firstLabel.bounds.size.width + secondLabel.frame.origin.x;
                [self.labelArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
            }
            if (ABS(secondX) >= firstLabel.bounds.size.width) {
                secondLabel.x = firstLabel.bounds.size.width + firstLabel.frame.origin.x;
                [self.labelArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
            }
        }];
    });
}

- (void)resume {
    [self resumeAndStart:NO];
}

- (void)resumeAndStart {
    [self resumeAndStart:YES];
}

- (void)resumeAndStart:(BOOL)start
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _firstLabel.frame = CGRectMake(50, 0, _firstLabel.bounds.size.width, self.bounds.size.height);
    _secondLabel.frame = CGRectMake(_firstLabel.frame.origin.x + _firstLabel.bounds.size.width, _firstLabel.frame.origin.y, _firstLabel.bounds.size.width, _firstLabel.bounds.size.height);
    if (start) {
        [self startAnimation];
    }
}



#pragma mark - Properties
- (UILabel *)firstLabel
{
    if (_firstLabel == nil) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.textColor = MainTextColor;
        _firstLabel.font = KFONT(14);
        _firstLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _firstLabel;
}

- (UILabel *)secondLabel
{
    if (_secondLabel == nil) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.textColor = MainTextColor;
        _secondLabel.font = KFONT(14);
        _secondLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _secondLabel;
}

- (NSMutableArray *)labelArray
{
    if (!_labelArray) {
        self.labelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _labelArray;
}


- (CGFloat)getStringWidth:(NSString *)string
{
    if (string) {
        CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                           options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                           context:nil];
        return rect.size.width;
    }
    return 0.f;
}

@end
