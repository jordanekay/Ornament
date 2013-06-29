//
//  ORNTableHeaderView.m
//  Ornament
//
//  Created by Jordan Kay on 11/17/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNTableHeaderView.h"
#import "ORNTableViewColor.h"
#import "UIFont+ORNSystem.h"

#define DEFAULT_PADDING 6.0f
#define DEFAULT_PADDING_TOP 10.0f
#define TABLE_PADDING 2.0f
#define MINIMUM_HEIGHT 24.0f

#define TITLE_FONT [UIFont orn_boldSystemFontOfSize:17.0f]
#define TITLE_FONT_CARD [UIFont orn_boldSystemFontOfSize:16.0f]
#define TITLE_FONT_METAL [UIFont orn_boldSystemFontOfSize:14.0f]
#define TITLE_OFFSET UIOffsetMake(0.0f, -1.0f)
#define TITLE_OFFSET_GROUPED UIOffsetMake(6.0f, 4.0f)
#define TITLE_OFFSET_CARD UIOffsetMake(6.0f, 1.0f)
#define TITLE_OFFSET_METAL UIOffsetMake(18.0f, 1.0f)
#define TITLE_SHADOW_OFFSET CGSizeMake(0.0f, 1.0f)
#define TITLE_SHADOW_OFFSET_METAL CGSizeMake(0.0f, -1.0f)

@interface ORNTableHeaderView ()

@property (nonatomic, weak) ORNTableView *tableView;
@property (nonatomic) UIOffset titleOffset;

@end

@implementation ORNTableHeaderView

- (instancetype)initWithTableView:(ORNTableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _tableView = tableView;
        [self ornament];
    }
    return self;
}

+ (CGFloat)defaultPadding
{
    return DEFAULT_PADDING;
}

+ (CGFloat)defaultPaddingTop
{
    return DEFAULT_PADDING_TOP;
}

+ (CGFloat)tablePadding
{
    return TABLE_PADDING;
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

    CGRect frame = self.textLabel.frame;
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
            // TODO
            backgroundColor = [UIColor orn_colorWithHex:0xb0b9c1];
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
