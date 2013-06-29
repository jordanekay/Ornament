//
//  UIColor+ORNTableView.h
//  Ornament
//
//  Created by Jordan Kay on 11/18/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "UIColor+ORNAdditions.h"

@interface ORNTableViewColor : UIColor

// Background
+ (UIColor *)plainBackgroundColor;
+ (UIColor *)groupedBackgroundColor;
+ (UIColor *)groupedEtchedBackgroundColor;
+ (UIColor *)cardBackgroundColor;
+ (UIColor *)metalBackgroundColor;
+ (UIColor *)grooveBackgroundColor;

// Section background
+ (UIColor *)plainSectionBackgroundColor;
+ (UIColor *)groupedEtchedSectionBackgroundColor;
+ (UIColor *)metalSectionBackgroundColor;
+ (UIColor *)grooveSectionBackgroundColor;

// Section shadow
+ (UIColor *)groupedEtchedSectionShadowColor;
+ (UIColor *)cardSectionShadowColor;
+ (UIColor *)grooveSectionShadowColor;

// Section inner shadow
+ (UIColor *)groupedEtchedSectionInnerShadowColor;
+ (UIColor *)grooveSectionInnerShadowColor;

// Section border
+ (UIColor *)metalSectionBorderColor;
+ (UIColor *)highlightedMetalSectionBorderColor;

// Section stroke
+ (UIColor *)plainSectionStrokeColor;
+ (UIColor *)groupedEtchedSectionStrokeColor;
+ (UIColor *)metalSectionStrokeColor;
+ (UIColor *)grooveSectionStrokeColor;

// Cell background
+ (UIColor *)highlightedPlainCellBackgroundColor;
+ (UIColor *)highlightedMetalCellBackgroundColor;
+ (UIColor *)highlightedGrooveCellBackgroundColor;

// Cell border
+ (UIColor *)groupedEtchedCellBorderColor;
+ (UIColor *)metalCellBorderColor;
+ (UIColor *)grooveCellBorderColor;
+ (UIColor *)highlightedPlainCellBorderColor;
+ (UIColor *)highlightedMetalCellBorderColor;

// Cell separator
+ (UIColor *)plainCellSeparatorColor;
+ (UIColor *)groupedEtchedCellSeparatorColor;
+ (UIColor *)cardCellSeparatorColor;
+ (UIColor *)metalCellSeparatorColor;
+ (UIColor *)grooveCellSeparatorColor;

// Cell shade
+ (UIColor *)plainCellShadeColor;
+ (UIColor *)highlightedPlainCellShadeColor;
+ (UIColor *)highlightedMetalCellShadeColor;
+ (UIColor *)highlightedGrooveCellShadeColor;

// Header view
+ (UIColor *)plainHeaderTextColor;
+ (UIColor *)plainHeaderShadowColor;
+ (UIColor *)groupedHeaderTextColor;
+ (UIColor *)groupedHeaderShadowColor;
+ (UIColor *)cardHeaderTextColor;
+ (UIColor *)metalHeaderTextColor;
+ (UIColor *)metalHeaderShadowColor;
+ (UIColor *)grooveHeaderTextColor;

@end
