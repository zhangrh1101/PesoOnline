//
//  UIButton+EnlargeEdge.h
//  Order_system
//
//  Created by mac on 17/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImagePosition) {
    ImagePositionLeft = 0,              //图片在左，文字在右，默认
    ImagePositionRight = 1,             //图片在右，文字在左
    ImagePositionTop = 2,               //图片在上，文字在下
    ImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdge:(CGFloat)size;///< 设置按钮扩大响应区域的范围

/**
 * @brief 详细设置按钮扩大响应区域的范围
 *
 * @param top         按钮上方扩展的范围
 * @param right       按钮右方扩展的范围
 * @param bottom      按钮下方扩展的范围
 * @param left        按钮左方扩展的范围
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;


/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(ImagePosition)postion spacing:(CGFloat)spacing;

/*
 * scale 图片比例
 */
- (void)setImagePosition:(ImagePosition)postion spacing:(CGFloat)spacing imageScale:(CGFloat)scale;



@end





