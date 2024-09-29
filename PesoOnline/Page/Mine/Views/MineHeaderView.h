//
//  MineHeaderView.h
//  FasterVpn
//
//  Created by mac mini on 2022/5/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface MineHeaderView : UIView

@property (nonatomic, strong) UserModel                         * model;

- (void)refreshUserInfo;

@end

NS_ASSUME_NONNULL_END
