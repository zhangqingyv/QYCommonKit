//
//  QYAppInfo.m
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/10.
//  Copyright © 2015年 terry. All rights reserved.
//

#import "QYAppInfo.h"

@implementation QYAppInfo

+ (NSString *)appBundle
{
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    return identifier;
}

+ (NSString *)appName
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    return appName;
}

+ (NSString *)appVersion {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!appVersion || [appVersion length] == 0) {
        appVersion = @"0.0";
    }
    return appVersion;
}

+ (NSString *)appBuild
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if (!appVersion || [appVersion length] == 0) {
        appVersion = @"0.0";
    }
    return appVersion;
}

//app渠道信息
+ (NSString *)appChannelID
{
    
    NSString *configPlistPath = [[NSBundle mainBundle]pathForResource:@"channel" ofType:@"plist"];
    NSDictionary *config = [[NSDictionary alloc]initWithContentsOfFile:configPlistPath];
    NSString *channelId = config[@"channelId"];
    if (!channelId) {
        channelId = @"未设置";
    }
    return channelId;
}


+ (NSString *)appVersionNumber
{
    NSString *appV = [QYAppInfo appVersion];
    char c;
    for (int i = 0; i < [appV length]; ++ i) {
        c = [appV characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            appV = [appV substringFromIndex:i];
            break;
        }
    }
    
    for (int i = (int)[appV length] - 1; i >= 0; -- i) {
        c = [appV characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            appV = [appV substringToIndex:i+1];
            break;
        }
    }
    
    return appV;
}

@end
