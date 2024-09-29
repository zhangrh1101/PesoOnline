//
//  UserDefaultsTool.h
//  DuoLa
//
//  Created by Zzzzzzzzz💤 on 2017/9/25.
//  Copyright © 2017年 ZRH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsTool : NSObject

// 设值
+ (void)setBool:(BOOL)b forKey:(NSString *)key;
+ (void)setObject:(id)obj forKey:(NSString *)key;

// 取值
+ (BOOL)boolForKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;

+ (void)removeObjectForKey:(NSString *)key;

//清除所有NSUserDefaults
+ (void)removeAllObjects;

+ (BOOL)isSxistAtPath:(NSString *)filePath;

// 返回图片缓存
//+ (NSString *)getImageCache;


@end
