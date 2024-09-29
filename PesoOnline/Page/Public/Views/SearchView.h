//
//  SearchView.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchView : UIView

/*高度*/
@property (nonatomic, assign) CGFloat          height;
/*内间距*/
@property (nonatomic, assign) UIEdgeInsets     edgeInsets;
/*提示词*/
@property (nonatomic, copy)   NSString       * placeholder;
/*左边视图*/
@property (nonatomic, copy)   UIView         * leftView;
/*textField*/
@property (nonatomic, strong) UITextField    * textField;
/*背景色*/
@property (nonatomic, strong) UIColor        * backColor;
/*TF背景色*/
@property (nonatomic, strong) UIColor        * textBackColor;
/*圆角*/
@property (nonatomic, assign) CGFloat          cornerRadius;

/*输入结果*/
@property (nonatomic, copy) void (^searchBlock)(NSString * _Nullable content);
/*开始输入*/
@property (nonatomic, copy) void (^beginBlock)(void);
/*清除按钮*/
@property (nonatomic, copy) void (^clearBlock)(void);
/*return按钮*/
@property (nonatomic, copy) void (^returnBlock)(void);

@end

NS_ASSUME_NONNULL_END
