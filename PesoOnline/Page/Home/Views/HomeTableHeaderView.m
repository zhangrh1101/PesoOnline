//
//  HomeTableHeaderView.m
//  WisePeople
//
//  Created by mac mini on 2022/8/18.
//

#import "HomeTableHeaderView.h"
#import "HomeNotiveView.h"
#import "HomeTodoView.h"

@interface HomeTableHeaderView ()

@property (nonatomic, strong) HomeNotiveView                 *   noticeView;
@property (nonatomic, strong) HomeTodoView                   *   todoView;

@end

/**
 首页顶部公告、待办
 */
@implementation HomeTableHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.noticeView];
    [self addSubview:self.todoView];

    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(KScale(15));
        make.right.mas_equalTo(-KScale(15));
        make.height.mas_equalTo(KScale(50));
    }];
    
    [self.todoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noticeView.mas_bottom).offset(KScale(15));
        make.left.mas_equalTo(KScale(15));
        make.right.mas_equalTo(-KScale(15));
        make.bottom.mas_equalTo(-KScale(15));
    }];
}

#pragma mark - Set
//- (void)setData:(NSArray *)data {
//    _data = data;
//    self.leftView.icon = @"ic_home_db";
//    self.rightView.icon = @"ic_home_dy";
//}

#pragma mark - Lazy
- (HomeNotiveView *)noticeView {
    if (!_noticeView) {
        _noticeView = [[HomeNotiveView alloc] init];
        _noticeView.layer.cornerRadius = 10;
    }
    return _noticeView;
}

- (HomeTodoView *)todoView {
    if (!_todoView) {
        _todoView = [[HomeTodoView alloc] init];
    }
    return _todoView;
}


@end
