//
//  NoProductManager.h
//  LongLongLiCai
//
//  Created by mc on 2018/4/10.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ExceptionType){
    
    //网络出错
    NET_ERROR = 0,
    //服务器出错
    SERVER_ERROR = 1,
    //没有数据
    NO_DATA = 2,
    //没有关注
    NO_FOLLOW = 3,
    //没有搜索到关注
    NO_FOLLOW_SEARCH = 4,
    //没有联系人
    NO_CONTACTS = 5,
    //没有评论
    NO_COMMENTS = 6,
    //没有搜索内容
    NO_SEARCH = 7,
    //没有申请信息
    NO_APPLYINFO = 8,
    //没有差旅订单
    NO_TRAIN = 9,
    //没有员工
    NO_EMPLOYEE = 10,
    //没有账户
    NO_ACCOUNT = 11,
    //认证失败
    CERTIFY_FAIL = 101,
};

//视图上的事件
typedef void(^HUDEventBlock) (void);

@interface NoProductManager : NSObject
/**
 *  展示没有网络HUD
 *
 *  @param superView     父视图
 *  @param offset   距离父视图顶部距离
 *  @param event    相关事件
 */
+ (void)showNonNetWorkHUDInView:(UIView *)superView margin:(NSInteger)offset event:(HUDEventBlock)event;

/**
 *  展示没有数据的HUD
 *
 *  @param superView     父视图
 *  @param type     异常类型
 *  @param offset   距离父视图顶部距离
 */
+ (void)showNonDataHUDInView:(UIView *)superView exceptionType:(ExceptionType)type margin:(NSInteger)offset;

/**
 *  展示带事件的HUD
 *
 *  @param superView     父视图
 *  @param offset   距离父视图顶部距离
 *  @param event    相关事件
 */
+ (void)showHUDInView:(UIView *)superView exceptionType:(ExceptionType)type margin:(NSInteger)offset event:(HUDEventBlock)event;



+ (void)removeHUDFromView:(UIView *)view;


@end











