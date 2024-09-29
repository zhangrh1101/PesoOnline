//
//  HHFormSelectView.h
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OnClickBlock)(void);

@interface HHFormSelectView : UIView

/*标题*/
@property (nonatomic, copy)   NSString                  *  hh_title;
@property (nonatomic, strong) UIColor                   *  hh_titleColor;
@property (nonatomic, strong) UIFont                    *  hh_titleFont;

/*内容部分*/
@property (nonatomic, copy)   NSString                  *  hh_text;
@property (nonatomic, copy)   NSString                  *  hh_placeholder;
@property (nonatomic, strong) UIColor                   *  hh_placeholderColor;
@property (nonatomic, strong) UIColor                   *  hh_textColor;
@property (nonatomic, strong) UIFont                    *  hh_textFont;

@property (nonatomic, assign) NSTextAlignment              hh_alignment;
@property (nonatomic, assign) NSInteger                    hh_maxLine;

/*图标*/
@property (nonatomic, copy)   NSString                  *  hh_rigthImage;
@property (nonatomic, assign) BOOL                         hh_rigthHidden;

/*底部线条*/
@property (nonatomic, strong) UIColor                   *  hh_lineColor;
@property (nonatomic, assign) BOOL                         isLine;

/*是否必填*/
@property (nonatomic, assign) BOOL                         isRequest;

/*点击事件*/
@property (nonatomic, copy)  OnClickBlock                  onClickBlock;


@end

NS_ASSUME_NONNULL_END
