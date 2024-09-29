//
//  ApiCheckTools.h
//  FasterVpn
//
//  Created by mac mini on 2022/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApiCheckTools : NSObject

+ (ApiCheckTools *)shareManager;

/*
 * 检查域名是否可用
 */
- (void)checkApi;

@end

NS_ASSUME_NONNULL_END
