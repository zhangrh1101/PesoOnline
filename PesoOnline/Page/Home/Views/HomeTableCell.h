//
//  HomeTableCell.h
//  WisePeople
//
//  Created by mac mini on 2022/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableCell : UITableViewCell

+ (instancetype)cellForTableView:(UITableView *)tableView;

@property (nonatomic, copy)   NSString      *  title;
@property (nonatomic, strong) NSArray       *  dataArray;

@end

@interface HomeCellItemView : UIButton

@property (nonatomic, strong) NSDictionary       *  data;
@property (nonatomic, copy) void(^homeCellItemViewClick)(void);

@end

NS_ASSUME_NONNULL_END
