//
//  QYDeviceInfo.h
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/10.
//  Copyright © 2015年 terry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QYDeviceInfo : NSObject

//设备唯一标示
+ (NSString *)udid;
//ip地址
+ (NSString *)localIPAddress;
//系统版本
+ (NSString *)iosVersion;
//设备类型
+ (NSString *)iosModel;
//电池状态
+ (UIDeviceBatteryState)batteryState;
//设备大小
+ (NSString *)totalDiskspace;
//剩余空间
+ (NSString *)freeDiskspace;
//具体设备
+ (NSString *)machineType;
//设备的网络状态
+ (NSString *)networkDetailStatusDescription;
//是不是plus
+ (BOOL)isPlus;

@end
