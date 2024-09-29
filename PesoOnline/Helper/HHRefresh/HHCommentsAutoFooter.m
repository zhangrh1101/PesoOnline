//
//  HHCommentsAutoFooter.m
//  RenMinWenLv
//
//  Created by Mac on 2021/9/27.
//

#import "HHCommentsAutoFooter.h"

@interface HHCommentsAutoFooter ()

@property (nonatomic, strong) UIView     * leftLine;
@property (nonatomic, strong) UIView     * rightLine;
@property (nonatomic, strong) UILabel    * titleLB;

@end


@implementation HHCommentsAutoFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    
    //设置控件的高度
    self.mj_h = 50;
    
    UIView *leftLine = [[UIView alloc] init];
    leftLine.backgroundColor = SeparationlineColor;
    [self addSubview:leftLine];
    
    UIView *rightLine = [[UIView alloc] init];
    rightLine.backgroundColor = SeparationlineColor;
    [self addSubview:rightLine];
    
    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.text = @"暂无评论";
    titleLB.font = KFontSemiBold(14);
    titleLB.textColor = MainUnTextColor;
    [self addSubview:titleLB];
    
    self.leftLine = leftLine;
    self.rightLine = rightLine;
    self.titleLB = titleLB;
    
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.equalTo(titleLB.mas_left).offset(-10);
        make.height.mas_equalTo(0.5);
    }];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.left.equalTo(titleLB.mas_right).offset(10);
        make.height.mas_equalTo(0.5);
    }];
}


- (void)setTitle:(NSString *)title {
    _title = title;
}

#pragma mark 在这里设置子控件的位置和尺寸
//- (void)placeSubviews
//{
//    [super placeSubviews];
//
//    self.label.frame = self.bounds;
//    self.s.center = CGPointMake(self.mj_w - 20, self.mj_h - 20);
//
//    self.loading.center = CGPointMake(30, self.mj_h * 0.5);
//}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            self.titleLB.text = @"";
            break;
        case MJRefreshStateRefreshing:
            self.titleLB.text = @"";
            break;
        case MJRefreshStateNoMoreData:
//            self.titleLB.text = @"暂无更多评论";
            self.titleLB.text = self.title;
            break;
        default:
            break;
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
