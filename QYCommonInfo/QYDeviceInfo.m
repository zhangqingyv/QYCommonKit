//
//  QYDeviceInfo.m
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/10.
//  Copyright © 2015年 terry. All rights reserved.
//

#import "QYDeviceInfo.h"
#import "QYUDIDHelper.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <sys/utsname.h>

typedef NS_ENUM(NSUInteger, LKNetworkDetailStatus)
{
    LKNetworkDetailStatusNone,
    LKNetworkDetailStatus2G,
    LKNetworkDetailStatus3G,
    LKNetworkDetailStatus4G,
    LKNetworkDetailStatusLTE,
    LKNetworkDetailStatusWIFI,
    LKNetworkDetailStatusUnknown
};

@implementation QYDeviceInfo

+ (NSString *)udid
{
    return [[QYUDIDHelper sharedInstance] udid];
}

+ (NSString *)hostname
{
    char baseHostName[256]; // Thanks, Gunnar Larisch
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    baseHostName[255] = '\0';
    
#if TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s", baseHostName];
#else
    return [NSString stringWithFormat:@"%s.local", baseHostName];
#endif
}

+ (NSString *)localIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)iosVersion {
    UIDevice *device = [UIDevice currentDevice];
    return [device systemVersion];
}

+ (NSString *)iosModel {
    UIDevice *device = [UIDevice currentDevice];
    return [device model];
}

+ (NSString *)freeDiskspace {
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    }
    
    return [NSString stringWithFormat:@"%llu", ((totalFreeSpace/1024ll)/1024ll)];
}

+ (NSString *)totalDiskspace {
    uint64_t totalSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
    }
    
    return [NSString stringWithFormat:@"%llu", ((totalSpace/1024ll)/1024ll)];
}

+ (UIDeviceBatteryState)batteryState {
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    
    return [[UIDevice currentDevice] batteryState];
}

+ (NSString *)machineType;
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return machineType;
}

+ (LKNetworkDetailStatus)networkDetailStatus
{
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetworkItemView = nil;
    
    if (subviews) {
        for (id subview in subviews) {
            if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
                dataNetworkItemView = subview;
                break;
            }
        }
    }
    
    LKNetworkDetailStatus status = LKNetworkDetailStatusUnknown;
    if (!dataNetworkItemView) {
        return status;
    }
    
    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"]integerValue]) {
        case 0:
            status = LKNetworkDetailStatusNone;
            break;
        case 1:
            status = LKNetworkDetailStatus2G;
            break;
        case 2:
            status = LKNetworkDetailStatus3G;
            break;
        case 3:
            status = LKNetworkDetailStatus4G;
            break;
        case 4:
            status = LKNetworkDetailStatusLTE;
            break;
        case 5:
            status = LKNetworkDetailStatusWIFI;
            break;
        default:
            break;
    }
    return status;
}

+ (NSString *)networkDetailStatusDescription
{
    NSString *desc = @"";
    switch ([QYDeviceInfo networkDetailStatus]) {
        case LKNetworkDetailStatusWIFI:
            desc = @"WIFI";
            break;
            
        case LKNetworkDetailStatus2G:
            desc = @"2G";
            break;
            
        case LKNetworkDetailStatus3G:
            desc = @"3G";
            break;
            
        case LKNetworkDetailStatus4G:
            desc = @"4G";
            break;
            
        case LKNetworkDetailStatusLTE:
            desc = @"LTE";
            break;
            
        case LKNetworkDetailStatusUnknown:
            desc = @"unknown";
            break;
        case LKNetworkDetailStatusNone:
            desc = @"none";
            break;
            
        default:
            desc = @"";
            break;
    }
    
    return desc;
}

+ (BOOL)isPlus
{
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    return (width == 414.0);
}

@end
