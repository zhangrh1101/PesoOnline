//
//  HomeTodoView.h
//  WisePeople
//
//  Created by mac mini on 2022/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTodoView : UIView

@property (nonatomic, strong)  NSArray      * data;

@end

@interface HomeTodoItemView : UIView

@property (nonatomic, copy)   NSString      * icon;
@property (nonatomic, copy)   NSString      * title;
@property (nonatomic, copy)   NSString      * count;

@end

NS_ASSUME_NONNULL_END
