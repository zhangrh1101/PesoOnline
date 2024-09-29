//
//  UIControl+HHEventInterval.h
//  RenMinWenLv
//
//  Created by Mac on 2021/8/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (HHEventInterval)

/**
 可以重复点击的时间间隔
 默认为0 不对按钮重复点击处理
 */
//@property (nonatomic,assign) NSTimeInterval timeInterval;  //用这个给重复点击加间隔
/**
 内部属性用于判断是否忽略替换的点击事件
 */
//@property (nonatomic,assign) BOOL isIgnoreEvent;

@end

NS_ASSUME_NONNULL_END
