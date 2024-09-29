//
//  UpdateVersionPopView.h
//  FasterVpn
//
//  Created by mac mini on 2022/7/1.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateVersionPopView : UIView


- (instancetype)initWithVersion:(NSString *)version detail:(NSString *)detail openUrl:(NSString *)url status:(NSInteger)status;

- (void)showAlertView;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
