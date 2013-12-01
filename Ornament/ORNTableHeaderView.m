//
//  ORNTableHeaderView.m
//  Ornament
//
//  Created by Jordan Kay on 11/17/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNGradientLayer.h"
#import "ORNTableHeaderView.h"
#import "ORNTableViewColor.h"
#import "NSArray+ORNFunctional.h"
#import "UIFont+ORNSystem.h"

#define DEFAULT_PADDING 6.0f
#define DEFAULT_PADDING_TOP 10.0f
#define MINIMUM_HEIGHT 24.0f

#define BACKGROUND_ALPHA 0.9f
#define BACKGROUND_BRIGHTNESS_MULTIPLIER 1.1f
#define BACKGROUND_GRADIENT_LOCATIONS @[@0.0f, @0.05f, @0.1f, @0.8f, @0.95f, @1.0f]

#define TITLE_FONT [UIFont orn_boldSystemFontOfSize:17.0f]
#define TITLE_FONT_CARD [UIFont orn_boldSystemFontOfSize:16.0f]
#define TITLE_FONT_METAL [UIFont orn_boldSystemFontOfSize:14.0f]

#define TITLE_OFFSET UIOffsetMake(-3.0f, -1.0f)
#define TITLE_OFFSET_GROUPED UIOffsetMake(6.0f, 4.0f)
#define TITLE_OFFSET_CARD UIOffsetMake(6.0f, 1.0f)
#define TITLE_OFFSET_METAL UIOffsetMake(18.0f, 1.0f)
#define TITLE_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
#define TITLE_SHADOW_OFFSET_METAL CGSizeMake(0.0f, -1.0f)

#define BACKGROUND_COLOR 0xa0a7ae
#define BORDER_COLOR 0x5c6266
#define TINT_COLOR 0x8d98a1
#define SHADE_COLOR 0x80878e

@interface ORNTableHeaderView ()

@property (nonatomic) UIOffset titleOffset;
@property (nonatomic, readonly) UIView *contentView;

@end

@implementation ORNTableHeaderView

@synthesize ornamentationStyle = _ornamentationStyle;
@synthesize ornamentationLayer = _ornamentationLayer;

- (UIView *)contentView
{
    return [self.subviews lastObject];
}

+ (CGFloat)defaultPadding
{
    return DEFAULT_PADDING;
}

+ (CGFloat)defaultPaddingTop
{
    return DEFAULT_PADDING_TOP;
}

+ (CGFloat)minimumHeight
{
    return MINIMUM_HEIGHT;
}

+ (Class)tableViewClass
{
    return [ORNTableView class];
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect frame = self.contentView.bounds;
    self.ornamentationLayer.frame = frame;

    frame = self.textLabel.frame;
    frame.origin.x += self.titleOffset.horizontal;
    frame.origin.y += self.titleOffset.vertical;
    self.textLabel.frame = frame;

    if (self.usesUppercaseTitles) {
        self.textLabel.text = [self.textLabel.text uppercaseString];
    }
}

#pragma mark - ORNOrnamentable

- (void)ornament
{
    UIColor *textColor, *shadowColor, *backgroundColor;
    UIFont *titleFont = TITLE_FONT;
    self.titleOffset = TITLE_OFFSET;
    self.textLabel.shadowOffset = TITLE_SHADOW_OFFSET;

    if (self.isGroupedStyle) {
        textColor = [ORNTableViewColor groupedHeaderTextColor];
        shadowColor = [ORNTableViewColor groupedHeaderTextShadowColor];
        self.titleOffset = TITLE_OFFSET_GROUPED;
    }

    switch (self.ornamentationStyle) {
        case ORNTableViewStylePlain:
            textColor = [ORNTableViewColor plainHeaderTextColor];
            shadowColor = [ORNTableViewColor plainHeaderTextShadowColor];
            break;
        case ORNTableViewStyleCard:
            textColor = [ORNTableViewColor cardHeaderTextColor];
            titleFont = TITLE_FONT_CARD;
            self.titleOffset = TITLE_OFFSET_CARD;
            break;
        case ORNTableViewStyleMetal:
            textColor = [ORNTableViewColor metalHeaderTextColor];
            shadowColor = [ORNTableViewColor metalHeaderTextShadowColor];
            titleFont = TITLE_FONT_METAL;
            self.titleOffset = TITLE_OFFSET_METAL;
            self.textLabel.shadowOffset = TITLE_SHADOW_OFFSET_METAL;
            break;
        case ORNTableViewStyleGroove:
            textColor = [ORNTableViewColor grooveHeaderTextColor];
            break;
        default:
            break;
    }

    self.textLabel.textColor = textColor;
    if (backgroundColor) {
        self.contentView.backgroundColor = backgroundColor;
    } else {
        self.backgroundView = [UIView new];
    }
    self.textLabel.shadowColor = shadowColor;
    [[UILabel appearanceWhenContainedIn:[ORNTableHeaderView class], nil] setFont:titleFont];

    if ([self isOrnamentedWithOptions:ORNOrnamentTypeBackground]) {
        [self.contentView.layer addSublayer:self.ornamentationLayer];
        [_ornamentationLayer colorInView:self withOptions:ORNOrnamentTypeBorder, ORNOrnamentTypeTint, ORNOrnamentTypeShade, ORNOrnamentTypeBackground, ORNOrnamentTypeBackground, ORNOrnamentTypeBorder, nil];
    }
}

- (ORNGradientLayer *)ornamentationLayer
{
    if (!_ornamentationLayer) {
        _ornamentationLayer = [ORNGradientLayer layer];
        _ornamentationLayer.locations = BACKGROUND_GRADIENT_LOCATIONS;
    }
    return (ORNGradientLayer *)_ornamentationLayer;
}

- (NSDictionary *)colorsForOptions
{
    ORN_CACHED_COLORS(ORNOrnamentTypeBackground, BACKGROUND_COLOR, ORNOrnamentTypeShade, SHADE_COLOR, ORNOrnamentTypeTint, TINT_COLOR, ORNOrnamentTypeBorder, BORDER_COLOR);
}

- (NSArray *)colorsForOptionsList:(NSArray *)list
{
    NSArray *colors = [self.colorsForOptions objectsForKeys:list notFoundMarker:[NSNull null]];
    return [colors orn_mapWithBlock:^(UIColor *color, NSUInteger idx) {
        return [[color orn_colorWithAlpha:BACKGROUND_ALPHA] orn_colorWithBrightnessMultiplier:BACKGROUND_BRIGHTNESS_MULTIPLIER];
    }];
}

- (void)ornament:(ORNOrnament *)ornament withOptions:(ORNOrnamentOptions)options
{
    [self orn_ornament:ornament withOptions:options];
}

- (BOOL)isOrnamentedWithOptions:(ORNOrnamentOptions)options
{
    return self.ornamentationStyle == ORNTableViewStylePlain;
}

@end
