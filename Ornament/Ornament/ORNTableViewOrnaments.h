//
//  ORNTableViewOrnaments.h
//  Ornament
//
//  Created by Jordan Kay on 8/5/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#define TABLE_LAYOUT [ORNOrnament layoutWithInsets:TABLE_INSETS]
#define TABLE_LAYOUT_PLAIN [ORNOrnament layoutWithInsets:TABLE_INSETS_PLAIN]
#define TABLE_LAYOUT_CARD [ORNOrnament layoutWithInsets:TABLE_INSETS_CARD]
#define TABLE_LAYOUT_METAL [ORNOrnament layoutWithInsets:TABLE_INSETS_METAL]

#define SECTION_LAYOUT_PLAIN [ORNOrnament layoutWithInsets:SECTION_INSETS_PLAIN radius:SECTION_CORNER_RADIUS_PLAIN]
#define SECTION_LAYOUT_GROUPED [ORNOrnament layoutWithInsets:SECTION_INSETS_GROUPED radius:SECTION_CORNER_RADIUS_GROUPED]
#define SECTION_LAYOUT_GROUPED_ETCHED [ORNOrnament layoutWithInsets:SECTION_INSETS_GROUPED radius:SECTION_CORNER_RADIUS_GROUPED_ETCHED]
#define SECTION_LAYOUT_CARD [ORNOrnament layoutWithInsets:SECTION_INSETS_CARD radius:SECTION_CORNER_RADIUS_CARD]
#define SECTION_LAYOUT_METAL [ORNOrnament layoutWithInsets:SECTION_INSETS_METAL radius:SECTION_CORNER_RADIUS_METAL]
#define SECTION_LAYOUT_GROOVE [ORNOrnament layoutWithInsets:SECTION_INSETS_GROOVE radius:SECTION_CORNER_RADIUS_GROOVE]

#define SECTION_BACKGROUND [ORNOrnament ornamentWithColor:[ORNTableViewColor plainBackgroundColor]]
#define SECTION_BACKGROUND_GROUPED_ETCHED [ORNOrnament ornamentWithColor:[ORNTableViewColor groupedEtchedSectionBackgroundColor]]
#define SECTION_BACKGROUND_METAL [ORNOrnament ornamentWithColor:[ORNTableViewColor metalSectionBackgroundColor]]
#define SECTION_BACKGROUND_GROOVE [ORNOrnament ornamentWithColor:[ORNTableViewColor grooveSectionBackgroundColor]]

#define SECTION_SHADOW_CARD [ORNOrnament shadowWithColor:[ORNTableViewColor cardSectionShadowColor] blur:SECTION_SHADOW_BLUR_CARD position:SECTION_SHADOW_POSITION_CARD]
#define SECTION_SHADOW_GROUPED_ETCHED [ORNOrnament shadowWithColor:[ORNTableViewColor groupedEtchedSectionShadowColor] blur:SECTION_SHADOW_BLUR_GROUPED_ETCHED position:SECTION_SHADOW_POSITION_GROUPED_ETCHED]
#define SECTION_SHADOW_GROOVE [ORNOrnament shadowWithColor:[ORNTableViewColor grooveSectionShadowColor] blur:SECTION_SHADOW_BLUR_GROOVE]

#define SECTION_INNER_SHADOW_GROUPED_ETCHED [ORNOrnament shadowWithColor:[ORNTableViewColor groupedEtchedSectionInnerShadowColor] blur:SECTION_INNER_SHADOW_BLUR_GROUPED_ETCHED]
#define SECTION_INNER_SHADOW_HIGHLIGHTED_GROOVE [ORNOrnament shadowWithColor:[ORNTableViewColor grooveSectionInnerShadowColor] blur:SECTION_INNER_SHADOW_BLUR_GROOVE]

#define SECTION_STROKE [ORNOrnament lineWithColor:[ORNTableViewColor plainSectionStrokeColor]];
#define SECTION_STROKE_GROUPED_ETCHED [ORNOrnament lineWithColor:[ORNTableViewColor groupedEtchedSectionStrokeColor]]
#define SECTION_STROKE_METAL [ORNOrnament lineWithColor:[ORNTableViewColor metalSectionStrokeColor]]
#define SECTION_STROKE_GROOVE [ORNOrnament lineWithColor:[ORNTableViewColor grooveSectionStrokeColor] width:SECTION_STROKE_WIDTH_GROOVE]

#define CELL_BACKGROUND_HIGHLIGHTED [ORNOrnament ornamentWithColor:[ORNTableViewColor highlightedPlainCellBackgroundColor]];
#define CELL_BACKGROUND_HIGHLIGHTED_METAL [ORNOrnament ornamentWithColor:[ORNTableViewColor highlightedMetalCellBackgroundColor]];
#define CELL_BACKGROUND_HIGHLIGHTED_GROOVE [ORNOrnament ornamentWithColor:[ORNTableViewColor highlightedGrooveCellBackgroundColor]];

#define CELL_BORDER_GROUPED_ETCHED [ORNOrnament lineWithColor:[ORNTableViewColor groupedEtchedCellBorderColor]]
#define CELL_BORDER_METAL [ORNOrnament lineWithColor:[ORNTableViewColor metalCellBorderColor]]
#define CELL_BORDER_GROOVE [ORNOrnament lineWithColor:[ORNTableViewColor grooveCellBorderColor]]
#define CELL_BORDER_HIGHLIGHTED [ORNOrnament lineWithColor:[ORNTableViewColor highlightedPlainCellBorderColor]];
#define CELL_BORDER_HIGHLIGHTED_METAL [ORNOrnament lineWithColor:[ORNTableViewColor highlightedMetalCellBorderColor]];

#define CELL_SHADE_GROOVE [ORNOrnament ornamentWithColor:[ORNTableViewColor plainCellShadeColor]]
#define CELL_SHADE_HIGHLIGHTED [ORNOrnament ornamentWithColor:[ORNTableViewColor highlightedPlainCellShadeColor]];
#define CELL_SHADE_HIGHLIGHTED_METAL [ORNOrnament ornamentWithColor:[ORNTableViewColor highlightedMetalCellShadeColor]]
#define CELL_SHADE_HIGHLIGHTED_GROOVE [ORNOrnament ornamentWithColor:[ORNTableViewColor highlightedGrooveCellShadeColor]]
