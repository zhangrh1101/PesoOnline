//
//  MineSystemCell.h
//  FasterVpn
//
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineSystemCell : UITableViewCell

@property (nonatomic, strong) UIImageView   * iconImage;
@property (nonatomic, strong) UILabel       * titleLB;
@property (nonatomic, strong) UILabel       * rightLB;
@property (nonatomic, strong) UIImageView   * arrowImage;
@property (nonatomic, strong) UIView        * line;

@property (nonatomic, copy) NSString        * icon;
@property (nonatomic, copy) NSString        * title;
@property (nonatomic, copy) NSString        * detail;
@property (nonatomic, copy) NSString        * rightIcon;
@property (nonatomic, assign) BOOL          * hideLine;

@end

NS_ASSUME_NONNULL_END
