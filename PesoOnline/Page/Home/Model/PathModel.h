//
//  PathModel.h
//  WisePeople
//
//  Created by mac mini on 2022/7/19.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PathModel : BaseModel

@property (nonatomic, copy) NSString    * pathId;
@property (nonatomic, copy) NSString    * inboundTag;
@property (nonatomic, copy) NSString    * protocol;
@property (nonatomic, copy) NSString    * pathCode;
@property (nonatomic, copy) NSString    * pathName;
@property (nonatomic, copy) NSString    * path;
@property (nonatomic, copy) NSString    * network;
@property (nonatomic, copy) NSString    * security;
@property (nonatomic, copy) NSString    * createUserID;
@property (nonatomic, copy) NSString    * serverArr;
@property (nonatomic, copy) NSString    * nodeArr;
@property (nonatomic, copy) NSString    * runStatus;
@property (nonatomic, copy) NSString    * iconUrl;

@property (nonatomic, assign) NSInteger   isUse;

@end

NS_ASSUME_NONNULL_END
