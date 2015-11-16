//
//  UIColor+QYHex.m
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/16.
//  Copyright © 2015年 terry. All rights reserved.
//

#import "UIColor+QYHex.h"

@implementation UIColor (QYHex)

+ (UIColor *)colorWithHex:(uint) hex alpha:(CGFloat)alpha
{
    int red, green, blue;
    
    blue = hex & 0x0000FF;
    green = ((hex & 0x00FF00) >> 8);
    red = ((hex & 0xFF0000) >> 16);
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

@end
