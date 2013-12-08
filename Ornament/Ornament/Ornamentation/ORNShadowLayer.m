//
//  ORNShadowLayer.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNShadow.h"
#import "ORNShadowLayer.h"

@implementation ORNShadowLayer
{
    CGFloat _radius;
}

static NSMutableDictionary *images;

#pragma mark NSObject

+ (void)initialize
{
    if (self == [ORNShadowLayer class]) {
        images = [NSMutableDictionary new];
    }
}

- (instancetype)init
{
    if (self = [super init]) {
        self.contentsCenter = (CGRect){.origin = {0.5f, 0.5f}};
        self.contentsScale = [UIScreen mainScreen].scale;
    }

    return self;
}

#pragma mark CALayer

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _radius = cornerRadius;
}

#pragma mark ORNColorable

- (void)colorInView:(UIView<ORNOrnamentable> *)view withOptions:(ORNOrnamentOptions)options, ...
{
    ORNShadow *shadow = (ORNShadow *)[view orn_ornamentWithOptions:options];

    CGFloat width = (_radius + shadow.blur + 2) * 2;
    NSString *key = [NSString stringWithFormat:@"%f%f%f%f%i%f%@", width, _radius, self.horizontalInset, self.verticalInset, self.roundedCorners, shadow.blur, shadow.color];
    UIImage *image = images[key];
    if (!image) {
        CGSize size = CGSizeMake(width, width);
        CGRect rect = {.size = size};
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);

        CGRect fillRect = CGRectInset(rect, -_radius, -_radius);
        CGFloat adjust = (self.roundedCorners & UIRectCornerBottomLeft) | (self.roundedCorners & UIRectCornerBottomRight) ? self.verticalInset : 0.0f;
        CGRect shadowRect = CGRectMake(rect.origin.x + self.horizontalInset, rect.origin.y + self.verticalInset, rect.size.width - self.horizontalInset * 2, rect.size.height - self.verticalInset - adjust);
        UIBezierPath *fillPath = [UIBezierPath bezierPathWithRect:fillRect];
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect byRoundingCorners:self.roundedCorners cornerRadii:CGSizeMake(_radius, _radius)];
        fillPath.usesEvenOddFillRule = YES;
        [fillPath appendPath:shadowPath];
        [shadowPath addClip];

        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetShadowWithColor(context, CGSizeZero, shadow.blur, shadow.color.CGColor);
        [[UIColor whiteColor] setFill];
        [fillPath fill];

        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        images[key] = image;
    }

    self.contents = (id)image.CGImage;
}

- (BOOL)needsRecoloringOnLayout
{
    return YES;
}

@end
