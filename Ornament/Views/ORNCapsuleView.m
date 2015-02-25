//
//  ORNCapsuleView.m
//  Ornament
//
//  Created by Jordan Kay on 2/23/14.
//  Copyright (c) 2014 Jordan Kay. All rights reserved.
//

#import "ORNCapsuleView.h"
#import "ORNPath.h"

@interface ORNCapsuleView ()

@property (nonatomic, readonly) UIImage *backgroundImage;

@end

@implementation ORNCapsuleView
{
    NSCache *_backgroundImagesForSize;
}

@synthesize ornamentationStyle = _ornamentationStyle;

- (UIImage *)backgroundImage
{
    if (self.bounds.size.height == 0.0f || self.bounds.size.width == 0.0f) {
        return nil;
    }

    // Cached image for measurements
    CGFloat radius;
    UIEdgeInsets insets;
    [self orn_getOrnamentMeasurement:&radius position:&insets withOptions:ORNOrnamentTypeLayout];
    CGRect bounds = self.isResizable ? (CGRect){.size = {insets.left + insets.right + radius * 2, insets.top + insets.bottom + radius * 2}} : self.bounds;
    NSValue *key = [NSValue valueWithCGRect:bounds];
    UIImage *image = [_backgroundImagesForSize objectForKey:key];

    if (!image) {
        ORNPath *path;
        CGRect rect = UIEdgeInsetsInsetRect(bounds, insets);
        CGFloat borderWidth = 0.0f, strokeWidth = 0.0f;
        BOOL hasOuterShadow = [self isOrnamentedWithOptions:ORNOrnamentTypeShadow | ORNOrnamentPositionOutside];
        [self orn_getOrnamentMeasurement:&borderWidth position:NULL withOptions:ORNOrnamentTypeBorder];
        [self orn_getOrnamentMeasurement:&strokeWidth position:NULL withOptions:ORNOrnamentTypeStroke];
        UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();

        // Outer shadow
        if (hasOuterShadow) {
            CGFloat shadowRadius;
            UIEdgeInsets shadowInsets;
            [self orn_getOrnamentMeasurement:&shadowRadius position:&shadowInsets withOptions:ORNOrnamentTypeLayout | ORNOrnamentTypeShadow | ORNOrnamentPositionOutside];

            CGRect shadowRect = UIEdgeInsetsInsetRect(rect, shadowInsets);
            [self orn_setShadowInRect:shadowRect withStrokeRect:CGRectZero strokeWidth:0.0f radius:shadowRadius roundedCorners:self.roundedCorners options:ORNOrnamentPositionOutside withoutOptions:kNilOptions];
            path = [ORNPath pathWithRoundedRect:shadowRect corners:self.roundedCorners radius:shadowRadius];
            [path fill];
            CGContextRestoreGState(context);
        }

        // Stroke
        if (strokeWidth) {
            path = [ORNPath pathWithRoundedRect:rect corners:self.roundedCorners radius:radius];
            [path colorInView:self withOptions:ORNOrnamentTypeStroke, nil];
            rect = [self _rectFromRect:rect withInset:strokeWidth options:ORNOrnamentTypeStroke];
        }

        // Border
        if (borderWidth) {
            path = [ORNPath pathWithRoundedRect:rect corners:self.roundedCorners radius:radius];
            [path colorInView:self withOptions:ORNOrnamentTypeBorder, nil];
            rect = [self _rectFromRect:rect withInset:borderWidth options:ORNOrnamentTypeBorder];
        }

        path = [ORNPath pathWithRoundedRect:rect corners:self.roundedCorners radius:radius];
        if ([self isOrnamentedWithOptions:ORNOrnamentTypeShade]) {
            // Background and shade
            [path colorInView:self withOptions:ORNOrnamentTypeBackground, ORNOrnamentTypeShade, nil];
        } else {
            // Background
            [path colorInView:self withOptions:ORNOrnamentTypeBackground, nil];
        }

        // Inner shadow
        [self orn_setShadowInRect:rect withStrokeRect:rect strokeWidth:strokeWidth radius:radius roundedCorners:self.roundedCorners options:0 withoutOptions:ORNOrnamentPositionOutside];

        // Image
        image = UIGraphicsGetImageFromCurrentImageContext();
        [_backgroundImagesForSize setObject:image forKey:key];
        UIGraphicsEndImageContext();
    }

    return image;
}

- (CGRect)_rectFromRect:(CGRect)rect withInset:(CGFloat)inset options:(ORNOrnamentOptions)options
{
    UIEdgeInsets insets;
    BOOL top = [self orn_isOrnamentedWithOptions:options | ORNOrnamentPositionTop];
    BOOL bottom = [self orn_isOrnamentedWithOptions:options | ORNOrnamentPositionBottom];
    BOOL sides = [self orn_isOrnamentedWithOptions:options | ORNOrnamentPositionSides];
    BOOL allSides = !top && !bottom && !sides;
    insets.top = (top || allSides) ? inset : 0.0f;
    insets.bottom = (bottom || allSides) ? inset : 0.0f;
    insets.left = insets.right =  (sides || allSides) ? inset : 0.0f;
    return UIEdgeInsetsInsetRect(rect, insets);
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _backgroundImagesForSize = [[NSCache alloc] init];
        _resizable = YES;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if (!CGRectEqualToRect(self.frame, frame)) {
        [super setFrame:frame];
        if ((!self.isResizable || !self.image) && !CGRectEqualToRect(frame, CGRectZero)) {
            [self ornament];
        }
    }
}

#pragma mark - ORNOrnamentable

- (void)ornament
{
    self.image = self.backgroundImage;
}

- (void)ornament:(ORNOrnament *)ornament withOptions:(ORNOrnamentOptions)options
{
    [self orn_ornament:ornament withOptions:options];
}

- (BOOL)isOrnamentedWithOptions:(ORNOrnamentOptions)options
{
    return [self orn_isOrnamentedWithOptions:options];
}

- (NSArray *)colorsForOptionsList:(NSArray *)list
{
    return [self orn_colorsForOptionsList:list];
}

@end
