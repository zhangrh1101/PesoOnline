//
//  MineOperationView.h
//  WisePeople
//
//  Created by mac mini on 2022/8/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MineOperationViewDelegate<NSObject>
@optional
- (void)didMineOperationMessageButtonClick;

- (void)didMineOperationMyfileButtonClick;

- (void)didMineOperationSettingButtonClick;

@end

@interface MineOperationView : UIView

@property (nonatomic, assign) id <MineOperationViewDelegate>         delegate;

@end

NS_ASSUME_NONNULL_END
