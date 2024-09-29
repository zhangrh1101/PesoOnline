//
//  UserPrivacyPopView.h
//  RenMinWenLv
//
//  Created by Mac on 2021/9/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserPrivacyPopView : UIView

- (void)show;
- (void)hide;


+ (void)showWithAgree:(void(^)(void))agreeBlock;

//同意回调
@property (nonatomic, copy) void(^agreeBlock)(void);

@end

NS_ASSUME_NONNULL_END
