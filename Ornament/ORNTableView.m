//
//  ORNTableView.m
//  Ornament
//
//  Created by Jordan Kay on 7/15/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNColorable.h"
#import "ORNPath.h"
#import "ORNSwizzle.h"
#import "ORNTableView.h"
#import "ORNTableViewColor.h"
#import "ORNTableViewConstants.h"
#import "ORNTableViewOrnaments.h"
#import "UIColor+ORNAdditions.h"

@interface ORNTableView ()

@property (nonatomic, readwrite) UIImage *backgroundImage;
@property (nonatomic, readwrite) UIImage *highlightedBackgroundImage;

@end

@implementation ORNTableView

@synthesize ornamentationStyle = _ornamentationStyle;

- (instancetype)initWithFrame:(CGRect)frame ornamentationStyle:(ORNTableViewStyle)style
{
    if ([super initWithFrame:frame style:UITableViewStylePlain]) {
        _ornamentationStyle = style;
    }

    return self;
}

- (UIImage *)backgroundImage
{
    return _backgroundImage ?: (_backgroundImage = [self _backgroundImageWithOptions:ORNOrnamentStateDefault]);
}

- (UIImage *)highlightedBackgroundImage
{
    return _highlightedBackgroundImage ?: (_highlightedBackgroundImage = [self _backgroundImageWithOptions:ORNOrnamentStateHighlighted]);
}
    
- (UIImage *)_backgroundImageWithOptions:(ORNOrnamentOptions)options
{
    UIImage *image;
    CGFloat radius = 0.0f;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    CGFloat strokeWidth = 0.0f;
    CGFloat borderWidth = 0.0f;

    [self orn_getOrnamentMeasurement:&radius position:&insets withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeLayout];
    [self orn_getOrnamentMeasurement:&strokeWidth position:NULL withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeStroke];
    [self orn_getOrnamentMeasurement:&borderWidth position:NULL withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeBorder];
    
    CGFloat strokeBorderWidth = strokeWidth + borderWidth;
    CGFloat innerRadius = MAX((radius - strokeBorderWidth) * 2, MIN_SECTION_CORNER_RADIUS);
    CGRect backgroundRect = CGRectMake(insets.left + strokeBorderWidth, insets.top + strokeBorderWidth, innerRadius, innerRadius);
    CGRect borderRect = CGRectInset(backgroundRect, -borderWidth, -borderWidth);
    CGRect strokeRect = CGRectInset(borderRect, -strokeWidth, -strokeWidth);
    CGSize size = CGSizeMake(insets.left + insets.right + radius * 2, insets.top + insets.bottom + radius * 2);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(insets.top + radius, insets.left + radius, insets.bottom + radius, insets.right + radius);
    
    ORNPath *backgroundPath, *borderPath, *strokePath;
    if (innerRadius > MIN_SECTION_CORNER_RADIUS) {
        backgroundPath = [ORNPath pathWithOvalInRect:backgroundRect];
        if (borderWidth) {
            borderPath = [ORNPath pathWithOvalInRect:borderRect];
        }
        strokePath = [ORNPath pathWithOvalInRect:strokeRect];
    } else {
        backgroundPath = [ORNPath pathWithRect:backgroundRect];
        if (borderWidth) {
            borderPath = [ORNPath pathWithRect:borderRect];
        }
        strokePath = [ORNPath pathWithRect:strokeRect];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    [self setOuterShadowInRect:strokeRect radius:radius options:ORNOrnamentTableViewScopeSection | options];
    [strokePath colorInView:self withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeStroke | options, nil];
    [borderPath colorInView:self withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeBorder | options, nil];
    if (options & ORNOrnamentStateDefault) {
        [backgroundPath colorInView:self withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeBackground | ORNOrnamentStateDefault, nil];
    } else if (options & ORNOrnamentStateHighlighted) {
        [backgroundPath colorInView:self withOptions:ORNOrnamentTableViewScopeCell | ORNOrnamentTypeBackground |  ORNOrnamentStateHighlighted, nil];
    }
    [self setInnerShadowInRect:backgroundRect withStrokeRect:strokeRect strokeWidth:strokeWidth radius:radius options:ORNOrnamentTableViewScopeSection | options withoutOptions:ORNOrnamentShadowPositionSides];
    
    image = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:capInsets];
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - NSObject

+ (void)initialize
{
    if (self == [ORNTableView class]) {
        SEL headerViewFloatSelector = NSSelectorFromString(@"allowsHeaderViewsToFloat");
        ORNSwizzle(self, headerViewFloatSelector, @selector(pinsHeaderViewsToTop));
    }
}

#pragma mark - UITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    return [self initWithFrame:frame ornamentationStyle:ORNTableViewStylePlain];
}

