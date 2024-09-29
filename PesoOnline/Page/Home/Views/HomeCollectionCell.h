//
//  HomeCollectionCell.h
//  WisePeople
//
//  Created by mac mini on 2022/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionCell : UICollectionViewCell

//@property (nonatomic, assign) HHShareType              type;

@property (nonatomic, copy) NSString                 * icon;
@property (nonatomic, copy) NSString                 * name;
@property (nonatomic, copy) void(^deleteKeywordClick)(void);

@end

NS_ASSUME_NONNULL_END
