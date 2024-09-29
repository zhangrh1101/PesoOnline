//
//  HHVersionPopView.h
//  RenMinWenLv
//
//  Created by mac mini on 2022/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHVersionPopView : UIView

- (instancetype)initWithVersion:(NSString *)version detail:(NSString *)detail openUrl:(NSString *)url status:(NSInteger)status;

- (void)showAlertView;

- (void)dismiss;



@end

NS_ASSUME_NONNULL_END
