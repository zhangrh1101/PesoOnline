//
//  TextFromView.h
//  FasterVpn
//
//  Created by mac mini on 2022/5/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFromView : UIView

@property (nonatomic, copy) NSString            *   title;
@property (nonatomic, copy) NSString            *   text;
@property (nonatomic, copy) NSString            *   placeholder;

@property (nonatomic, assign) NSInteger             maxChar;

@end

NS_ASSUME_NONNULL_END
