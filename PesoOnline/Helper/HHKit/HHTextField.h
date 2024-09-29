//
//  HHTextField.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHTextField : UITextField

@property (nonatomic, copy) NSString  *  title;

@property (nonatomic, strong) UIColor *  hh_tintColor;
@property (nonatomic, strong) UIColor *  hh_textColor;
@property (nonatomic, strong) UIColor *  lineColor;

@property (nonatomic, assign) CGFloat   marginLeft;
@property (nonatomic, assign) CGFloat   marginRight;

@property (nonatomic, assign) NSTextAlignment  alignment;



@end

NS_ASSUME_NONNULL_END
