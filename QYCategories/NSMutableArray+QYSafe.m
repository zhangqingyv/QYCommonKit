//
//  NSMutableArray+QYSafe.m
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/11.
//  Copyright © 2015年 terry. All rights reserved.
//

#import "NSMutableArray+QYSafe.h"
#import "QYObject.h"

@implementation NSMutableArray (QYSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector];
    });
}

+ (void)swizzleSelector
{
    LKF_swizzleSelector([self class], @selector(setObject:atIndexedSubscript:), @selector(LKF_setObject:atIndexedSubscript:));
}

/**
 *  超载下标赋值操作,release版本中存入nil、越界不报错
 *
 *  @param obj 需要设置的值
 *  @param idx index
 */
- (void)LKF_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (!obj) {
#ifdef DEBUG
        [NSException raise:NSRangeException format:@"*** -[%@ setObject:atIndex:]: object cannot be nil", NSStringFromClass([self class])];
#endif
        return;
    }
    if (idx > self.count) {
#ifdef DEBUG
        [NSException raise:NSRangeException format:@"*** -[%@ setObject:atIndex:]: index %lu beyond bounds for array %@", NSStringFromClass([self class]), (unsigned long)idx, self];
#endif
        return;
    }
    
    return [self LKF_setObject:obj atIndexedSubscript:idx];
}

@end
