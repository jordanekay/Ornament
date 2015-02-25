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
#import "UIImage+ORNAdditions.h"

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

#define BAR_BUTTON_CONTENT_INSETS UIEdgeInsetsMake(0.0f, 8.0f, 0.0f, 8.0f)

@interface ORNNavigationBar ()

@property (nonatomic, readonly, getter = isBlackStyle) BOOL blackStyle;
@property (nonatomic, readonly, getter = isSimpleStyle) BOOL simpleStyle;

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

- (void)_setupStatusBar
{
    if (![UIDevice orn_isIOS7]) {
        [self setShadowImage:[UIImage new]];
    }
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    ORNStatusBarStyle statusBarStyle;
    if (self.isBlackStyle) {
        statusBarStyle = (self.isTranslucentStyle) ? ORNStatusBarStyleLightContentTranslucent : ORNStatusBarStyleLightContent;
    } else {
        statusBarStyle = ([UIDevice orn_isIOS7]) ? ORNStatusBarStyleDefault : ORNStatusBarStyleLightContent;
    }
    [[UIApplication sharedApplication] orn_setStatusBarStyle:statusBarStyle];
}

- (void)_setupTitleLabel
{
    NSDictionary *appearanceAttributes = [UINavigationBar appearance].titleTextAttributes;
    UIFont *titleFont = appearanceAttributes[UITextAttributeFont] ?: TITLE_FONT;
    UIColor *titleTextColor = appearanceAttributes[UITextAttributeTextColor] ?: TITLE_TEXT_COLOR;
    UIColor *titleTextShadowColor = appearanceAttributes[UITextAttributeTextShadowColor] ?: TITLE_TEXT_SHADOW_COLOR;
    NSValue *titleTextShadowOffset = appearanceAttributes[UITextAttributeTextShadowOffset] ?: [NSValue valueWithUIOffset:TITLE_TEXT_SHADOW_OFFSET];
    self.titleTextAttributes = @{UITextAttributeFont: titleFont, UITextAttributeTextColor: titleTextColor, UITextAttributeTextShadowColor: titleTextShadowColor, UITextAttributeTextShadowOffset: titleTextShadowOffset};
}

- (void)_setupBackground
{
    [self setTitleVerticalPositionAdjustment:TITLE_ADJUSTMENT forBarMetrics:UIBarMetricsDefault];
    [self.ornamentationLayer removeFromSuperlayer];
    [self.layer addSublayer:self.ornamentationLayer];

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    if (self.isSimpleStyle) {
        self.ornamentationLayer.locations = GRADIENT_LOCATIONS_SIMPLE;
        [self.ornamentationLayer colorInView:self withOptions:ORNOrnamentTypeTint | ORNOrnamentTypeBorder, ORNOrnamentTypeTint | ORNOrnamentTypeBackground, ORNOrnamentTypeBackground | ORNOrnamentTypeShade, ORNOrnamentTypeBorder, nil];
    } else {
        self.ornamentationLayer.locations = GRADIENT_LOCATIONS;
        [self.ornamentationLayer colorInView:self withOptions:ORNOrnamentTypeTint | ORNOrnamentTypeBorder, ORNOrnamentTypeTint | ORNOrnamentTypeBackground, ORNOrnamentTypeTint | ORNOrnamentTypeShade, ORNOrnamentTypeBackground, ORNOrnamentTypeBackground | ORNOrnamentTypeShade, ORNOrnamentTypeBorder, nil];
    }
    [CATransaction commit];
}

- (void)_setupBarButtons
{
    NSMutableString *backgroundImageName = [NSMutableString stringWithString:@"bg_bar_button"];
    if (self.isBlackStyle) {
        [backgroundImageName appendString:@"_black"];
        if (self.isTranslucentStyle) {
            [backgroundImageName appendString:@"_translucent"];
        }
    } else {
        [backgroundImageName appendString:@"_blue"];
    }
    NSString *backgroundImageNameSelected = [backgroundImageName stringByAppendingString:@"_pressed"];

    UIImage *barButtonBackgroundImage = [[UIImage imageNamed:backgroundImageName] orn_buttonBackgroundImage];
    UIImage *barButtonBackgroundImageHighlighted = [[UIImage imageNamed:backgroundImageNameSelected] orn_buttonBackgroundImage];
    UIImage *barButtonBackgroundImageDone = [[UIImage imageNamed:@"bg_bar_button_done"] orn_buttonBackgroundImage];
    UIImage *barButtonBackgroundImageDoneHighlighted = [[UIImage imageNamed:@"bg_bar_button_done_pressed"] orn_buttonBackgroundImage];

    for (UIButton *button in @[self.leftBarButton, self.rightBarButton]) {
        [button setBackgroundImage:barButtonBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:barButtonBackgroundImageDone forState:UIControlStateSelected];
        [button setBackgroundImage:barButtonBackgroundImageHighlighted forState:UIControlStateHighlighted];
        [button setBackgroundImage:barButtonBackgroundImageDoneHighlighted forState:UIControlStateSelected | UIControlStateHighlighted];
        [button setContentEdgeInsets:BAR_BUTTON_CONTENT_INSETS];
    }
}

#pragma mark - NSObject

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.ornamentationLayer.frame = self.layer.bounds;
}

#pragma mark - UINavigationBar

- (void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated
{
    [super pushNavigationItem:item animated:animated];
    self.item = item;
}

- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated
{
    UINavigationItem *poppedItem = [super popNavigationItemAnimated:animated];
    self.item = self.topItem;
    return poppedItem;
}

#pragma mark - ORNOrnamentable

- (void)ornament
{
    [self _setupStatusBar];
    [self _setupTitleLabel];
    [self _setupBackground];
    [self _setupBarButtons];
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
