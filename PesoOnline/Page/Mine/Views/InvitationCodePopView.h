//
//  InvitationCodePopView.h
//  FasterVpn
//
//  Created by mac mini on 2022/6/9.
//
// 邀请码输入框

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InvitationCodePopView : UIView

+ (void)showWithblock:(void(^)(NSString *code))block;

@end

NS_ASSUME_NONNULL_END
