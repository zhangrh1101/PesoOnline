//
//  NoProductManager.m
//  LongLongLiCai
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import "NoProductManager.h"
#import "NoproductView.h"

@implementation NoProductManager

/**
 *  展示没有网络HUD
 *
 *  @param superView     父视图
 *  @param offset   距离父视图顶部距离
 *  @param event    相关事件
 */
+ (void)showNonNetWorkHUDInView:(UIView *)superView margin:(NSInteger)offset event:(HUDEventBlock)event{
    
    [NoProductManager removeHUDFromView:superView];
    
    NoproductView *noDataView;
    for (UIView *subView in superView.subviews) {
        if ([subView isKindOfClass:[NoproductView class]]) {
            noDataView = (NoproductView *)subView;
            break;
        }
    }
    
    if (!noDataView && superView) {
        noDataView = [[NoproductView alloc]init];
        noDataView.tag = 9999;
        noDataView.backgroundColor = BackGroundColor;
        noDataView.exceptionType = NET_ERROR;
        noDataView.reloadNetworkDataSource = ^(){
            if (event) {
                event();
            }
        };
        [superView addSubview:noDataView];
        [superView bringSubviewToFront:noDataView];
        [noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(superView.mas_centerX);
            make.centerY.equalTo(superView.mas_centerY).offset(offset);
            make.size.equalTo(superView);
        }];
    }
    
}


/**
 *  展示没有数据的HUD
 *
 *  @param superView     父视图
 *  @param type     异常类型
 *  @param offset   距离父视图顶部距离
 */
+ (void)showNonDataHUDInView:(UIView *)superView exceptionType:(ExceptionType)type margin:(NSInteger)offset{
    
    [NoProductManager removeHUDFromView:superView];
    
    NoproductView *noDataView;
    for (UIView *subView in superView.subviews) {
        if ([subView isKindOfClass:[NoproductView class]]) {
            noDataView = (NoproductView *)subView;
            break;
        }
    }
    
    if (!noDataView && superView) {
        noDataView = [[NoproductView alloc] init];
        noDataView.tag = 9999;
        noDataView.backgroundColor = BackGroundColor;
        noDataView.exceptionType = type;
        [superView addSubview:noDataView];
        [superView bringSubviewToFront:noDataView];
        
        [noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(superView.mas_centerX);
            make.centerY.equalTo(superView.mas_centerY).offset(offset);
            make.size.equalTo(superView);
        }];
    }
}

/**
 *  展示带事件的HUD
 *
 *  @param superView     父视图
 *  @param offset   距离父视图顶部距离
 *  @param event    相关事件
 */
+ (void)showHUDInView:(UIView *)superView exceptionType:(ExceptionType)type margin:(NSInteger)offset event:(HUDEventBlock)event{
    
    [NoProductManager removeHUDFromView:superView];
    
    NoproductView *noDataView;
    for (UIView *subView in superView.subviews) {
        if ([subView isKindOfClass:[NoproductView class]]) {
            noDataView = (NoproductView *)subView;
            break;
        }
    }
    
    if (!noDataView && superView) {
        noDataView = [[NoproductView alloc] init];
        noDataView.tag = 9999;
        noDataView.backgroundColor = BackGroundColor;
        noDataView.exceptionType = type;
        noDataView.eventTitle = @"重新加载";
        noDataView.reloadNetworkDataSource = ^(){
            if (event) {
                event();
            }
        };
        [superView addSubview:noDataView];
        [superView bringSubviewToFront:noDataView];
        [noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(superView.mas_centerX);
            make.centerY.equalTo(superView.mas_centerY).offset(offset);
            make.size.equalTo(superView);
        }];
    }
}



+ (void)removeHUDFromView:(UIView *)view {
    
    if (view == nil) {
        return;
    }
    
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[NoproductView class]]) {
            [subView removeFromSuperview];
            break;
        }
    }
    
    for (UIView *subView in view.superview.subviews) {
        if ([subView isKindOfClass:[NoproductView class]]) {
            [subView removeFromSuperview];
            break;
        }
    }
}



@end











