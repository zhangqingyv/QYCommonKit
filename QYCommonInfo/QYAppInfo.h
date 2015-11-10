//
//  QYAppInfo.h
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/10.
//  Copyright © 2015年 terry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYAppInfo : NSObject

//appBundle信息
+ (NSString *)appBundle;
//app 显示名称
+ (NSString *)appName;
//app版本
+ (NSString *)appVersion;
//appBuild版本
+ (NSString *)appBuild;
//app渠道信息
+ (NSString *)appChannelID;

@end
