//
//  UIAlertController+Extension.h
//  CTFreightLoan
//
//  Created by 楚天小贷 on 2019/2/26.
//  Copyright © 2019年 Zzzzzzzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Extension)

+ (void) showViewController:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message titleArray:(NSArray *)titleArray cancel:(NSString *)cancel style:(UIAlertControllerStyle)style alertAction:(void (^)(NSInteger tag))alertAction cancelAction:(void (^)(void))cancelAction;


+ (void) showViewController:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message titleArray:(NSArray *)titleArray style:(UIAlertControllerStyle)style alertAction:(void (^)(NSInteger tag))alertAction;


@end

NS_ASSUME_NONNULL_END