#pragma mark - ORNOrnamentable

- (void)ornament
{
    ORNOrnament *tableLayout = TABLE_LAYOUT;
    ORNOrnament *sectionBackground = SECTION_BACKGROUND;
    ORNOrnament *sectionStroke = SECTION_STROKE;
    ORNOrnament *cellBackgroundHighlighted = CELL_BACKGROUND_HIGHLIGHTED;
    ORNOrnament *cellShadeHighlighted = CELL_SHADE_HIGHLIGHTED;
    ORNOrnament *cellBorderHighlighted = CELL_BORDER_HIGHLIGHTED;

    CGFloat sectionCornerRadius = [ORNOrnament defaultCornerRadius];
    ORNOrnamentOptions cellBorderHighlightedOptions = ORNOrnamentTableViewScopeCell | ORNOrnamentTypeBorder | ORNOrnamentStateHighlighted;

    self.separatorColor = [ORNTableViewColor plainCellSeparatorColor];
    self.separatorHeight = [ORNOrnament defaultLineWidth];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    switch (self.ornamentationStyle) {
        case ORNTableViewStyleCustom:
        case ORNTableViewStylePlain:
            tableLayout = TABLE_LAYOUT_PLAIN;
            self.backgroundColor = [ORNTableViewColor plainBackgroundColor];
            [self ornament:SECTION_LAYOUT_PLAIN withOptions:ORNOrnamentTableViewScopeSection];
            break;
        case ORNTableViewStyleGrouped:
            self.backgroundColor = [ORNTableViewColor groupedBackgroundColor];
            [self ornament:SECTION_LAYOUT_GROUPED withOptions:ORNOrnamentTableViewScopeSection];
            break;
        case ORNTableViewStyleGroupedEtched:
            sectionCornerRadius = SECTION_CORNER_RADIUS_GROUPED_ETCHED;
            sectionBackground = SECTION_BACKGROUND_GROUPED_ETCHED;
            sectionStroke = SECTION_STROKE_GROUPED_ETCHED;
            self.backgroundColor = [ORNTableViewColor groupedEtchedBackgroundColor];
            self.separatorColor = [ORNTableViewColor groupedEtchedCellSeparatorColor];
            [self ornament:SECTION_LAYOUT_GROUPED_ETCHED withOptions:ORNOrnamentTableViewScopeSection];
            [self ornament:CELL_BORDER_GROUPED_ETCHED withOptions:ORNOrnamentTableViewScopeCell | ORNOrnamentTypeBorder];
            [self ornament:SECTION_SHADOW_GROUPED_ETCHED withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeShadow | ORNOrnamentShadowPositionOutside];
            [self ornament:SECTION_INNER_SHADOW_GROUPED_ETCHED withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeShadow | ORNOrnamentShadowPositionTop];
            break;
        case ORNTableViewStyleCard:
            tableLayout = TABLE_LAYOUT_CARD;
            sectionCornerRadius = SECTION_CORNER_RADIUS_CARD;
            self.superview.backgroundColor = [ORNTableViewColor cardBackgroundColor];
            self.separatorColor = [ORNTableViewColor cardCellSeparatorColor];
            [self ornament:SECTION_LAYOUT_CARD withOptions:ORNOrnamentTableViewScopeSection];
            [self ornament:SECTION_SHADOW_CARD withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeShadow | ORNOrnamentShadowPositionOutside];
            break;
        case ORNTableViewStyleMetal:
            tableLayout = TABLE_LAYOUT_METAL;
            sectionBackground = SECTION_BACKGROUND_METAL;
            sectionStroke = SECTION_STROKE_METAL;
            sectionCornerRadius = SECTION_CORNER_RADIUS_METAL;
            cellBackgroundHighlighted = CELL_BACKGROUND_HIGHLIGHTED_METAL;
            cellBorderHighlighted = CELL_BORDER_HIGHLIGHTED_METAL;
            cellShadeHighlighted = CELL_SHADE_HIGHLIGHTED_METAL;
            cellBorderHighlightedOptions |= ORNOrnamentTableViewScopeSection;
            self.backgroundColor = [ORNTableViewColor metalBackgroundColor];
            self.separatorColor = [ORNTableViewColor metalCellSeparatorColor];
            [self ornament:SECTION_LAYOUT_METAL withOptions:ORNOrnamentTableViewScopeSection];
            [self ornament:CELL_BORDER_METAL withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTableViewScopeCell | ORNOrnamentTypeBorder];
            break;
        case ORNTableViewStyleGroove:
            sectionBackground = SECTION_BACKGROUND_GROOVE;
            sectionStroke = SECTION_STROKE_GROOVE;
            cellBackgroundHighlighted = CELL_BACKGROUND_HIGHLIGHTED_GROOVE;
            cellShadeHighlighted = CELL_SHADE_HIGHLIGHTED_GROOVE;
            self.backgroundColor = [ORNTableViewColor grooveBackgroundColor];
            self.separatorHeight = CELL_SEPARATOR_HEIGHT_GROOVE;
            [self ornament:SECTION_LAYOUT_GROOVE withOptions:ORNOrnamentTableViewScopeSection];
            [self ornament:SECTION_SHADOW_GROOVE withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeShadow | ORNOrnamentShadowPositionOutside | ORNOrnamentStateDefault];
            [self ornament:SECTION_INNER_SHADOW_HIGHLIGHTED_GROOVE withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeShadow | ORNOrnamentShadowPositionTop | ORNOrnamentShadowPositionBottom | ORNOrnamentShadowPositionSides | ORNOrnamentStateHighlighted];
            [self ornament:CELL_SHADE_GROOVE withOptions:ORNOrnamentTableViewScopeCell | ORNOrnamentTypeShade | ORNOrnamentStateDefault];
            [self ornament:CELL_SHADE_HIGHLIGHTED_GROOVE withOptions:ORNOrnamentTableViewScopeCell | ORNOrnamentTypeShade | ORNOrnamentStateHighlighted];
            [self ornament:CELL_BORDER_GROOVE withOptions:ORNOrnamentTableViewScopeCell | ORNOrnamentTypeBorder | ORNOrnamentStateDefault];
            break;
    }
    
    [self ornament:tableLayout withOptions:ORNOrnamentTableViewScopeTable];
    [self ornament:sectionBackground withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeBackground];
    [self ornament:sectionStroke withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeStroke];
    [self ornament:cellBackgroundHighlighted withOptions:ORNOrnamentTableViewScopeCell | ORNOrnamentTypeBackground | ORNOrnamentStateHighlighted];
    [self ornament:cellShadeHighlighted withOptions:ORNOrnamentTableViewScopeCell | ORNOrnamentTypeShade | ORNOrnamentStateHighlighted];
    [self ornament:cellBorderHighlighted withOptions:cellBorderHighlightedOptions];
}

