//
//  BaseModel.h
//  LongLongLiCai
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject


@property (nonatomic, copy) NSString    *   code;
@property (nonatomic, copy) NSString    *   message;
@property (nonatomic, copy) NSString    *   success;
@property (nonatomic, copy) NSString    *   timestamp;

@property (nonatomic, strong) id    data;

@end


