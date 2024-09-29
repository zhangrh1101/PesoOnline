//
//  HHPanGesturePopView.m
//  RenMinWenLv
//
//  Created by 张仁昊 on 2021/9/3.
//

#import "HHPanGesturePopView.h"

@interface HHPanGesturePopView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView                          * container;
@property (nonatomic, strong) UIView                          * maskView;

@property (nonatomic, strong) UIPanGestureRecognizer          * panGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer          * tapGestureRecognizer;

@property (nonatomic, strong) UIScrollView                    * scrollView;
//当前正在拖拽的是否是tableView
@property (nonatomic, assign) BOOL                              isDragScrollView;
//向下拖拽最后时刻的位移
@property (nonatomic, assign) CGFloat                           lastDrapDistance;
//初始位置
@property (nonatomic, assign) CGRect                            beginFrame;

@end

//手势拖拽父试图
@implementation HHPanGesturePopView

- (void)dealloc {
    
    [self.container removeFromSuperview];
    [self.maskView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)panGesturePopViewWithFrame:(CGRect)frame contentView:(UIView *)contentView {
    
    HHPanGesturePopView *view = [[HHPanGesturePopView alloc] initWithFrame:frame contentView:contentView];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame contentView:(UIView *)contentView {
    self = [super initWithFrame:frame];
    if (self) {
        self.isDragScrollView = NO;
        self.lastDrapDistance = 0.0;
        self.marginTop = 0;
        
        self.beginFrame = frame;
        self.backgroundColor = [UIColor whiteColor];
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [self.maskView addTapGestureWithTarget:self action:@selector(didMaskClick)];
        self.maskView.alpha = 0;
        [APP_KeyWindow addSubview:self.maskView];
        
        CGFloat radius = 10; // 圆角大小
        UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight; // 圆角位置
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
        
        self.container  = contentView;
        self.container.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.container];
        
        //添加点击手势
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuesture:)];
        self.tapGestureRecognizer = tapGestureRecognizer;
        tapGestureRecognizer.delegate = self;
        [self addGestureRecognizer:tapGestureRecognizer];
        
        //添加拖拽手势
        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:self.panGestureRecognizer];
        self.panGestureRecognizer.delegate = self;
    }
    return self;
}

- (void)didMaskClick {
    
    HHLog(@"didMaskClick");
    [self dismiss];
}

- (void)setHideMaskView:(BOOL)hideMaskView {
    _hideMaskView = hideMaskView;
    self.maskView.hidden = hideMaskView;
}

- (void)setMarginTop:(CGFloat)marginTop {
    _marginTop = marginTop;
    
    CGRect frame = self.frame;
    frame.origin.y = frame.origin.y - marginTop;
    self.frame = frame;
    self.beginFrame = frame;
}

#pragma mark - Action
//update method
- (void)showToView:(UIView *)view{
//    [self removeFromSuperview];
//    [view addSubview:self];
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = self.beginFrame;
                         frame.origin.y = frame.origin.y - frame.size.height + self.marginTop;
                         self.frame = frame;
                         self.maskView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)dismiss {
    
    [APP_KeyWindow endEditing:YES];
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect frame = self.beginFrame;
                         frame.origin.y = frame.origin.y;
                         self.frame = frame;
                         self.maskView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
//                         [self removeFromSuperview];
                     }];
}


#pragma mark - UIGestureRecognizerDelegate
//1
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

    if(gestureRecognizer == self.panGestureRecognizer) {
        UIView *touchView = touch.view;
        while (touchView != nil) {
            
            HHLog(@"touchView -- %@",touchView);
            if([touchView isKindOfClass:NSClassFromString(@"HHCommentsChildViewCell")]) {
                self.isDragScrollView = YES;
                UIView *superView = touchView.superview.superview.superview.superview;
                if([superView isKindOfClass:[UIScrollView class]]) {
                    self.scrollView = (UIScrollView *)superView;
                }
                break;
            }
            if([touchView isKindOfClass:[UIScrollView class]]) {
                self.isDragScrollView = YES;
                self.scrollView = (UIScrollView *)touchView;
                break;
            } else if(touchView == self.container) {
                self.isDragScrollView = NO;
                break;
            }
            touchView = (UIView *)[touchView nextResponder];
        }
        
        HHLog(@"11111isDragScrollView --- %d  %@", self.isDragScrollView, self.scrollView);
    }
    return YES;
}

