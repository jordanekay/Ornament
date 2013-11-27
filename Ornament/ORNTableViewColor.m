//
//  UIColor+ORNTableView.m
//  Ornament
//
//  Created by Jordan Kay on 11/18/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "UIColor+ORNAdditions.h"
#import "ORNTableViewColor.h"

@implementation ORNTableViewColor

// Background
ORN_CACHED_COLOR(plainBackgroundColor, [UIColor whiteColor]);
ORN_CACHED_COLOR(groupedBackgroundColor, [UIColor orn_groupedTableViewBackgroundColorWithPinstripes:YES]);
ORN_CACHED_COLOR(groupedEtchedBackgroundColor, [UIColor orn_lightLinenColor]);
ORN_CACHED_COLOR(cardBackgroundColor, [[UIColor colorWithWhite:0.9f alpha:1.0f] orn_colorWithNoise:0.4f]);
ORN_CACHED_COLOR(metalBackgroundColor, [UIColor colorWithWhite:0.2f alpha:1.0f]);
ORN_CACHED_COLOR(grooveBackgroundColor, [[UIColor orn_colorWithHex:0xdad6c6] orn_colorWithNoise:0.2f]);

// Section background
ORN_CACHED_COLOR(plainSectionBackgroundColor, [UIColor whiteColor]);
ORN_CACHED_COLOR(groupedEtchedSectionBackgroundColor, [UIColor colorWithWhite:0.96f alpha:1.0f]);
ORN_CACHED_COLOR(metalSectionBackgroundColor, [UIColor colorWithWhite:0.3f alpha:1.0f]);
ORN_CACHED_COLOR(grooveSectionBackgroundColor, [UIColor orn_colorWithHex:0xedebe7]);

// Section shadow
ORN_CACHED_COLOR(groupedEtchedSectionShadowColor, [UIColor colorWithWhite:1.0f alpha:0.5f]);
ORN_CACHED_COLOR(cardSectionShadowColor, [UIColor colorWithWhite:0.0f alpha:0.12f]);
ORN_CACHED_COLOR(grooveSectionShadowColor, [UIColor colorWithWhite:0.0f alpha:0.175f]);

// Section inner shadow
ORN_CACHED_COLOR(groupedEtchedSectionInnerShadowColor, [UIColor colorWithWhite:0.0f alpha:0.2f]);
ORN_CACHED_COLOR(grooveSectionInnerShadowColor, [UIColor colorWithWhite:0.0f alpha:0.5f]);

// Section border
ORN_CACHED_COLOR(metalSectionBorderColor, [UIColor colorWithWhite:0.4f alpha:1.0f]);
ORN_CACHED_COLOR(highlightedMetalSectionBorderColor, [UIColor orn_colorWithHex:0x5192dd]);

// Section stroke
ORN_CACHED_COLOR(plainSectionStrokeColor, [UIColor colorWithWhite:0.75f alpha:1.0f]);
ORN_CACHED_COLOR(groupedEtchedSectionStrokeColor, [UIColor colorWithWhite:0.0f alpha:0.25f]);
ORN_CACHED_COLOR(metalSectionStrokeColor, [UIColor colorWithWhite:0.0f alpha:0.9f]);
ORN_CACHED_COLOR(grooveSectionStrokeColor, [UIColor colorWithWhite:0.65f alpha:1.0f]);

// Cell background
ORN_CACHED_COLOR(highlightedPlainCellBackgroundColor, [UIColor orn_colorWithHex:0x298ef3]);
ORN_CACHED_COLOR(highlightedMetalCellBackgroundColor, [ORNTableViewColor highlightedMetalSectionBorderColor]);
ORN_CACHED_COLOR(highlightedGrooveCellBackgroundColor, [UIColor orn_colorWithHex:0xdadada]);

// Cell border
ORN_CACHED_COLOR(groupedEtchedCellBorderColor, [UIColor whiteColor]);
ORN_CACHED_COLOR(metalCellBorderColor, [UIColor colorWithWhite:0.4f alpha:1.0f]);
ORN_CACHED_COLOR(grooveCellBorderColor, [UIColor colorWithWhite:1.0f alpha:0.65f]);
ORN_CACHED_COLOR(highlightedPlainCellBorderColor, [UIColor clearColor]);
ORN_CACHED_COLOR(highlightedMetalCellBorderColor, [ORNTableViewColor highlightedMetalSectionBorderColor]);

// Cell separator
ORN_CACHED_COLOR(plainCellSeparatorColor, [UIColor colorWithWhite:0.8f alpha:1.0f]);
ORN_CACHED_COLOR(groupedEtchedCellSeparatorColor, [UIColor colorWithWhite:0.75f alpha:1.0f]);
ORN_CACHED_COLOR(cardCellSeparatorColor, [UIColor colorWithWhite:0.85f alpha:1.0f]);
ORN_CACHED_COLOR(metalCellSeparatorColor, [UIColor colorWithWhite:0.0f alpha:0.9f]);
ORN_CACHED_COLOR(grooveCellSeparatorColor, [UIColor colorWithWhite:0.0f alpha:0.225f]);

// Cell shade
ORN_CACHED_COLOR(plainCellShadeColor, [UIColor colorWithWhite:0.0 alpha:0.02f]);
ORN_CACHED_COLOR(highlightedPlainCellShadeColor, [UIColor colorWithWhite:0.0f alpha:0.15f]);
ORN_CACHED_COLOR(highlightedMetalCellShadeColor, [UIColor clearColor]);
ORN_CACHED_COLOR(highlightedGrooveCellShadeColor, [UIColor clearColor]);

// Header view
ORN_CACHED_COLOR(plainHeaderTextColor, [UIColor whiteColor]);
ORN_CACHED_COLOR(plainHeaderShadowColor, [UIColor colorWithWhite:0.0f alpha:0.6f]);
ORN_CACHED_COLOR(groupedHeaderTextColor, [UIColor orn_colorWithHex:0x505a6f]);
ORN_CACHED_COLOR(groupedHeaderShadowColor, [UIColor whiteColor]);
ORN_CACHED_COLOR(cardHeaderTextColor, [UIColor colorWithWhite:0.4f alpha:1.0f]);
ORN_CACHED_COLOR(metalHeaderTextColor, [UIColor orn_colorWithHex:0xbbd3f3]);
ORN_CACHED_COLOR(metalHeaderShadowColor, [UIColor blackColor]);
ORN_CACHED_COLOR(grooveHeaderTextColor, [UIColor orn_colorWithHex:0x7d7871]);

@end
