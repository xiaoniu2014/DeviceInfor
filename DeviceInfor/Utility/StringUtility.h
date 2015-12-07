//
//  StringUtility.h
//  TTDataAnalytics
//
//  Created by zhuangzq on 15/4/30.
//  Copyright (c) 2015年 zhuangzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtility : NSObject
+ (NSString*)toJSONString:(id)jsonData;
+ (NSString*)formattedJSONStringWithString:(NSString*)originString;
+ (NSString*)MD5String:(NSString*)string;
+ (NSString*)createUUIDString;
/** 
 *判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;
@end
