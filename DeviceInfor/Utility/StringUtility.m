//
//  StringUtility.m
//  TTDataAnalytics
//
//  Created by zhuangzq on 15/4/30.
//  Copyright (c) 2015年 zhuangzq. All rights reserved.
//

#import "StringUtility.h"
#import <CommonCrypto/CommonHMAC.h>


@implementation StringUtility

+ (NSString*)MD5String:(NSString*)string
{
    // Borrowed from: http://stackoverflow.com/questions/652300/using-md5-hash-on-a-string-in-cocoa
    const char* cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

// 将字典或者数组转化为JSON Data
+ (NSString*)toJSONString:(id)jsonData
{
    NSError* error = nil;
    NSData * data = [NSJSONSerialization dataWithJSONObject:jsonData
                                                          options:NSJSONWritingPrettyPrinted
                                                            error:&error];
    
    NSString* jsonString = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}

// 被JSON Formatted 的字符串含有\n, 空格, 需要过滤处理
+ (NSString*)formattedJSONStringWithString:(NSString*)originString
{
    NSString* formatted = [originString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    formatted = [formatted stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    formatted = [formatted stringByReplacingOccurrencesOfString:@" " withString:@""];
    return formatted;
}

+ (NSString*)createUUIDString
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString* uuidString = CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    return uuidString;
}

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"null"])
    {
        return YES;
    }
    return NO;
}

@end
