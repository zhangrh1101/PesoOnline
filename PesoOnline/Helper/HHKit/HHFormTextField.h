//
//  HHFormTextField.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HHFormTextFieldDelegate <NSObject>

@optional
- (BOOL)hh_textFieldShouldBeginEditing:(UITextField *)textField;
- (void)hh_textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)hh_textFieldShouldEndEditing:(UITextField *)textField;
- (BOOL)hh_textFieldShouldClear:(UITextField *)textField;
- (BOOL)hh_textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string fieldResult:(NSString *)result;

@end

@interface HHFormTextField : UIView

@property (nonatomic, strong) UITextField               *  textField;
@property (nonatomic, strong) UIButton                  *  rightBtn;

@property (nonatomic, strong) UIImage                   *  hh_icon;

@property (nonatomic, copy) NSString                    *  hh_title;
@property (nonatomic, strong) UIColor                   *  hh_titleColor;
@property (nonatomic, strong) UIFont                    *  hh_titleFont;


@property (nonatomic, copy) NSString                    *  hh_text;
@property (nonatomic, strong) UIFont                    *  hh_textFont;
@property (nonatomic, strong) UIColor                   *  hh_textColor;

@property (nonatomic, copy) NSString                    *  hh_placeholder;
@property (nonatomic, strong) UIColor                   *  hh_placeholderColor;

@property (nonatomic, copy) NSString                    *  hh_rigthText;
@property (nonatomic, copy) NSString                    *  hh_normalImage;
@property (nonatomic, copy) NSString                    *  hh_selectImage;

@property(nonatomic , assign) UIKeyboardType               hh_keyboardType;
@property (nonatomic, assign) NSTextAlignment              hh_alignment;
@property (nonatomic, assign) UITextFieldViewMode          hh_clearButtonMode;
@property (nonatomic, assign) NSInteger                    hh_tag;
@property (nonatomic, assign) NSInteger                    hh_maxNumChar;
@property (nonatomic, assign) BOOL                         hh_secureTextEntry;

@property (nonatomic, assign) float                        limitWidth;

/*输入框到左边标题距离*/
@property (nonatomic, assign) float                        textMarinLeft;

/*底部线条*/
@property (nonatomic, strong) UIColor                   *  hh_lineColor;
@property (nonatomic, assign) BOOL                         isLine;

/*是否显示分割线 默认显示*/
@property (nonatomic, assign) BOOL                         isSepare;
/*是否必填*/
@property (nonatomic, assign) BOOL                         isRequest;
/*能否编辑*/
@property (nonatomic, assign) BOOL                         isEdit;
/*右边按钮点击*/
@property (nonatomic, copy) void(^hh_rightBtnClick) (UIButton *rightBtn, NSString *text);

@property (nonatomic, weak) id <HHFormTextFieldDelegate>    delegate;
@property (nonatomic, copy) void(^hh_textChangedBlock) (NSString *text);

@end
NS_ASSUME_NONNULL_END
