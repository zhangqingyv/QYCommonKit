//
//  NSString+Sha1.m
//  CommonKit Example
//
//  Created by 白开水_孙 on 8/3/15.
//  Copyright © 2015 liulihui. All rights reserved.
//

#import "NSString+Sha1.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Sha1)

- (NSString *)sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end
