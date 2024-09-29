//
//  UIImageView+HHExtension.m
//  RenMinWenLv
//
//  Created by Mac on 2021/10/19.
//

#import "UIImageView+HHExtension.h"

@implementation UIImageView (HHExtension)


//图片质量压缩
- (void)wl_sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?x-oss-process=image/quality,q_50", [url absoluteString]];
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeholder options:0 progress:nil completed:nil];
}

@end
