//
//  HHCustomButton.h
//  RenMinWenLv
//
//  Created by Mac on 2021/8/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHCustomButton : UIView

- (instancetype)initWithTitle:(NSString *)title;

@property (nonatomic, strong) UIImageView           *  iconView;
@property (nonatomic, strong) UILabel               *  contentLB;
@property (nonatomic, strong) UILabel               *  titleLB;


@property (nonatomic, copy) NSString                *  title;
@property (nonatomic, copy) NSString                *  icon;
@property (nonatomic, copy) NSString                *  content;

@property (nonatomic, assign) CGFloat                  marginTitleTop;

@property (nonatomic, copy) void(^buttonClickBlock)(HHCustomButton * customButton);


@end

NS_ASSUME_NONNULL_END
