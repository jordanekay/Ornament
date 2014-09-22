//
//  ORNPath.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <objc/runtime.h>
#import "NSArray+ORNFunctional.h"
#import "ORNOrnamentMacros.h"
#import "ORNPath.h"

@implementation ORNPath

@synthesize needsRecoloringOnLayout = _needsRecoloringOnLayout;

+ (instancetype)pathWithRect:(CGRect)rect
{
    UIBezierPath *path = [super bezierPathWithRect:rect];
    object_setClass(path, self);
    return (ORNPath *)path;
}

+ (instancetype)pathWithOvalInRect:(CGRect)rect
{
    UIBezierPath *path = [super bezierPathWithOvalInRect:rect];
    object_setClass(path, self);
    return (ORNPath *)path;
}

+ (instancetype)pathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius
{
    UIBezierPath *path = [super bezierPathWithRoundedRect:rect cornerRadius:radius];
    object_setClass(path, self);
    return (ORNPath *)path;
}

+ (instancetype)pathWithRoundedRect:(CGRect)rect corners:(UIRectCorner)corners radius:(CGFloat)radius
{
    UIBezierPath *path = [super bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    object_setClass(path, self);
    return (ORNPath *)path;
}

#pragma mark ORNColorable

- (void)colorInView:(UIView<ORNOrnamentable> *)view withOptions:(ORNOrnamentOptions)options, ...
{
    NSMutableArray *optionsList = [NSMutableArray array];
    ORN_MAKE_OPTIONS_LIST(optionsList, options);
    NSMutableArray *colors = [NSMutableArray arrayWithArray:[view colorsForOptionsList:optionsList]];

    NSUInteger count = [colors count];
    if (count == 1) {
        [[colors firstObject] setFill];
        [self fill];
    } else if (count == 2) {
        CGFloat locations[2] = {0.0f, 1.0f};
        CGPoint startPoint = self.bounds.origin;
        CGPoint endPoint = CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(self.bounds));
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        CFArrayRef colorRefs = (__bridge CFArrayRef)[colors orn_mapWithBlock:^(UIColor *color, NSUInteger idx) {
            return (__bridge id)color.CGColor;
        }];
        CGGradientRef gradient = CGGradientCreateWithColors(colorspace, colorRefs, locations);
        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextAddPath(context, self.CGPath);
        CGContextClip(context);
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kNilOptions);
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorspace);
    }
}

@end
