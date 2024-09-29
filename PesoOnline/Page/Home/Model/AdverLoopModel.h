//
//  AdverLoopModel.h
//  WisePeople
//
//  Created by mac mini on 2022/7/19.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdverLoopModel : BaseModel

@property (nonatomic, copy) NSString    * title;
@property (nonatomic, copy) NSString    * content;
@property (nonatomic, copy) NSString    * tid;
@property (nonatomic, copy) NSString    * keyword;
@property (nonatomic, copy) NSString    * buttonName;
@property (nonatomic, copy) NSString    * url;

@property (nonatomic, assign) BOOL        isJump;
@property (nonatomic, assign) BOOL        isDetails;

@end

NS_ASSUME_NONNULL_END
