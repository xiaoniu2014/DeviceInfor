//
//  DeviceInfo.h
//  TTDataAnalytics
//
//  Created by zhuangzq on 15/4/30.
//  Copyright (c) 2015年 zhuangzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//设备类型
typedef enum {
    UIDeviceUnknown,
    UIDeviceSimulator,
    UIDeviceSimulatoriPhone,
    UIDeviceSimulatoriPad,
    UIDeviceSimulatorAppleTV,
    UIDevice1GiPhone,
    UIDevice3GiPhone,
    UIDevice3GSiPhone,
    UIDevice4iPhone,
    UIDevice4SiPhone,
    UIDevice5iPhone,
    UIDevice5SiPhone,
    UIDevice5CiPhone,
    UIDevice6PiPhone,
    UIDevice6iPhone,
    UIDevice1GiPod,
    UIDevice2GiPod,
    UIDevice3GiPod,
    UIDevice4GiPod,
    UIDevice5GiPod,
    UIDevice1GiPad,
    UIDevice2GiPad,
    UIDevice3GiPad,
    UIDevice4GiPad,
    UIDeviceMiniiPad,
    UIDevice5GiPad,
    UIDeviceMini2iPad,
    UIDeviceAppleTV2,
    UIDeviceAppleTV3,
    UIDeviceAppleTV4,
    UIDeviceUnknowniPhone,
    UIDeviceUnknowniPod,
    UIDeviceUnknowniPad,
    UIDeviceUnknownAppleTV,
    UIDeviceIFPGA,
} UIDevicePlatform;

#define IFPGA_NAMESTRING @"iFPGA"

#define IPHONE_1G_NAMESTRING @"iPhone 1G"
#define IPHONE_3G_NAMESTRING @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING @"iPhone 3GS"
#define IPHONE_4_NAMESTRING @"iPhone 4"
#define IPHONE_4S_NAMESTRING @"iPhone 4S"
#define IPHONE_5_NAMESTRING @"iPhone 5"
#define IPHONE_5S_NAMESTRING @"iPhone 5S"
#define IPHONE_5C_NAMESTRING @"iPhone 5C"
#define IPHONE_6P_NAMESTRING @"iPhone 6 Plus"
#define IPHONE_6_NAMESTRING @"iPhone 6"

#define IPHONE_UNKNOWN_NAMESTRING @"Unknown iPhone"

#define IPOD_1G_NAMESTRING @"iPod touch 1G"
#define IPOD_2G_NAMESTRING @"iPod touch 2G"
#define IPOD_3G_NAMESTRING @"iPod touch 3G"
#define IPOD_4G_NAMESTRING @"iPod touch 4G"
#define IPOD_5G_NAMESTRING @"iPod touch 5G"

#define IPOD_UNKNOWN_NAMESTRING @"Unknown iPod"

#define IPAD_1G_NAMESTRING @"iPad 1G"
#define IPAD_2G_NAMESTRING @"iPad 2G"
#define IPAD_3G_NAMESTRING @"iPad 3G"
#define IPAD_4G_NAMESTRING @"iPad 4G"
#define IPAD_5G_NAMESTRING @"iPad 5G"
#define IPAD_Mini_NAMESTRING @"iPad Mini";
#define IPAD_Mini2_NAMESTRING @"iPad Mini2"

#define IPAD_UNKNOWN_NAMESTRING @"Unknown iPad"

#define APPLETV_2G_NAMESTRING @"Apple TV 2G"
#define APPLETV_3G_NAMESTRING @"Apple TV 3G"
#define APPLETV_4G_NAMESTRING @"Apple TV 4G"
#define APPLETV_UNKNOWN_NAMESTRING @"Unknown Apple TV"

#define IOS_FAMILY_UNKNOWN_DEVICE @"Unknown iOS device"

#define SIMULATOR_NAMESTRING @"iPhone Simulator"
#define SIMULATOR_IPHONE_NAMESTRING @"iPhone Simulator"
#define SIMULATOR_IPAD_NAMESTRING @"iPad Simulator"
#define SIMULATOR_APPLETV_NAMESTRING @"Apple TV Simulator"

// check system version, make adapter for ios6 and 7
#define TT_IS_IOS8_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

#define TT_IS_IOS7_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

#define TT_IS_IOS6_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)

@interface DeviceInfo : NSObject
+ (NSString *)deviceModel;
+ (NSString *)deviceManufactory;
+ (NSString *)deviceFamilyType;
+ (NSString *)deviceResolution;
+ (NSString *)deviceNettype;
+ (NSString *)deviceCarrier;
+ (NSString *)deviceIp;
+ (NSString*)deviceIdentifer;
+ (NSString*)deviceSerialNumber;
#pragma mark - 钥匙串存储UUID
+ (NSString *)getKeychainIdentifier;
@end
