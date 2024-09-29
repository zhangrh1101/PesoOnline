//
//  NoproductView.m
//  LongLongLiCai
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import "NoproductView.h"

@interface NoproductView ()
{
    UIImageView     *_faultPic;
    UILabel         *_infoLable;
    UIButton        *_button;
}
@end

@implementation NoproductView

- (instancetype)init{
    
    if (self = [super init]) {
        
        [self setup];
    }
    return self;
}


- (void)setup{
    
    UIView *view = [[UIView alloc]init];
    view.userInteractionEnabled = YES;
    [self addSubview:view];
    
    _faultPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_notes"]];
//    _faultPic.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:_faultPic];
    
    _infoLable = [[UILabel alloc] init];
    _infoLable.textAlignment = NSTextAlignmentCenter;
    _infoLable.font = KFONT(14);
    _infoLable.textColor = MainUnTextColor;
    _infoLable.numberOfLines = 0;
    [view addSubview:_infoLable];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.titleLabel.font = [UIFont systemFontOfSize:KFontSize(13)];
    _button.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 3);
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = KScale(16.0f);
//    _button.layer.borderColor = ThemeColor.CGColor;
//    _button.layer.borderWidth = 0.5;
    [_button setBackgroundColor:ThemeColor];
    [_button setTitleColor:kColorWhite forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(reloadNetworkDataSourcer) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_button];
    
    _button.hidden = YES;
    
    [_faultPic mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(view);
        make.bottom.equalTo(view.mas_centerY);
    }];
    
    [_infoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self->_faultPic.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(view.mas_centerX);
        make.top.equalTo(self->_infoLable.mas_bottom).offset(KScale(25.0f));
        make.width.mas_equalTo(KScale(140.0f));
        make.height.mas_equalTo(KScale(34));
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.equalTo(self);
    }];
    
}


- (void)reloadNetworkDataSourcer {
    
    if (self.reloadNetworkDataSource) {
        self.reloadNetworkDataSource();
    }
}



- (void)setEventTitle:(NSString *)eventTitle {
    
    _button.hidden = !eventTitle.length;
    [_button setTitle:eventTitle forState:UIControlStateNormal];
}


- (void)setExceptionType:(ExceptionType)exceptionType{
    
    switch (exceptionType) {
        case NET_ERROR:
        {
            _button.hidden = NO;
            [_button setTitle:@"重新加载" forState:UIControlStateNormal];
            _faultPic.image = [UIImage imageNamed:@"no_data"];
            _infoLable.text = @"网络不给力,请检查网络";
            break;
        }
        case SERVER_ERROR:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data"];
            _infoLable.text = @"服务器出小差了~";
            break;
        }
        case NO_DATA:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data_follow"];
            _infoLable.text = @"暂无数据";
            break;
        }
        case NO_FOLLOW:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data_follow"];
            _infoLable.text = @"暂无关注的文旅号";
            break;
        }
        case NO_FOLLOW_SEARCH:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data_follow"];
            _infoLable.text = @"关注列表中未查找到该用户";
            break;
        }
        case NO_CONTACTS:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data"];
            _infoLable.text = @"暂无联系人";
            break;
        }
        case NO_COMMENTS:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data"];
            _infoLable.text = @"暂无评论";
            break;
        }
        case NO_SEARCH:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data"];
            _infoLable.text = @"没有相关内容，换个关键词试试";
            break;
        }
        case NO_APPLYINFO:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data"];
            _infoLable.text = @"暂无申请信息";
            break;
        }
        case NO_TRAIN:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data"];
            _infoLable.text = @"您还没有进行过差旅预订哦,去买一张火车票试试吧";
            break;
        }
        case NO_EMPLOYEE:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data"];
            _infoLable.text = @"暂无员工";
            break;
        }
        case NO_ACCOUNT:
        {
            _faultPic.image = [UIImage imageNamed:@"no_data"];
            _infoLable.text = @"暂无账户信息";
            break;
        }
        default:
            break;
    }
}



@end




















