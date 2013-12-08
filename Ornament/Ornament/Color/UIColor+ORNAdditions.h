//
//  UIColor+ORNAdditions.h
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNCaching.h"

@interface UIColor (ORNAdditions)

// Interface colors
+ (UIColor *)orn_pinstripeColor;
+ (UIColor *)orn_darkLinenColor;
+ (UIColor *)orn_lightLinenColor;

// Color utilities
+ (UIColor *)orn_colorWithHex:(NSUInteger)hex;
+ (UIColor *)orn_colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;
+ (UIColor *)orn_pinstripeColorWithColors:(NSArray *)colors stripeWidths:(NSArray *)stripeWidths;
+ (UIColor *)orn_groupedTableViewBackgroundColorWithPinstripes:(BOOL)pinstripes;

// Color transformations
- (UIColor *)orn_linenColor;
- (UIColor *)orn_colorWithAlpha:(CGFloat)alpha;
- (UIColor *)orn_colorWithNoise:(CGFloat)noise;
- (UIColor *)orn_colorWithBrightnessMultiplier:(CGFloat)multiplier;

@end
