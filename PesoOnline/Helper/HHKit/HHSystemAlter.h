//
//  HHSystemAlter.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, AlterAnimationType) {
    AlterAnimationTypeDefault = 0,     //从下往上
    AlterAnimationTypeScale = 1,       //由小变大
};

@interface HHSystemAlter : UIView

@property (nonatomic, assign) AlterAnimationType    animationType;


+ (void)showWithAnimationType:(AlterAnimationType)type title:(NSString *)title subTitle:(NSString * _Nullable)subTitle sureBlock:(void (^)(void))sureBlock;

+ (void)showWithAnimationType:(AlterAnimationType)type title:(NSString *)title subTitle:(NSString * _Nullable)subTitle sureBlock:(void (^)(void))sureBlock cancleBlock:(nullable void (^)(void ))cancleBlock;

@end

NS_ASSUME_NONNULL_END
