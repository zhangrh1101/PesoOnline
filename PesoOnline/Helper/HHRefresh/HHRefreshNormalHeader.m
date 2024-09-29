//
//  HHRefreshNormalHeader.m
//  CTFreightLoan
//
//  Created by 楚天小贷 on 2019/2/15.
//  Copyright © 2019年 Zzzzzzzzz. All rights reserved.
//

#import "HHRefreshNormalHeader.h"

@implementation HHRefreshNormalHeader

- (instancetype)init {
    
    if (self=[super init]) {
        
        [self setUI];
    }
    return self;
}


- (void)setUI {
    
//    [self prepare];
}

- (void)prepare {
    
    [super prepare];
    
    self.stateLabel.font = KFONT(14);
    self.lastUpdatedTimeLabel.font = KFONT(14);

    self.arrowView.image = [UIImage imageNamed:@"refresh_click"];
    
    //普通闲置状态
//    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    //所有数据加载完毕
//    [self setTitle:@"" forState:MJRefreshStateNoMoreData];
}


#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            self.lastUpdatedTimeLabel.hidden = YES;
            break;
        case MJRefreshStateRefreshing:
            self.lastUpdatedTimeLabel.hidden = NO;
            break;
        case MJRefreshStateNoMoreData:
            self.lastUpdatedTimeLabel.hidden = YES;
            break;
        default:
            break;
    }
}



@end
