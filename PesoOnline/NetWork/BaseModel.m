//
//  BaseModel.m
//  LongLongLiCai
//
//  Created by mc on 2018/4/4.
//  Copyright © 2018年 ZRH. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"message" : @"msg",
    };
}

@end

