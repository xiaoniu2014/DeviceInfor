//
//  DeviceInfo.m
//  TTDataAnalytics
//
//  Created by zhuangzq on 15/4/30.
//  Copyright (c) 2015年 zhuangzq. All rights reserved.
//

#import "DeviceInfo.h"
//系统头文件
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <mach/mach.h>
#import <sys/utsname.h>
#import <dlfcn.h>
@import CoreTelephony;
@import AdSupport;
//第三方代码
#import "TTDAReachability.h"
#import "TTDAIPAddress.h"
#import "TTDABase64.h"
//#import "StringUtility.h"
#import "KeychainItemWrapper.h"

@implementation DeviceInfo

+ (NSString*)deviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

+ (NSString*)deviceManufactory
{
    return @"Apple  瞎扯淡";
}

+ (NSString*)clientChannelId
{
#warning channelId需要设置
    return @"";//return [TTChannel sharedChannel].channelId;
}

+ (NSString*)clientBundleId
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString*)deviceNettype
{
    TTDAReachability* reachability =
    [TTDAReachability reachabilityForInternetConnection];
    TTDANetworkStatus currentStatus = reachability.currentReachabilityStatus;
    NSString* nettype = @"Unkown";
    switch (currentStatus) {
        case TTDANotReachable:
            nettype = @"NotReachable";
            break;
        case TTDAReachableViaWiFi:
            nettype = @"WiFi";
            break;
        case TTDAReachableViaWWAN:
            nettype = @"2/3/4G";
            break;
        default:
            break;
    }
    
    return nettype;
}

#pragma mark platform type and name utils
+ (NSUInteger)platformType
{
    NSString* platform = [self deviceModel];
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])
        return UIDeviceIFPGA;
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])
        return UIDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])
        return UIDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2,1"])
        return UIDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3,1"])
        return UIDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4,1"])
        return UIDevice4SiPhone;
    if ([platform hasPrefix:@"iPhone5,1"])
        return UIDevice5iPhone;
    if ([platform hasPrefix:@"iPhone5,2"])
        return UIDevice5iPhone;
    if ([platform hasPrefix:@"iPhone6,1"])
        return UIDevice5SiPhone;
    if ([platform hasPrefix:@"iPhone6,2"])
        return UIDevice5SiPhone;
    if ([platform hasPrefix:@"iPhone5,3"])
        return UIDevice5CiPhone;
    if ([platform hasPrefix:@"iPhone5,4"])
        return UIDevice5CiPhone;
    if ([platform hasPrefix:@"iPhone7,1"])
        return UIDevice6PiPhone;
    if ([platform hasSuffix:@"iPhone7,2"])
        return UIDevice6iPhone;
    if ([platform hasPrefix:@"iPod1,1"])
        return UIDevice1GiPod;
    if ([platform hasPrefix:@"iPod2,1"])
        return UIDevice2GiPod;
    if ([platform hasPrefix:@"iPod3,1"])
        return UIDevice3GiPod;
    if ([platform hasPrefix:@"iPod4,1"])
        return UIDevice4GiPod;
    if ([platform hasPrefix:@"iPod5,1"])
        return UIDevice5GiPod;
    
    // iPad
    if ([platform hasPrefix:@"iPad1,1"])
        return UIDevice1GiPad;
    if ([platform hasPrefix:@"iPad2,1"])
        return UIDevice2GiPad;
    if ([platform hasPrefix:@"iPad3,1"])
        return UIDevice3GiPad;
    if ([platform hasPrefix:@"iPad3,4"])
        return UIDevice4GiPad;
    if ([platform hasPrefix:@"iPad2,5"])
        return UIDeviceMiniiPad;
    if ([platform hasPrefix:@"iPad4,1"])
        return UIDevice5GiPad;
    if ([platform hasPrefix:@"iPad4,2"])
        return UIDevice5GiPad;
    if ([platform hasPrefix:@"iPad4,4"])
        return UIDeviceMini2iPad;
    if ([platform hasPrefix:@"iPad4,5"])
        return UIDeviceMini2iPad;
    
    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])
        return UIDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])
        return UIDeviceAppleTV3;
    
    if ([platform hasPrefix:@"iPhone"])
        return UIDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])
        return UIDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])
        return UIDeviceUnknowniPad;
    if ([platform hasPrefix:@"AppleTV"])
        return UIDeviceUnknownAppleTV;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"]) {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? UIDeviceSimulatoriPhone : UIDeviceSimulatoriPad;
    }
    
    return UIDeviceUnknown;
}