- (void)ornament:(ORNOrnament *)ornament withOptions:(ORNOrnamentOptions)options
{
    [self orn_ornament:ornament withOptions:options];
}

- (BOOL)isOrnamentedWithOptions:(ORNOrnamentOptions)options
{
    return [self orn_isOrnamentedWithOptions:options];
}

- (void)setOuterShadowInRect:(CGRect)rect radius:(CGFloat)radius options:(ORNOrnamentOptions)options
{
    options |= ORNOrnamentShadowPositionOutside;
    [self orn_setShadowInRect:rect withStrokeRect:CGRectZero strokeWidth:0.0f radius:radius options:options withoutOptions:0];
}

- (void)setInnerShadowInRect:(CGRect)rect withStrokeRect:(CGRect)strokeRect strokeWidth:(CGFloat)strokeWidth radius:(CGFloat)radius options:(ORNOrnamentOptions)options withoutOptions:(ORNOrnamentOptions)withoutOptions
{
    [self orn_setShadowInRect:rect withStrokeRect:strokeRect strokeWidth:strokeWidth radius:radius options:options withoutOptions:ORNOrnamentShadowPositionOutside | withoutOptions];
}

- (NSArray *)colorsForOptionsList:(NSArray *)list
{
    return [self orn_colorsForOptionsList:list];
}

@end
