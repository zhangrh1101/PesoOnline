//
//  HHButton.m
//  EnterpriseManager
//
//  Created by zhangrenhao on 2021/1/20.
//

#import "HHButton.h"

@implementation HHButton

- (void)setHighlighted:(BOOL)highlighted{

    if (self.state == UIControlStateHighlighted) {
        [self setHighlighted:NO];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.



@end