+ (NSString*)platformString
{
    switch ([self platformType]) {
        case UIDevice1GiPhone:
            return IPHONE_1G_NAMESTRING;
        case UIDevice3GiPhone:
            return IPHONE_3G_NAMESTRING;
        case UIDevice3GSiPhone:
            return IPHONE_3GS_NAMESTRING;
        case UIDevice4iPhone:
            return IPHONE_4_NAMESTRING;
        case UIDevice4SiPhone:
            return IPHONE_4S_NAMESTRING;
        case UIDevice5iPhone:
            return IPHONE_5_NAMESTRING;
        case UIDevice5SiPhone:
            return IPHONE_5S_NAMESTRING;
        case UIDevice5CiPhone:
            return IPHONE_5C_NAMESTRING;
        case UIDevice6PiPhone:
            return IPHONE_6P_NAMESTRING;
        case UIDevice6iPhone:
            return IPHONE_6_NAMESTRING;
            
        case UIDeviceUnknowniPhone:
            return IPHONE_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPod:
            return IPOD_1G_NAMESTRING;
        case UIDevice2GiPod:
            return IPOD_2G_NAMESTRING;
        case UIDevice3GiPod:
            return IPOD_3G_NAMESTRING;
        case UIDevice4GiPod:
            return IPOD_4G_NAMESTRING;
        case UIDevice5GiPod:
            return IPOD_5G_NAMESTRING;
            
        case UIDeviceUnknowniPod:
            return IPOD_UNKNOWN_NAMESTRING;
            
        case UIDevice1GiPad:
            return IPAD_1G_NAMESTRING;
        case UIDevice2GiPad:
            return IPAD_2G_NAMESTRING;
        case UIDevice3GiPad:
            return IPAD_3G_NAMESTRING;
        case UIDevice4GiPad:
            return IPAD_4G_NAMESTRING;
        case UIDevice5GiPad:
            return IPAD_5G_NAMESTRING;
        case UIDeviceMini2iPad:
            return IPAD_Mini2_NAMESTRING;
        case UIDeviceMiniiPad:
            return IPAD_Mini_NAMESTRING;
            
        case UIDeviceUnknowniPad:
            return IPAD_UNKNOWN_NAMESTRING;
            
        case UIDeviceAppleTV2:
            return APPLETV_2G_NAMESTRING;
        case UIDeviceAppleTV3:
            return APPLETV_3G_NAMESTRING;
        case UIDeviceAppleTV4:
            return APPLETV_4G_NAMESTRING;
        case UIDeviceUnknownAppleTV:
            return APPLETV_UNKNOWN_NAMESTRING;
            
        case UIDeviceSimulator:
            return SIMULATOR_NAMESTRING;
        case UIDeviceSimulatoriPhone:
            return SIMULATOR_IPHONE_NAMESTRING;
        case UIDeviceSimulatoriPad:
            return SIMULATOR_IPAD_NAMESTRING;
        case UIDeviceSimulatorAppleTV:
            return SIMULATOR_APPLETV_NAMESTRING;
            
        case UIDeviceIFPGA:
            return IFPGA_NAMESTRING;
            
        default:
            return IOS_FAMILY_UNKNOWN_DEVICE;
    }
}

+ (NSString*)deviceFamilyType
{
    NSString* platformString = [self platformString];
//    TTDEBUGLOG(@"plat form string %@", platformString);
    platformString = [platformString ttda_base64EncodedString];
    
    return platformString;
}

