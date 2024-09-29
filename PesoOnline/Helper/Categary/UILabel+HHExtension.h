//
//  UILabel+HHExtension.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HHExtension)

/**
  修改label内容距 `top` `left` `bottom` `right` 边距
 */
@property (nonatomic, assign) UIEdgeInsets contentInsets;

@end

NS_ASSUME_NONNULL_END
