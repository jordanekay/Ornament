//
//  ORNNavigationBar.m
//  Ornament
//
//  Created by Jordan Kay on 11/28/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "NSArray+ORNFunctional.h"
#import "ORNGradientLayer.h"
#import "ORNNavigationBar.h"
#import "ORNNavigationBar.h"
#import "UIApplication+ORNStatusBar.h"
#import "UIColor+ORNAdditions.h"
#import "UIDevice+ORNVersion.h"
#import "UIFont+ORNSystem.h"

#define TITLE_FONT [UIFont orn_boldSystemFontOfSize:20.0f]
#define TITLE_TEXT_COLOR [UIColor whiteColor]
#define TITLE_TEXT_SHADOW_COLOR [UIColor colorWithWhite:0.0f alpha:0.6f]
#define TITLE_TEXT_SHADOW_OFFSET UIOffsetMake(0.0f, -1.0f)
#define TITLE_ADJUSTMENT ([UIDevice orn_isIOS7] ? 0.0f : -1.0f)

#define TINT_BORDER_COLOR(BLACK) BLACK ? 0xa0a8ac : 0xcdd5df
#define TINT_BACKGROUND_COLOR(BLACK) BLACK ? 0x727272 : 0xb3bfcf
#define TINT_SHADE_COLOR(BLACK) BLACK ? 0x212121 : 0x889bb3
#define BACKGROUND_COLOR(BLACK) BLACK ? 0x0 : 0x8195af
#define BACKGROUND_SHADE_COLOR(BLACK) BLACK ? 0x0 : 0x6d84a2
#define BORDER_COLOR(BLACK) BLACK ? 0x0 : 0x2d3642

#define ALPHA_TRANSLUCENT 0.6f
#define STATUS_BAR_COLOR [UIColor colorWithWhite:0.0f alpha:0.4f]
#define GRADIENT_LOCATIONS @[@0.0f, @0.02f, @0.5f, @0.5f, @0.98f, @1.0f]
#define GRADIENT_LOCATIONS_SIMPLE @[@0.0f, @0.05f, @0.98f, @1.0f]

@interface ORNNavigationBar ()

@property (nonatomic, readonly, getter = isBlackStyle) BOOL blackStyle;
@property (nonatomic, readonly, getter = isSimpleStyle) BOOL simpleStyle;
@property (nonatomic, readonly, getter = isTranslucentStyle) BOOL translucentStyle;

@end

@implementation ORNNavigationBar

@synthesize ornamentationStyle = _ornamentationStyle;
@synthesize ornamentationLayer = _ornamentationLayer;

- (BOOL)isBlackStyle
{
    return (self.ornamentationStyle == ORNNavigationBarStyleBlack || self.ornamentationStyle == ORNNavigationBarStyleBlackTranslucent);
}

- (BOOL)isSimpleStyle
{
    return (self.ornamentationStyle == ORNNavigationBarStyleBlueSimple);
}

- (BOOL)isTranslucentStyle
{
    return (self.ornamentationStyle == ORNNavigationBarStyleBlackTranslucent);
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.ornamentationLayer.frame = self.layer.bounds;
}

#pragma mark - ORNOrnamentable

