//
//  DeviceTools.h
//  Vmess
//
//  Created by qiaofeng wu on 2020/11/2.
//  Copyright © 2020 wxflyme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceTools : NSObject

/**
 获取机型
 */
+ (NSString *)deviceType;
+ (NSString *)getRandomStringWithNum:(NSInteger)num;

@end

NS_ASSUME_NONNULL_END
