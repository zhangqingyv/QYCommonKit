//
//  UIView+QYFrame.h
//  CommonKit Example
//
//  Created by Terry Zhang on 15/11/16.
//  Copyright © 2015年 terry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QYFrame)

+ (CGFloat)fullScreenWidth;
+ (CGFloat)fullScreenHeight;

- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGSize)size;

- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;
- (void)setTop:(CGFloat)top;
- (void)setBottom:(CGFloat)bottom;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)setOrigin:(CGPoint)point;
- (void)setSize:(CGSize)size;


@end
