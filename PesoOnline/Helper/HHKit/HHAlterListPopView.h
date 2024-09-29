//
//  HHAlterListPopView.h
//  RenMinWenLv
//
//  Created by Mac on 2021/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHAlterListModel : NSObject

@property (nonatomic, copy)  NSString           *  name;
@property (nonatomic, copy)  NSString           *  title;
@property (nonatomic, copy)  NSString           *  code;
@property (nonatomic, strong)  id                  value;

@end

@interface HHAlterListPopViewCell : UITableViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView;

@property (nonatomic, strong) HHAlterListModel         *  model;
@property (nonatomic, copy)   NSString                 *  name;
@property (nonatomic, copy)   NSString                 *  icon;

@end


@interface HHAlterListPopView : UIView

+ (void)showWithDataArray:(NSArray *)dataArray sureBlock:(void (^)(id data))sureBlock;

+ (void)showWithDataArray:(NSArray *)dataArray sureBlock:(void (^)(id data))sureBlock cancleBlock:(nullable void (^)(void))cancleBlock;

@end

NS_ASSUME_NONNULL_END
