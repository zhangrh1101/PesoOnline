//
//  BaseHandler.h
//  LongLongLiCai
//
//  Created by mc on 2018/4/3.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseHandler : NSObject

/**
 *  Handler处理完成后调用的Block
 */
typedef void (^CompleteBlock)(void);

/**
 *  Handler处理成功时调用的Block
 */
typedef void (^SuccessBlock)(id responseObject);

/**
 *  Handler处理失败时调用的Block
 */
typedef void (^FailedBlock)(id error);



@end
