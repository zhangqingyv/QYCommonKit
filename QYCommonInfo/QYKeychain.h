//
//  QYKeychain.h
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/10.
//  Copyright © 2015年 terry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYKeychain : NSObject

+ (NSString *)bundleSeedID;

- (id)initWithService:(NSString *)service withGroup:(NSString *)group;
- (BOOL)insert:(NSString *)key data:(NSData *)data;
- (BOOL)update:(NSString *)key data:(NSData *)data;
- (BOOL)remove:(NSString *)key;
- (NSData *)find:(NSString *)key;

@end
