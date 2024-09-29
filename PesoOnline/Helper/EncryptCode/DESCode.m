//
//  DESCode.m
//  CTFreightLoan
//
//  Created by 楚天小贷 on 2019/1/11.
//  Copyright © 2019年 Zzzzzzzzz. All rights reserved.
//

#import "DESCode.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>

NSString *const DESKey = @"2019SCFC0HHFGJHG";
NSString *const KInitVector = @"DES/ECB/PKCS5Padding";


@interface DESCode ()

@end

@implementation DESCode

//+ (NSString *)encryptUseDES:(NSString *)plainText {
//
//    NSString *cipherText = nil;
//    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//    NSUInteger dataLength = [textData length];
//    unsigned char buffer[1024];
//    memset(buffer,0,sizeof(char));
//    size_t numBytesEncrypted =0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
//                                          kCCAlgorithmDES,
//                                          kCCOptionECBMode | kCCOptionPKCS7Padding,
//                                          [DESKey UTF8String],
//                                          kCCKeySizeDES,
//                                          NULL,
//                                          [textData bytes], dataLength,
//                                          buffer,
//                                          1024,
//                                          &numBytesEncrypted);
//    if (cryptStatus == kCCSuccess) {
//        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
//
//        cipherText = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
//    }
//    return cipherText;
//}
//
//
//+ (NSString *)decryptUseDES:(NSString *)cipherText {
//
//    NSData *cipherdata = [GTMBase64 decodeString:cipherText];
//    unsigned char buffer[1024];
//    memset(buffer,0,sizeof(char));
//    size_t numBytesDecrypted =0;
//    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
//                                          kCCAlgorithmDES,
//                                          kCCOptionECBMode | kCCOptionPKCS7Padding,
//                                          [DESKey UTF8String],
//                                          kCCKeySizeDES,
//                                          NULL,
//                                          [cipherdata bytes],
//                                          [cipherdata length],
//                                          buffer,1024,
//                                          &numBytesDecrypted);
//
//    NSString *plaintext = nil;
//    if(cryptStatus ==kCCSuccess)
//    {
//        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
//        plaintext = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    }
//
//    return plaintext;
//}


/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
+ (NSString *)hhEncodeDesWithString:(NSString *)plainText
{
//    const Byte iv[] = {1,2,3,4,5,6,7,8};

    // 加密后的数据
//    uint8_t *dataOut = NULL;
//    size_t dataOutAvailable = 0;
//    size_t dataOutMove = 0;
//
//    dataOutAvailable = (plainText.length + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
//    dataOut = malloc(dataOutAvailable * sizeof(uint8_t));
//    // 将已开辟内存空间buffer的首1个字节的值设为0
//    memset((void *)dataOut, 0x0, dataOutAvailable);
//
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, // 操作名称：加密
//                                          kCCAlgorithmDES, // 加密算法
//                                          kCCOptionPKCS7Padding | kCCOptionECBMode, // 填充模式，ECB模式
//                                          key.UTF8String, // 加密秘钥
//                                          kCCKeySizeDES, // 秘钥大小，和加密算法一致
//                                          NULL, // 初始向量：ECB模式为空
//                                          plainText.UTF8String, // 加密的明文
//                                          (size_t)plainText.length, // 加密明文的大小
//                                          dataOut, // 密文的接受者
//                                          dataOutAvailable, // 预计密文的大小
//                                          &dataOutMove); // 加密后密文的实际大小

    
    NSString *cipherText = nil;
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[10240];
    memset(buffer, 0, sizeof(char));        //预计辟内存空间大小
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionECBMode | kCCOptionPKCS7Padding,
                                          [DESKey UTF8String],
                                          kCCKeySizeDES,
                                          NULL,
                                          [textData bytes],
                                          dataLength,
                                          buffer,
                                          10240,    //预计密文的大小
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        cipherText = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"DES加密失败");
    }
    return cipherText;
}



/**
 解密
 @param cipherText 需要解密的字符串
 */
+ (NSString *)hhDecodeDesWithString:(NSString *)cipherText
{
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
//    const Byte iv[] = {1,2,3,4,5,6,7,8};
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionECBMode | kCCOptionPKCS7Padding,
                                          [DESKey UTF8String],
                                          kCCKeySizeDES,
                                          NULL,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}



//url编码
+ (NSString *)UrlValueEncode:(NSString *)str{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)str,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}


+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}





@end