+ (NSString*)deviceCarrier
{
    CTTelephonyNetworkInfo* netInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier* carrier = [netInfo subscriberCellularProvider];
    NSString* cellularProviderName = [[carrier carrierName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (cellularProviderName != nil) {
        return cellularProviderName;
    } else {
        return @"0";
    }
}

+ (NSString*)deviceSerialNumber
{
    NSString* serialNumber = nil;
    
    void* IOKit = dlopen("/System/Library/Frameworks/IOKit.framework/IOKit", RTLD_NOW);
    if (IOKit) {
        mach_port_t* kIOMasterPortDefault = dlsym(IOKit, "kIOMasterPortDefault");
        CFMutableDictionaryRef (*IOServiceMatching)(const char* name) = dlsym(IOKit, "IOServiceMatching");
        mach_port_t (*IOServiceGetMatchingService)(mach_port_t masterPort, CFDictionaryRef matching) = dlsym(IOKit, "IOServiceGetMatchingService");
        CFTypeRef (*IORegistryEntryCreateCFProperty)(mach_port_t entry, CFStringRef key, CFAllocatorRef allocator, uint32_t options) = dlsym(IOKit, "IORegistryEntryCreateCFProperty");
        kern_return_t (*IOObjectRelease)(mach_port_t object) = dlsym(IOKit, "IOObjectRelease");
        
        if (kIOMasterPortDefault && IOServiceGetMatchingService && IORegistryEntryCreateCFProperty && IOObjectRelease) {
            mach_port_t platformExpertDevice = IOServiceGetMatchingService(*kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
            if (platformExpertDevice) {
                CFTypeRef platformSerialNumber = IORegistryEntryCreateCFProperty(platformExpertDevice, CFSTR("IOPlatformSerialNumber"), kCFAllocatorDefault, 0);
                
                //fix bug for iOS8 Eas0n 20140809
                if (TT_IS_IOS8_AND_UP) {
                    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
                        serialNumber = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                    } else {
                        serialNumber = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
                    }
                } else {
                    if (CFGetTypeID(platformSerialNumber) == CFStringGetTypeID()) {
                        serialNumber = [NSString stringWithString:(__bridge NSString*)platformSerialNumber];
                        CFRelease(platformSerialNumber);
                    }
                    IOObjectRelease(platformExpertDevice);
                }
            }
        }
        dlclose(IOKit);
    }
    
    if (serialNumber == nil) {
        serialNumber = @"C02LH0UPFFRP"; // if get error return simulator serail
    }
    
    return serialNumber;
}

#pragma mark MAC addy
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+ (NSString*)macaddress
{
    int mib[6];
    size_t len;
    char* buf;
    unsigned char* ptr;
    struct if_msghdr* ifm;
    struct sockaddr_dl* sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Error: Memory allocation error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2\n");
        free(buf); // Thanks, Remy "Psy" Demerest
        return NULL;
    }
    
    ifm = (struct if_msghdr*)buf;
    sdl = (struct sockaddr_dl*)(ifm + 1);
    ptr = (unsigned char*)LLADDR(sdl);
    NSString* outstring = [NSString
                           stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr + 1),
                           *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
    
    free(buf);
    return outstring;
}

+ (NSString *)deviceIDFA{
    
    if (TT_IS_IOS6_AND_UP) {
        NSString *idfa= [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        if (idfa == nil) {
            return @"2107713D-4D49-4316-8EB8-D952B1828E38";// if get error return simulator serail
        }
        return idfa;
    } else {
        return [DeviceInfo macaddress];
    }
}

+ (NSString *)deviceIdfv{
    if (TT_IS_IOS6_AND_UP){
        NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        if (idfv==nil) {
            idfv =@" ";
        }
        return idfv;
    }else{
        return @" ";
    }
}

+ (NSString *)deviceUUID{
    
    NSString *UUID=@" ";
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    if (cfuuidString ==nil) {
        return UUID;
    }else{
        return  cfuuidString;
    }
    
}
///屏幕分辨率
+ (NSString *)deviceResolution
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    NSString *resolutionString = [NSString stringWithFormat:@"%@*%@",@(screenSize.width * scale),@(screenSize.height * scale)];
    return resolutionString;
}

+ (NSString *)deviceIp
{
    return [TTDAIPAddress deviceIPAddress];
}

+ (NSString*)deviceIdentifer
{
    if (TT_IS_IOS7_AND_UP) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    } else {
        return [DeviceInfo macaddress];
    }
}


#pragma mark - 钥匙串存储UUID
+ (NSString *)getKeychainIdentifier
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"deviceIdentifier" accessGroup:nil];
    NSString *uniqueIdentifier = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
    if ([uniqueIdentifier isEqualToString:@""]) {
        [wrapper setObject:getuuid() forKey:(__bridge id)kSecAttrAccount];
    }
    uniqueIdentifier = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
    return uniqueIdentifier;
}
#pragma mark - 获取UUID
NSString * getuuid()
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

@end
