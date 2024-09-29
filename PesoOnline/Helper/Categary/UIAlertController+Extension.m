//
//  UIAlertController+Extension.m
//  CTFreightLoan
//
//  Created by 楚天小贷 on 2019/2/26.
//  Copyright © 2019年 Zzzzzzzzz. All rights reserved.
//

#import "UIAlertController+Extension.h"

@implementation UIAlertController (Extension)


+ (void) showViewController:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message titleArray:(NSArray *)titleArray cancel:(NSString *)cancel style:(UIAlertControllerStyle)style alertAction:(void (^)(NSInteger tag))alertAction cancelAction:(void (^)(void))cancelAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];

    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArray objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (alertAction) {
                alertAction(i);
            }
        }];
        [confirm setValue:DarkTextColor forKey:@"titleTextColor"];
        [alert addAction:confirm];
        
    }
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelAction();
    }];
    [confirm setValue:DarkTextColor forKey:@"titleTextColor"];
    [alert addAction:confirm];
    
    
    [vc presentViewController:alert animated:YES completion:nil];
}



+ (void) showViewController:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message titleArray:(NSArray *)titleArray style:(UIAlertControllerStyle)style alertAction:(void (^)(NSInteger tag))alertAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:[titleArray objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (alertAction) {
                alertAction(i);
            }
        }];
//        [confirm setValue:ThemeColor forKey:@"titleTextColor"];
        [alert addAction:confirm];
    }
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
//    [confirm setValue:ThemeColor forKey:@"titleTextColor"];
    [alert addAction:confirm];
    [vc presentViewController:alert animated:YES completion:nil];
}



@end
