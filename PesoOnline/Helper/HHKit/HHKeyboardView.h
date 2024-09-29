//
//  HHKeyboardView.h
//  RenMinWenLv
//
//  Created by Mac on 2021/8/14.
//

#import <UIKit/UIKit.h>
@class HHKeyboardView;

NS_ASSUME_NONNULL_BEGIN
@protocol HHKeyboardViewDelegate <NSObject>
@optional
//发送点击
- (void)hh_keyboardViewSendMessage:(HHKeyboardView *)keyboardView;
//收藏新闻
- (void)hh_keyboardViewCollectNews:(HHKeyboardView *)keyboardView;

@end

@interface HHKeyboardView : UIView

@property (nonatomic, strong) HHTextView        * textView;
@property (nonatomic, strong) UIButton          * sendBtn;
@property (nonatomic, strong) UIButton          * collectBtn;

@property (nonatomic, assign) BOOL                hideCollect;


//@property (nonatomic, copy) void(^changeTextBlock)(NSString *text,CGRect frame);
@property (nonatomic, weak) id <HHKeyboardViewDelegate>    delegate;

- (void)clearText;
- (void)showKeyboard;
- (void)hideKeyboard;

@end

NS_ASSUME_NONNULL_END
