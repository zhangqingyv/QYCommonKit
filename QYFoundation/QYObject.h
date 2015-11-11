//
//  QYObject.h
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/11.
//  Copyright © 2015年 terry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

//----------------------IOS RunTime--------------------------
static inline void LKF_swizzleSelector(Class aClass, SEL originalSelector, SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
    if (class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

//----------------------IOS RunTime--------------------------

@interface QYObject : NSObject

@end
