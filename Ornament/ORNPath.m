//
//  ORNPath.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <objc/runtime.h>
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

#pragma mark ORNColorable

- (void)colorInView:(UIView<ORNOrnamentable> *)view withOptions:(ORNOrnamentOptions)options
{
    UIColor *color = [view orn_ornamentWithOptions:options].color;
    [color setFill];
    [self fill];
}

@end

