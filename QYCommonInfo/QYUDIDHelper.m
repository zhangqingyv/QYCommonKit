//
//  QYUDIDHelper.m
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/10.
//  Copyright © 2015年 terry. All rights reserved.
//

#import "QYUDIDHelper.h"
#import "QYKeychain.h"
#import <UIKit/UIKit.h>

static NSString *serviceName = @"me.Terry";
static NSString *udidName = @"QYGroupsUDID";
static NSString *pasteboardType = @"QYGroupsContent";
static NSString *groupName = @"me.Terry.*";

@interface QYUDIDHelper ()

@property (nonatomic, strong) QYKeychain *myKeyChain;
@property (nonatomic, copy) NSString *udid;
@property (nonatomic, copy) NSString *appBundleName;

@property (nonatomic, strong) NSString *kServiceName;
@property (nonatomic, strong) NSString *kUDIDName;
@property (nonatomic, strong) NSString *kGroupName;
@property (nonatomic, strong) NSString *kPasteboardType;

@end

@implementation QYUDIDHelper

#pragma mark - Public Method

+ (instancetype)sharedInstance
{
    static QYUDIDHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [QYUDIDHelper alloc];
    });
    return instance;
}

- (NSString *)udid
{
    if (_udid) {
        _udid = [self getMyUDID];
    }
    return _udid;
}

- (NSString *)appBundleName
{
    if (!_appBundleName) {
        NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
        NSArray *components = [identifier componentsSeparatedByString:@"."];
        if (components.count > 2) {
            _appBundleName = [components objectAtIndex:2];
        } else {
            _appBundleName = @"";
        }
    }
    return _appBundleName;
}


#pragma mark - Private Method
- (NSString *)getMyUDID
{
    NSString *udid = nil;
    NSData *udidData = [self.myKeyChain find:self.kUDIDName];
    if (!udidData) {
        udid = [self createUDID];
        [self saveUDID:udid];
    } else {
        NSString *temp = [[NSString alloc] initWithData:udidData encoding:NSUTF8StringEncoding];
        udid = [NSString stringWithFormat:@"%@", temp];
    }
    if (udid.length == 0) {
        udid = [self readPasteBoradforIdentifier:self.kUDIDName];
    }
    return udid;
}

- (NSString *)createUDID
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    
    NSString *udid = (__bridge NSString *)string;
    udid = [udid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(string);
    return udid;
}

- (void)saveUDID:(NSString *)udid
{
    BOOL saveOk = NO;
    NSData *udidData = [self.myKeyChain find:self.kUDIDName];
    if (udidData == nil) {
        saveOk = [self.myKeyChain insert:self.kUDIDName data:[self changeStringToData:udid]];
    }else{
        saveOk = [self.myKeyChain update:self.kUDIDName data:[self changeStringToData:udid]];
    }
    if (!saveOk) {
        [self createPasteBoradValue:udid forIdentifier:self.kUDIDName];
    }
}

- (NSData *)changeStringToData:(NSString *)str
{
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)createPasteBoradValue:(NSString *)value forIdentifier:(NSString *)identifier
{
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:self.kServiceName create:YES];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:value forKey:identifier];
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [pb setData:dictData forPasteboardType:self.kPasteboardType];
}

- (NSString *)readPasteBoradforIdentifier:(NSString *)identifier
{
    
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:self.kServiceName create:YES];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[pb dataForPasteboardType:self.kPasteboardType]];
    return [dict objectForKey:identifier];
}

#pragma mark - Init Property
- (QYKeychain *)myKeyChain
{
    if (!_myKeyChain) {
        _myKeyChain = [[QYKeychain alloc] initWithService:self.kServiceName withGroup:self.kGroupName];
    }
    return _myKeyChain;
}

- (NSString *)kServiceName
{
    return serviceName;
}

- (NSString *)kUDIDName
{
    return udidName;
}

- (NSString *)kPasteboardType
{
    return pasteboardType;
}

- (NSString *)kGroupName
{
    return groupName;
}

@end