- (void)ornament
{
    if ([UIDevice orn_isIOS7]) {
        self.barStyle = (self.isBlackStyle) ? UIBarStyleBlack : UIBarStyleDefault;
    } else {
        self.barStyle = UIBarStyleBlackTranslucent;
        [self setShadowImage:[UIImage new]];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
    }
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    ORNStatusBarStyle statusBarStyle;
    if (self.isBlackStyle) {
        statusBarStyle = (self.isTranslucentStyle) ? ORNStatusBarStyleLightContentTranslucent : ORNStatusBarStyleLightContent;
    } else {
        statusBarStyle = ([UIDevice orn_isIOS7]) ? ORNStatusBarStyleDefault : ORNStatusBarStyleLightContent;
    }
    [[UIApplication sharedApplication] orn_setStatusBarStyle:statusBarStyle];

    NSDictionary *appearanceAttributes = [UINavigationBar appearance].titleTextAttributes;
    UIFont *titleFont = appearanceAttributes[UITextAttributeFont] ?: TITLE_FONT;
    UIColor *titleTextColor = appearanceAttributes[UITextAttributeTextColor] ?: TITLE_TEXT_COLOR;
    UIColor *titleTextShadowColor = appearanceAttributes[UITextAttributeTextShadowColor] ?: TITLE_TEXT_SHADOW_COLOR;
    NSValue *titleTextShadowOffset = appearanceAttributes[UITextAttributeTextShadowOffset] ?: [NSValue valueWithUIOffset:TITLE_TEXT_SHADOW_OFFSET];
    self.titleTextAttributes = @{UITextAttributeFont: titleFont, UITextAttributeTextColor: titleTextColor, UITextAttributeTextShadowColor: titleTextShadowColor, UITextAttributeTextShadowOffset: titleTextShadowOffset};

    [self setTitleVerticalPositionAdjustment:TITLE_ADJUSTMENT forBarMetrics:UIBarMetricsDefault];
    [self.ornamentationLayer removeFromSuperlayer];
    [self.layer insertSublayer:self.ornamentationLayer atIndex:0];

    if (self.isSimpleStyle) {
        self.ornamentationLayer.locations = GRADIENT_LOCATIONS_SIMPLE;
        [self.ornamentationLayer colorInView:self withOptions:ORNOrnamentTypeTint | ORNOrnamentTypeBorder, ORNOrnamentTypeTint | ORNOrnamentTypeBackground, ORNOrnamentTypeBackground | ORNOrnamentTypeShade, ORNOrnamentTypeBorder, nil];
    } else {
        self.ornamentationLayer.locations = GRADIENT_LOCATIONS;
        [self.ornamentationLayer colorInView:self withOptions:ORNOrnamentTypeTint | ORNOrnamentTypeBorder, ORNOrnamentTypeTint | ORNOrnamentTypeBackground, ORNOrnamentTypeTint | ORNOrnamentTypeShade, ORNOrnamentTypeBackground, ORNOrnamentTypeBackground | ORNOrnamentTypeShade, ORNOrnamentTypeBorder, nil];
    }
}

- (ORNGradientLayer *)ornamentationLayer
{
    if (!_ornamentationLayer) {
        _ornamentationLayer = [ORNGradientLayer layer];
    }
    return (ORNGradientLayer *)_ornamentationLayer;
}

- (NSDictionary *)colorsForOptions
{
    BOOL black = self.isBlackStyle;
    ORN_CACHED_COLORS(ORNOrnamentTypeTint | ORNOrnamentTypeBorder, TINT_BORDER_COLOR(black), ORNOrnamentTypeTint | ORNOrnamentTypeShade, TINT_SHADE_COLOR(black), ORNOrnamentTypeTint | ORNOrnamentTypeBackground, TINT_BACKGROUND_COLOR(black), ORNOrnamentTypeBackground, BACKGROUND_COLOR(black), ORNOrnamentTypeBackground | ORNOrnamentTypeShade, BACKGROUND_SHADE_COLOR(black), ORNOrnamentTypeBorder, BORDER_COLOR(black));
}

- (NSArray *)colorsForOptionsList:(NSArray *)list
{
    CGFloat alpha = self.isTranslucentStyle ? ALPHA_TRANSLUCENT : 1.0f;
    NSArray *colors = [self.colorsForOptions objectsForKeys:list notFoundMarker:[NSNull null]];
    return [colors orn_mapWithBlock:^(UIColor *color, NSUInteger idx) {
        return [color orn_colorWithAlpha:alpha];
    }];
}

- (void)ornament:(ORNOrnament *)ornament withOptions:(ORNOrnamentOptions)options
{
    [self orn_ornament:ornament withOptions:options];
}

- (BOOL)isOrnamentedWithOptions:(ORNOrnamentOptions)options
{
    return [self orn_isOrnamentedWithOptions:options];
}

@end