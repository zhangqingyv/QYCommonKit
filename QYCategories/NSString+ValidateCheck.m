//
//  NSString+ValidateCheck.m
//  LSFoundation
//
//  Created by liulihui on 15/2/5.
//  Copyright (c) 2015年 liulihui. All rights reserved.
//

#import "NSString+ValidateCheck.h"

@implementation NSString (ValidateCheck)

- (BOOL)isValidateRegex:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isValidateMobileNumber
{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
    return [self isValidateRegex:regex];
}

- (BOOL)isValidateEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateRegex:regex];
}

@end
