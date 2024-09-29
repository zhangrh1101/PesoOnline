//
//  UserDefaultsTool.m
//  DuoLa
//
//  Created by Zzzzzzzzz💤 on 2017/9/25.
//  Copyright © 2017年 ZRH. All rights reserved.
//

#import "UserDefaultsTool.h"
#define DLUserDefaults [NSUserDefaults standardUserDefaults]


@implementation UserDefaultsTool

+ (void)setBool:(BOOL)b forKey:(NSString *)key
{
    [DLUserDefaults setBool:b forKey:key];
    [DLUserDefaults synchronize];
}

+ (void)setObject:(id)obj forKey:(NSString *)key
{
    [DLUserDefaults setObject:obj forKey:key];
    [DLUserDefaults synchronize];
}

+ (BOOL)boolForKey:(NSString *)key
{
    return [DLUserDefaults boolForKey:key];
}

+ (id)objectForKey:(NSString *)key
{
    return [DLUserDefaults objectForKey:key];
}

+(void)removeObjectForKey:(NSString *)key
{
    [DLUserDefaults removeObjectForKey:key];
    [DLUserDefaults synchronize];
}



//清除所有NSUserDefaults
+ (void)removeAllObjects {
    NSDictionary * dict = [DLUserDefaults dictionaryRepresentation];
    for (id key in dict) {
        [DLUserDefaults removeObjectForKey:key];
    }
    [DLUserDefaults synchronize];
}



// 判断文件是否存在
+ (BOOL)isSxistAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    return isExist;
}

// 获取Documents路径
- (NSString *)getDocumentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"path:%@", path);
    return path;
}

// 创建文件夹
- (void)createDirectory {
    NSString *documentsPath =[self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *iOSDirectory = [documentsPath stringByAppendingPathComponent:@"iOS"];
    BOOL isSuccess = [fileManager createDirectoryAtPath:iOSDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (isSuccess) {
        NSLog(@"success");
    } else {
        NSLog(@"fail");
    }
}

// 创建文件
- (void)createFile {
    NSString *documentsPath =[self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:@"usermodel.archive"];
    BOOL isSuccess = [fileManager createFileAtPath:iOSPath contents:nil attributes:nil];
    if (isSuccess) {
        NSLog(@"success");
    } else {
        NSLog(@"fail");
    }
}

// 写入文件
- (void)writeFile {
    NSString *documentsPath =[self getDocumentsPath];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:@"usermodel.archive"];
    NSString *content = @"我要写数据啦";
    BOOL isSuccess = [content writeToFile:iOSPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (isSuccess) {
        NSLog(@"write success");
    } else {
        NSLog(@"write fail");
    }
}

// 读取文件
- (void)readFileContent {
    NSString *documentsPath =[self getDocumentsPath];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:@"usermodel.archive"];
    NSString *content = [NSString stringWithContentsOfFile:iOSPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"read success: %@",content);
}

// 判断文件是否存在
- (BOOL)isSxistAtPaths:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    return isExist;
}

// 计算文件大小
- (unsigned long long)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    if (isExist) {
        unsigned long long fileSize = [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
        return fileSize;
    } else {
        NSLog(@"file is not exist");
        return 0;
    }
}

// 计算整个文件夹中所有文件大小
- (unsigned long long)folderSizeAtPath:(NSString*)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:folderPath];
    if (isExist) {
        NSEnumerator *childFileEnumerator = [[fileManager subpathsAtPath:folderPath] objectEnumerator];
        unsigned long long folderSize = 0;
        NSString *fileName = @"";
        while ((fileName = [childFileEnumerator nextObject]) != nil){
            NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
        return folderSize / (1024.0 * 1024.0);
    } else {
        NSLog(@"file is not exist");
        return 0;
    }
}

// 删除文件
- (void)deleteFile {
    NSString *documentsPath =[self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:@"usermodel.archive"];
    BOOL isSuccess = [fileManager removeItemAtPath:iOSPath error:nil];
    if (isSuccess) {
        NSLog(@"delete success");
    }else{
        NSLog(@"delete fail");
    }
}

// 移动文件
- (void)moveFileName {
    NSString *documentsPath =[self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"usermodel.archive"];
    NSString *moveToPath = [documentsPath stringByAppendingPathComponent:@"usermodel.archive"];
    BOOL isSuccess = [fileManager moveItemAtPath:filePath toPath:moveToPath error:nil];
    if (isSuccess) {
        NSLog(@"rename success");
    }else{
        NSLog(@"rename fail");
    }
}

// 重命名
- (void)renameFileName {
    //通过移动该文件对文件重命名
    NSString *documentsPath =[self getDocumentsPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"usermodel.archive"];
    NSString *moveToPath = [documentsPath stringByAppendingPathComponent:@"rename.archive"];
    BOOL isSuccess = [fileManager moveItemAtPath:filePath toPath:moveToPath error:nil];
    if (isSuccess) {
        NSLog(@"rename success");
    }else{
        NSLog(@"rename fail");
    }
}


@end
