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

#define BACKGROUND_ALPHA_PLAIN 0.9f
#define BACKGROUND_BRIGHTNESS_MULTIPLIER 1.05f
#define BACKGROUND_GRADIENT_LOCATIONS_PLAIN @[@0.0f, @0.05f, @0.1f, @0.95f, @1.0f]

#define BACKGROUND_PLAIN [ORNOrnament ornamentWithColor:[UIColor orn_colorWithHex:0xa7bdce]]
#define BORDER_PLAIN [ORNOrnament ornamentWithColor:[UIColor orn_colorWithHex:0x5c6266]]
#define TINT_PLAIN [ORNOrnament ornamentWithColor:[UIColor orn_colorWithHex:0xadb7bf]]
#define SHADE_PLAIN [ORNOrnament ornamentWithColor:[UIColor orn_colorWithHex:0x7e8b93]]

#define TITLE_FONT [UIFont orn_boldSystemFontOfSize:17.0f]
#define TITLE_FONT_CARD [UIFont orn_boldSystemFontOfSize:16.0f]
#define TITLE_FONT_METAL [UIFont orn_boldSystemFontOfSize:14.0f]
#define TITLE_OFFSET UIOffsetMake(-3.0f, -1.0f)
#define TITLE_OFFSET_GROUPED UIOffsetMake(6.0f, 4.0f)
#define TITLE_OFFSET_CARD UIOffsetMake(6.0f, 1.0f)
#define TITLE_OFFSET_METAL UIOffsetMake(18.0f, 1.0f)
#define TITLE_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
#define TITLE_SHADOW_OFFSET_METAL CGSizeMake(0.0f, -1.0f)

@interface ORNTableHeaderViewGradientLayer : ORNGradientLayer

@end

@implementation ORNTableHeaderViewGradientLayer

#pragma mark ORNColorable

- (void)colorInView:(UIView<ORNOrnamentable> *)view withOptions:(ORNOrnamentOptions)options
{
    UIColor *backgroundColor = [view orn_ornamentWithOptions:ORNOrnamentTypeBackground].color;
    UIColor *tintColor = [view orn_ornamentWithOptions:ORNOrnamentTypeTint].color;
    UIColor *shadeColor = [view orn_ornamentWithOptions:ORNOrnamentTypeShade].color;
    UIColor *borderColor = [view orn_ornamentWithOptions:ORNOrnamentTypeBorder].color;

    self.locations = BACKGROUND_GRADIENT_LOCATIONS_PLAIN;
    self.colors = [@[borderColor, tintColor, shadeColor, backgroundColor, borderColor] orn_mapWithBlock:^(UIColor *color, NSUInteger idx) {
        UIColor *adjustedColor = [[color orn_colorWithAlpha:BACKGROUND_ALPHA_PLAIN] orn_colorWithBrightnessMultiplier:BACKGROUND_BRIGHTNESS_MULTIPLIER];
        return (id)adjustedColor.CGColor;
    }];
}

@end

@interface ORNTableHeaderView ()

@property (nonatomic) UIOffset titleOffset;
@property (nonatomic) ORNTableHeaderViewGradientLayer *gradientLayer;
@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic, weak) ORNTableView *tableView;

@end

@implementation ORNTableHeaderView

- (instancetype)initWithTableView:(ORNTableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _tableView = tableView;
        [self ornament];
        [self _addGradientLayer];
    }
    return self;
}

- (ORNTableHeaderViewGradientLayer *)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [ORNTableHeaderViewGradientLayer layer];
        [_gradientLayer colorInView:self withOptions:0];
    }
    return _gradientLayer;
}

- (UIView *)contentView
{
    return [self.subviews lastObject];
}

- (void)_addGradientLayer
{
    if ([self isOrnamentedWithOptions:ORNOrnamentTypeBackground]) {
        [self.contentView.layer addSublayer:self.gradientLayer];
    }
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
    _gradientLayer.frame = frame;

    frame = self.textLabel.frame;
    frame.origin.x += self.titleOffset.horizontal;
    frame.origin.y += self.titleOffset.vertical;
    self.textLabel.frame = frame;

    if (self.tableView.usesUppercaseSectionHeaderTitles) {
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

    if (self.tableView.isGroupedStyle) {
        textColor = [ORNTableViewColor groupedHeaderTextColor];
        shadowColor = [ORNTableViewColor groupedHeaderShadowColor];
        self.titleOffset = TITLE_OFFSET_GROUPED;
    }

    switch (self.tableView.ornamentationStyle) {
        case ORNTableViewStylePlain:
            textColor = [ORNTableViewColor plainHeaderTextColor];
            shadowColor = [ORNTableViewColor plainHeaderShadowColor];
            [self ornament:BACKGROUND_PLAIN withOptions:ORNOrnamentTypeBackground];
            [self ornament:BORDER_PLAIN withOptions:ORNOrnamentTypeBorder];
            [self ornament:TINT_PLAIN withOptions:ORNOrnamentTypeTint];
            [self ornament:SHADE_PLAIN withOptions:ORNOrnamentTypeShade];
            break;
        case ORNTableViewStyleCard:
            textColor = [ORNTableViewColor cardHeaderTextColor];
            titleFont = TITLE_FONT_CARD;
            self.titleOffset = TITLE_OFFSET_CARD;
            break;
        case ORNTableViewStyleMetal:
            textColor = [ORNTableViewColor metalHeaderTextColor];
            shadowColor = [ORNTableViewColor metalHeaderShadowColor];
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
}

- (void)ornament:(ORNOrnament *)ornament withOptions:(ORNOrnamentOptions)options
{
    [self orn_ornament:ornament withOptions:options];
}

- (BOOL)isOrnamentedWithOptions:(ORNOrnamentOptions)options
{
    return [self orn_isOrnamentedWithOptions:options];
}

- (void)getOrnamentMeasurement:(CGFloat *)measurement position:(ORNPosition *)position withOptions:(ORNOrnamentOptions)options
{
    [self orn_getOrnamentMeasurement:measurement position:position withOptions:options];
}

@end
