//
//  UIImageView+HHExtension.h
//  RenMinWenLv
//
//  Created by Mac on 2021/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (HHExtension)

- (void)wl_sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder;

@end

NS_ASSUME_NONNULL_END
