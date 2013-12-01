//
//  ORNNavigationBar.m
//  Ornament
//
//  Created by Jordan Kay on 11/28/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNGradientLayer.h"
#import "ORNNavigationBar.h"
#import "ORNNavigationBar.h"
#import "UIColor+ORNAdditions.h"
#import "UIDevice+ORNVersion.h"
#import "UIFont+ORNSystem.h"

#define TITLE_FONT [UIFont orn_boldSystemFontOfSize:20.0f]
#define TITLE_TEXT_COLOR [UIColor whiteColor]
#define TITLE_TEXT_SHADOW_COLOR [UIColor colorWithWhite:0.0f alpha:0.4f]
#define TITLE_TEXT_SHADOW_OFFSET UIOffsetMake(0.0f, -1.0f)

#define TINT_COLOR 0xcdd5df
#define TINT_SHADE_COLOR 0xb3bfcf
#define TINT_BACKGROUND_COLOR 0x889bb3
#define BACKGROUND_COLOR 0x8195af
#define BACKGROUND_SHADE_COLOR 0x6d84a2
#define BORDER_COLOR 0x2d3642

#define GRADIENT_LOCATIONS @[@0.0f, @0.05f, @0.5f, @0.5f, @0.98f, @1.0f]

@implementation ORNNavigationBar

@synthesize ornamentationStyle = _ornamentationStyle;
@synthesize ornamentationLayer = _ornamentationLayer;

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.ornamentationLayer.frame = self.layer.bounds;
}

#pragma mark - ORNOrnamentable

- (void)ornament
{
    self.barStyle = [UIDevice orn_isIOS7] ? UIBarStyleDefault : UIBarStyleBlack;
    self.titleTextAttributes = @{UITextAttributeFont: TITLE_FONT, UITextAttributeTextColor: TITLE_TEXT_COLOR, UITextAttributeTextShadowColor: TITLE_TEXT_SHADOW_COLOR, UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:TITLE_TEXT_SHADOW_OFFSET]};
    [self.layer addSublayer:self.ornamentationLayer];

    self.ornamentationLayer.locations = GRADIENT_LOCATIONS;
    [self.ornamentationLayer colorInView:self withOptions:ORNOrnamentTypeTint, ORNOrnamentTypeTint | ORNOrnamentTypeShade, ORNOrnamentTypeTint | ORNOrnamentTypeBackground, ORNOrnamentTypeBackground, ORNOrnamentTypeBackground | ORNOrnamentTypeShade, ORNOrnamentTypeBorder, nil];
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
    ORN_CACHED_COLORS(ORNOrnamentTypeTint, TINT_COLOR, ORNOrnamentTypeTint | ORNOrnamentTypeShade, TINT_SHADE_COLOR, ORNOrnamentTypeTint | ORNOrnamentTypeBackground, TINT_BACKGROUND_COLOR, ORNOrnamentTypeBackground, BACKGROUND_COLOR, ORNOrnamentTypeBackground | ORNOrnamentTypeShade, BACKGROUND_SHADE_COLOR, ORNOrnamentTypeBorder, BORDER_COLOR);
}

- (NSArray *)colorsForOptionsList:(NSArray *)list
{
    return  [self.colorsForOptions objectsForKeys:list notFoundMarker:[NSNull null]];
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