//2.
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer == self.tapGestureRecognizer) {
        //如果是点击手势
        CGPoint point = [gestureRecognizer locationInView:_container];
        if([_container.layer containsPoint:point] && gestureRecognizer.view == self) {
            return NO;
        }
    } else if(gestureRecognizer == self.panGestureRecognizer){
        //如果是自己加的拖拽手势
        NSLog(@"gestureRecognizerShouldBegin");
    }
    return YES;
}

//3. 是否与其他手势共存，一般使用默认值(默认返回NO：不与任何手势共存)
- (BOOL)gestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if(gestureRecognizer == self.panGestureRecognizer) {
        if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")] ) {
            if([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]] ) {

                return YES;
            }
            
        }
    }
    return NO;
}



//拖拽手势
- (void)pan:(UIPanGestureRecognizer *)panGestureRecognizer {
    // 获取手指的偏移量
    CGPoint transP = [panGestureRecognizer translationInView:self];
    
    HHLog(@"isDragScrollView --- %d,  %f   %f", self.isDragScrollView, transP.y, self.scrollView.x);
    
    if(self.isDragScrollView) {
        //如果当前拖拽的是tableView
        if(self.scrollView.contentOffset.y <= 0) {
            //如果tableView置于顶端
            if(transP.y > 0) {
                //如果向下拖拽
                self.scrollView.contentOffset = CGPointMake(0, 0 );
                self.scrollView.panGestureRecognizer.enabled = NO;
                self.scrollView.panGestureRecognizer.enabled = YES;
                
                //二级Table
                if (self.scrollView.x < 60) {
                    self.isDragScrollView = NO;
                    //向下拖
                    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + transP.y, self.frame.size.width, self.frame.size.height);
                }
            } else {
                //如果向上拖拽
            }
        }
    } else {
        if(transP.y > 0) {
            //向下拖
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + transP.y, self.frame.size.width, self.frame.size.height);
            
            HHLog(@"下--- %@", NSStringFromCGRect(self.frame));
        } else if(transP.y < 0 && (self.beginFrame.origin.y + self.marginTop) < (self.frame.origin.y + self.frame.size.height)){
            //向上拖
            HHLog(@"上--- %f    %f", self.beginFrame.origin.y + self.marginTop, self.frame.origin.y + self.frame.size.height);
      
            self.frame = CGRectMake(self.frame.origin.x, (self.frame.origin.y + transP.y) > (self.frame.size.height - self.frame.size.height) ? (self.frame.origin.y + transP.y) : (self.frame.size.height - self.frame.size.height), self.frame.size.width, self.frame.size.height);

//            HHLog(@"上--- %@", NSStringFromCGRect(self.frame));
        } else {
            HHLog(@"超出--- %@", NSStringFromCGRect(self.frame));
        }
    }

    [panGestureRecognizer setTranslation:CGPointZero inView:self];
    if(panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"transP : %@",NSStringFromCGPoint(transP));
        if(self.lastDrapDistance > 10 && self.isDragScrollView == NO) {
            //如果是类似轻扫的那种
            [self dismiss];
        } else {
            //如果是普通拖拽
            if(self.frame.origin.y >= [UIScreen mainScreen].bounds.size.height - self.frame.size.height/2) {
                [self dismiss];
            } else {
                [UIView animateWithDuration:0.25f
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     CGRect frame = self.beginFrame;
                                     frame.origin.y = frame.origin.y - frame.size.height + self.marginTop;
                                     self.frame = frame;
                                 }
                                 completion:^(BOOL finished) {
                                     NSLog(@"结束");
                                 }];
            }
        }
    }
    self.lastDrapDistance = transP.y;
}

//点击手势
- (void)handleGuesture:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:_container];
    if(![_container.layer containsPoint:point] && sender.view == self) {
        [self dismiss];
        return;
    }
}



@end
