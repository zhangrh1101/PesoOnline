//
//  HHTextView.m
//  RenMinWenLv
//
//  Created by Mac on 2021/8/14.
//

#import "HHTextView.h"

@interface HHTextView () 

@end

@implementation HHTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView {
    
    //输入的时候字符限制
    //判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
    UITextRange *selectedRange = textView.markedTextRange;
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return;
    }
  
//    if (self.hh_maxNumChar > 0 && textView.text.length > self.hh_maxNumChar) {
//        textView.text = [textView.text substringToIndex:self.hh_maxNumChar];
//    }
    
    if (self.hh_delegate && [self.hh_delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.hh_delegate textViewDidChange:textView];
    }
}



- (CGRect)caretRectForPosition:(UITextPosition *)position {
   
    CGRect originalRect = [super caretRectForPosition:position];
    CGFloat y = originalRect.origin.y + 1;
    originalRect.origin.y = y;
    return originalRect;
}


@end
