//
//  ORNOrnament.m
//  Ornament
//
//  Created by Jordan Kay on 7/24/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <objc/runtime.h>
#import "ORNColorable.h"
#import "ORNLayout.h"
#import "ORNLine.h"
#import "ORNOrnament.h"
#import "ORNShadow.h"

#define MIN_SHADOW_RADIUS 2.0f

@interface ORNOrnament ()

- (void)getMeasurement:(CGFloat *)measurement position:(ORNPosition *)position;

@property (nonatomic) UIColor *color;

@end

@implementation ORNOrnament

const ORNPosition ORNPositionCentered = (ORNPosition){};

+ (instancetype)ornamentWithColor:(UIColor *)color
{
    ORNOrnament *ornament = [ORNOrnament new];
    ornament.color = color;
    return ornament;
}

+ (instancetype)layoutWithInsets:(UIEdgeInsets)insets
{
    return [self layoutWithInsets:insets radius:0.0f];
}

+ (instancetype)layoutWithInsets:(UIEdgeInsets)insets radius:(CGFloat)radius
{
    ORNLayout *layout = [ORNLayout new];
    layout.insets = insets;
    layout.radius = radius;
    return layout;
}

+ (instancetype)shadowWithColor:(UIColor *)color blur:(CGFloat)blur
{
    return [self shadowWithColor:color blur:blur position:ORNPositionCentered];
}

+ (instancetype)shadowWithColor:(UIColor *)color blur:(CGFloat)blur position:(ORNPosition)position
{
    ORNShadow *shadow = [ORNShadow new];
    shadow.color = color;
    shadow.blur = blur;
    shadow.position = position;
    return shadow;
}

+ (instancetype)lineWithColor:(UIColor *)color
{
    return [self lineWithColor:color width:[self defaultLineWidth]];
}

+ (instancetype)lineWithColor:(UIColor *)color width:(CGFloat)width
{
    ORNLine *line = [ORNLine new];
    line.color = color;
    line.width = width;
    return line;
}

+ (CGFloat)defaultCornerRadius
{
    return 0.0f;
}

+ (CGFloat)defaultLineWidth
{
    return 1.0f;
}

- (void)getMeasurement:(CGFloat *)measurement position:(ORNPosition *)position
{
    return;
}

ORNPosition ORNPositionMake(CGFloat horizontal, CGFloat vertical)
{
    ORNPosition position = UIEdgeInsetsMake(vertical, horizontal, 0.0f, 0.0f);
    return position;
}

@end

#pragma mark -

@implementation UIView (ORNOrnament)

- (void)orn_ornament:(ORNOrnament *)ornament withOptions:(ORNOrnamentOptions)options
{
    if ([self conformsToProtocol:@protocol(ORNOrnamentable)]) {
        if (!(options & ORNOrnamentStateDefault) && !(options & ORNOrnamentStateHighlighted)) {
            options |= ORNOrnamentStateDefault | ORNOrnamentStateHighlighted;
        }

        options |= ornament.implicitOptions;
        [self _ornaments][@(options)] = ornament;
    }
}

- (BOOL)orn_isOrnamentedWithOptions:(ORNOrnamentOptions)options
{
    if ([self conformsToProtocol:@protocol(ORNOrnamentable)]) {
        return ([self orn_ornamentWithOptions:options] != nil);
    }
    return NO;
}

- (NSArray *)orn_colorsForOptionsList:(NSArray *)list
{
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:[list count]];
    for (NSNumber *value in list) {
        ORNOrnamentOptions options = [value unsignedIntegerValue];
        UIColor *color = [self orn_ornamentWithOptions:options].color;
        if (color) {
            [colors addObject:color];
        }
    }
    return colors;
}

