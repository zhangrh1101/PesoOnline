//
//  UIImage+HHExtension.h
//  CTFreightLoan
//
//  Created by 楚天小贷 on 2019/4/1.
//  Copyright © 2019年 Zzzzzzzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HHExtension)

/**
 颜色转图片
 */
+ (UIImage *)hh_imageWithColor:(UIColor *)color;

/**
 拉伸图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName;
+ (UIImage *)stretchableImageWithLocalName111:(NSString *)imageName;
/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (UIImage *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

/**
 旋转图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/**
 *  图片加水印
 *  string 需要加上去的文字
 */
- (UIImage *)watermarkImageWithString:(NSString *)string;

/**
 *  根据地址生成二维码图片
 *  urlString 地址
 */
+ (UIImage *)creatQRcodeWithUrl:(NSString *)urlString size:(CGFloat)size;


@end

NS_ASSUME_NONNULL_END
