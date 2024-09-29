//
//  HHTextView.h
//  RenMinWenLv
//
//  Created by Mac on 2021/8/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HHTextView;
@protocol HHTextViewDelegate <NSObject>
@optional
/*
 [tableView beginUpdates];
 [tableView endUpdates];
 */
-(void)textViewDidChange:(HHTextView *)textView;

@end

@interface HHTextView : UITextView

@property (nonatomic, assign) NSInteger       hh_maxNumChar;

-(void)textChanged:(NSNotification*)notification;

@property (nonatomic, weak) id <HHTextViewDelegate>    hh_delegate;

@end

NS_ASSUME_NONNULL_END
