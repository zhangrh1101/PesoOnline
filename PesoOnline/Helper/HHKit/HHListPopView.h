//
//  HHListPopView.h
//  RenMinWenLv
//
//  Created by Mac on 2021/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHListPopModel : NSObject

@property (nonatomic, copy)  NSString           *  name;
@property (nonatomic, copy)  NSString           *  title;
@property (nonatomic, copy)  NSString           *  value;

@end


@interface HHListPopView : UIView

+ (void)showWithTitle:(NSString *)title dataArray:(NSArray *)dataArray sureBlock:(void (^)(id data))sureBlock;

+ (void)showWithTitle:(NSString *)title dataArray:(NSArray *)dataArray sureBlock:(void (^)(id data))sureBlock cancleBlock:(nullable void (^)(void))cancleBlock;


@end

NS_ASSUME_NONNULL_END
