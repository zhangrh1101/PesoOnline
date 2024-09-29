//
//  DESCode.h
//  CTFreightLoan
//
//  Created by 楚天小贷 on 2019/1/11.
//  Copyright © 2019年 Zzzzzzzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DESCode : NSObject
/**
 加密
 @param plainText 需要加密的字符串
 */
+ (NSString *)hhEncodeDesWithString:(NSString *)plainText;

/**
 解密
 @param cipherText 需要解密的字符串
*/
+ (NSString *)hhDecodeDesWithString:(NSString *)cipherText;


@end


NS_ASSUME_NONNULL_END
