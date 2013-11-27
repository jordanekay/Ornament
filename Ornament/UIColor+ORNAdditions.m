//
//  UIColor+ORNAdditions.m
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNCaching.h"
#import "KGNoise.h"
#import "UIColor+ORNAdditions.h"

#define DEFAULT_PINSTRIPE_COLOR_1 [UIColor orn_colorWithHex:0xd6dae4]
#define DEFAULT_PINSTRIPE_COLOR_2 [UIColor orn_colorWithHex:0xd3d7e1]
#define DEFAULT_PINSTRIPE_WIDTH_1 5.0f
#define DEFAULT_PINSTRIPE_WIDTH_2 3.0f

@implementation UIColor (ORNAdditions)

ORN_CACHED_COLOR(orn_darkLinenColor, [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_linen"]]);
ORN_CACHED_COLOR(orn_lightLinenColor, [[UIColor whiteColor] orn_linenColor]);
ORN_CACHED_COLOR(orn_pinstripeColor, [UIColor orn_groupedTableViewBackgroundColorWithPinstripes:YES]);

+ (UIColor *)orn_colorWithHex:(NSUInteger)hex
{
    return [self orn_colorWithHex:hex alpha:1.0f];
}

+ (UIColor *)orn_colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha
{
    NSUInteger blue = hex & 0xff;
    NSUInteger green = (hex >> 8) & 0xff;
    NSUInteger red = (hex >> 16) & 0xff;
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.0f];
}

+ (UIColor *)orn_pinstripeColorWithColors:(NSArray *)colors stripeWidths:(NSArray *)stripeWidths
{
    CGFloat width = [[stripeWidths valueForKeyPath:@"@sum.self"] floatValue];
    CGSize size = CGSizeMake(width, width);
    __block CGFloat x = 0.0f;
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
    [colors enumerateObjectsUsingBlock:^(UIColor *color, NSUInteger index, BOOL *stop) {
        [color set];
        CGFloat stripeWidth = [stripeWidths[index] floatValue];
        CGRect rect = CGRectMake(x, 0.0f, stripeWidth, width);
        UIRectFill(rect);
        x += stripeWidth;
    }];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

+ (UIColor *)orn_groupedTableViewBackgroundColorWithPinstripes:(BOOL)pinstripes
{
    UIColor *color;
    if (pinstripes) {
        NSArray *colors = @[DEFAULT_PINSTRIPE_COLOR_1, DEFAULT_PINSTRIPE_COLOR_2];
        NSArray *stripeWidths = @[@DEFAULT_PINSTRIPE_WIDTH_1, @DEFAULT_PINSTRIPE_WIDTH_2];
        color = [UIColor orn_pinstripeColorWithColors:colors stripeWidths:stripeWidths];
    } else {
        color = DEFAULT_PINSTRIPE_COLOR_1;
    }
    return color;
}

- (UIColor *)orn_colorWithAlpha:(CGFloat)alpha
{
    CGFloat red, green, blue;
    [self getRed:&red green:&green blue:&blue alpha:NULL];
    if (red < 0.0f || green < 0.0f || blue < 0.0f) {
        red = green = blue = 1.0f;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIColor *)orn_colorWithBrightnessMultiplier:(CGFloat)multiplier
{
    UIColor *color;
    CGFloat hue, saturation, brightness, alpha;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness * multiplier alpha:alpha];
    } else {
        CGFloat white;
        if ([self getWhite:&white alpha:&alpha]) {
            color = [UIColor colorWithWhite:white * multiplier alpha:alpha];
        }
    }
    return color;
}

- (UIColor *)orn_linenColor
{
    UIColor *color;
    UIImage *image = [UIImage imageNamed:@"bg_linen1"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    UIView *overlayView = [[UIView alloc] initWithFrame:(CGRect){.size = image.size}];
    overlayView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
    [imageView addSubview:overlayView];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    color = [UIColor colorWithPatternImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    return color;
//    return [UIColor orn_darkLinenColor];
}

- (UIColor *)orn_colorWithNoise:(CGFloat)noise
{
    return [self colorWithNoiseWithOpacity:noise];
}

@end
