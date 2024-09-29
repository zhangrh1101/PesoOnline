//
//  HHMarqueeView.h
//  WisePeople
//
//  Created by mac mini on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHMarqueeView : UIView

@property (nonatomic, strong) NSString  * title;
+ (instancetype)marqueeBarWithFrame:(CGRect)frame title:(NSString *)title;
- (void)updateTitle:(NSString *)title;
- (void)resume;

@end

NS_ASSUME_NONNULL_END