- (void)orn_setShadowInRect:(CGRect)rect withStrokeRect:(CGRect)strokeRect strokeWidth:(CGFloat)strokeWidth radius:(CGFloat)radius roundedCorners:(UIRectCorner)corners options:(ORNOrnamentOptions)options withoutOptions:(ORNOrnamentOptions)withoutOptions
{
    options |= ORNOrnamentTypeShadow;
    withoutOptions |= ORNOrnamentTypeLayout;
    ORNShadow *shadow = (ORNShadow *)[self orn_ornamentWithOptions:options withoutOptions:withoutOptions];
    if (shadow) {
        if (options & ORNOrnamentPositionOutside) {
            // Zero-blur supported section shadow
            if (shadow.blur == 0.0f) {
                // With zero blur, just offset a background behind it by the shadow offset
                rect = CGRectOffset(rect, shadow.position.left, shadow.position.top);
                UIBezierPath *shadowPath = (radius == MIN_SHADOW_RADIUS) ? [UIBezierPath bezierPathWithRect:rect] : [UIBezierPath bezierPathWithOvalInRect:rect];
                [shadow.color setFill];
                [shadowPath fill];
            } else {
                // Otherwise set shadow normally
                CGContextRef context = UIGraphicsGetCurrentContext();
                CGSize offset = CGSizeMake(shadow.position.left, shadow.position.top);
                CGContextSaveGState(context);
                CGContextSetShadowWithColor(context, offset, shadow.blur, shadow.color.CGColor);
            }
        } else {
            // Form inner shadow by appending a path to fill around then clip to
            CGFloat inset = ([self orn_isOrnamentedWithOptions:ORNOrnamentPositionSides]) ? 0.0f : -(shadow.blur - strokeWidth);
            CGRect fillRect = CGRectInset(strokeRect, -radius, -radius);
            CGRect shadowRect = CGRectInset(rect, inset, 0.0f);
            CGSize radii = CGSizeMake(radius, radius);
            UIBezierPath *fillPath = corners ? [UIBezierPath bezierPathWithRoundedRect:fillRect byRoundingCorners:corners cornerRadii:radii] : [UIBezierPath bezierPathWithRect:fillRect];
            UIBezierPath *shadowPath = corners ? [UIBezierPath bezierPathWithRoundedRect:shadowRect byRoundingCorners:corners cornerRadii:radii] : [UIBezierPath bezierPathWithOvalInRect:shadowRect];
            UIBezierPath *shadowClipPath = corners ? [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii] : [UIBezierPath bezierPathWithOvalInRect:rect];
            fillPath.usesEvenOddFillRule = YES;
            [fillPath appendPath:shadowPath];
            [shadowClipPath addClip];
            
            // Clip inner shadow for positions
            if (!([self orn_isOrnamentedWithOptions:ORNOrnamentPositionTop])) {
                CGRect clipRect = fillRect;
                clipRect.origin.y += floorf(clipRect.size.height / 2);
                clipRect.size.height -= floorf(clipRect.size.height / 2);
                UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:clipRect];
                [clipPath addClip];
            }
            if (!([self orn_isOrnamentedWithOptions:ORNOrnamentPositionBottom])) {
                CGRect clipRect = fillRect;
                clipRect.size.height = floorf(clipRect.size.height / 2) + 1.0f;
                UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:clipRect];
                [clipPath addClip];
            }
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetShadowWithColor(context, CGSizeZero, shadow.blur, shadow.color.CGColor);
            [[UIColor blackColor] setFill];
            [fillPath fill];
        }
    }
}

- (void)orn_getOrnamentMeasurement:(CGFloat *)measurement position:(ORNPosition *)position withOptions:(ORNOrnamentOptions)options
{
    if (![self conformsToProtocol:@protocol(ORNOrnamentable)]) {
        return;
    }
    
    ORNOrnament *ornament = [self orn_ornamentWithOptions:options];
    [ornament getMeasurement:measurement position:position];
}

- (NSMutableDictionary *)_ornaments
{
    if (![self conformsToProtocol:@protocol(ORNOrnamentable)]) {
        return nil;
    }
    
    NSMutableDictionary *ornaments = objc_getAssociatedObject(self, _cmd);
    if (!ornaments) {
        ornaments = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, ornaments, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ornaments;
}

- (ORNOrnament *)orn_ornamentWithOptions:(ORNOrnamentOptions)options
{
    __block ORNOrnament *ornament;
    [[self _ornaments] enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, ORNOrnament *object, BOOL *stop) {
        NSUInteger keyValue = [key unsignedIntegerValue];
        if ((keyValue & options) == options) {
            ornament = object;
            *stop = YES;
        }
    }];
    return ornament;
}

- (ORNOrnament *)orn_ornamentWithOptions:(ORNOrnamentOptions)withOptions withoutOptions:(ORNOrnamentOptions)withoutOptions
{
    __block ORNOrnament *ornament;
    [[self _ornaments] enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, ORNOrnament *object, BOOL *stop) {
        NSUInteger keyValue = [key unsignedIntegerValue];
        if ((keyValue & withOptions) == withOptions && !(keyValue & withoutOptions)) {
            ornament = object;
            *stop = YES;
        }
    }];
    return ornament;
}

@end
