//
//  HHLimitTextView.h
//  RenMinWenLv
//
//  Created by Mac on 2021/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HHLimitTextView;
@protocol HHLimitTextViewDelegate <NSObject>
@optional
/*
 如果外部实现了textView.heightDidChangeBlock，那么这个协议是不会执行的(因为这个block是在cell创建时候赋值的)，textView的block就不要在外部调用了，切记……
 不管外部实现 textView.heightDidChangeBlock 还是调用了这个协议方法，都需要调用tableview的如下两个方法，连着调用即可
 [tableView beginUpdates];
 [tableView endUpdates];
 */
-(void)textView:(HHLimitTextView *)textView textHeightChange:(NSString*)text;
/*内容发生改变*/
-(void)textView:(HHLimitTextView *)textView textChange:(NSString*)text;

@end

@interface HHLimitTextView : UIView

@property (nonatomic, copy)   NSString                       *  hh_text;

@property (nonatomic, copy)   NSString                       *  hh_placeholder;

@property (nonatomic, strong) UIColor                        *  hh_placeholderColor;

@property (nonatomic, assign) NSInteger                         hh_maxLimit;

@property (nonatomic, assign) NSInteger                         hh_maxLine;

@property (nonatomic, weak) id <HHLimitTextViewDelegate>        delegate;

@property (nonatomic, copy) void(^hh_textChangedBlock) (NSString *text, CGFloat textHeight);


@end

NS_ASSUME_NONNULL_END
