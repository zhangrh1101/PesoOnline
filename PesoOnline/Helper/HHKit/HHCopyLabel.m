//
//  HHCopyLabel.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/3/29.
//

#import "HHCopyLabel.h"

@interface HHCopyLabel ()
@property (nonatomic, strong)   UIPasteboard        * pasteBoard;
@end

@implementation HHCopyLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfLines = 0;
        self.pasteBoard = [UIPasteboard generalPasteboard];
        [self attachTapHandle];
    }
    return self;
}

- (void)attachTapHandle {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
//    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

//响应事件
- (void)handleTap {
    
    [self becomeFirstResponder]; //UILabel默认是不能响应事件的，所以要让它成为第一响应者
//    UIMenuController *menuVC = [UIMenuController sharedMenuController];
//    [menuVC setTargetRect:self.frame inView:self.superview]; //定位Menu
//    [menuVC setMenuVisible:YES animated:YES]; //展示Menu
    
    // 自定义 UIMenuController
    UIMenuController * menu = [UIMenuController sharedMenuController];
    UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyText:)];
    menu.menuItems = @[item1];
    [menu setTargetRect:self.bounds inView:self];
    [menu setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder { //指定UICopyLabel可以成为第一响应者 切忌不要把这个方法不小心写错了哟， 不要写成 becomeFirstResponder
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender { //指定该UICopyLabel可以响应的方法
//    if (action == @selector(copy:)) {
//        return YES;
//    }
//    if (action == @selector(paste:)) {
//        return YES;
//    }
//    if (action == @selector(delete:)) {
//        return YES;
//    }
//    if (action == @selector(selectAll:)) {
//        return YES;
//    }
//    if (action == @selector(cut:)) {
//        return YES;
//    }
//    if (action == @selector(select:)) {
//            return YES;
//    }
    if (action == @selector(copyText:)) {
            return YES;
    }
    return NO;
}

// 复制方法
- (void)copyText:(UIMenuController *)menu {
    // 没有文字时结束方法
    if (!self.text) return;
    // 复制文字到剪切板
    UIPasteboard * paste = [UIPasteboard generalPasteboard];
    paste.string = self.text;
}

- (void)paste:(id)sender {
    //    self.text = self.pasteBoard.string;
    //    NSLog(@"粘贴的内容%@", self.pasteBoard.string);
    
//    self.backgroundColor = self.pasteBoard.color;
}

- (void)copy:(id)sender {
    //    self.pasteBoard.string = self.text;
    //    NSLog(@"复制");
//    self.pasteBoard.color = self.backgroundColor;
}

-(void)cut:(id)sender {
    self.pasteBoard.string = self.text;
    self.text = @"";
    NSLog(@"剪切");
}

- (void)delete:(id)sender {
    self.text = nil;
    self.pasteBoard = nil;
}

- (void)selectAll:(id)sender {
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.text;
    NSLog(@"全选的数据%@", pasteBoard.string);
    //    self.textColor = [UIColor blueColor];
}


- (void)select:(id)sender {
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.text;
}

@end
