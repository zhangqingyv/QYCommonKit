//
//  QYUDIDHelper.h
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/10.
//  Copyright © 2015年 terry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYUDIDHelper : NSObject

@property (nonatomic, copy, readonly) NSString *udid;
@property (nonatomic, copy, readonly) NSString *appBundleName;

+ (instancetype)sharedInstance;

@end
