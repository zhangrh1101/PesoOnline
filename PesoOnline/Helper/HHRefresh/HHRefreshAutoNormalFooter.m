//
//  HHRefreshAutoNormalFooter.m
//  CTFreightLoan
//
//  Created by 楚天小贷 on 2019/3/7.
//  Copyright © 2019年 Zzzzzzzzz. All rights reserved.
//

#import "HHRefreshAutoNormalFooter.h"

@implementation HHRefreshAutoNormalFooter

- (void)prepare {
    [super prepare];
    
    self.stateLabel.font = KFONT(14);
    
    //普通闲置状态
    [self setTitle:@"" forState:MJRefreshStateIdle];
    //所有数据加载完毕
    [self setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    //设置控件的高度
    self.mj_h = 0;
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            self.mj_h = 0;
            break;
        case MJRefreshStateRefreshing:
            self.mj_h = 50;
            break;
        case MJRefreshStateNoMoreData:
            self.mj_h = 0;
            break;
        default:
            break;
    }
}




@end
