//
//  ORNOrnament.h
//  Ornament
//
//  Created by Jordan Kay on 7/24/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ORNColorable;

typedef NS_OPTIONS(NSUInteger, ORNOrnamentOptions) {
    ORNOrnamentTableViewScopeNone    = 0 << 1,
    ORNOrnamentTableViewScopeTable   = 1 << 2,
    ORNOrnamentTableViewScopeSection = 1 << 3,
    ORNOrnamentTableViewScopeCell    = 1 << 4,
    
    ORNOrnamentTypeLayout            = 1 << 5,
    ORNOrnamentTypeBackground        = 1 << 6,
    ORNOrnamentTypeStroke            = 1 << 7,
    ORNOrnamentTypeShadow            = 1 << 8,
    ORNOrnamentTypeShade             = 1 << 9,
    ORNOrnamentTypeTint              = 1 << 10,
    ORNOrnamentTypeBorder            = 1 << 11,
    
    ORNOrnamentStateNone             = 0 << 12,
    ORNOrnamentStateDefault          = 1 << 13,
    ORNOrnamentStateHighlighted      = 1 << 14,
    
    ORNOrnamentPositionTop           = 1 << 15,
    ORNOrnamentPositionBottom        = 1 << 16,
    ORNOrnamentPositionSides         = 1 << 17,
    ORNOrnamentPositionOutside       = 1 << 18
};

typedef UIEdgeInsets ORNPosition;

extern const ORNPosition ORNPositionCentered;

@interface ORNOrnament : NSObject

+ (instancetype)ornamentWithColor:(UIColor *)color;
+ (instancetype)layoutWithInsets:(UIEdgeInsets)insets;
+ (instancetype)layoutWithInsets:(UIEdgeInsets)insets radius:(CGFloat)radius;
+ (instancetype)shadowWithColor:(UIColor *)color blur:(CGFloat)blur;
+ (instancetype)shadowWithColor:(UIColor *)color blur:(CGFloat)blur position:(ORNPosition)position;
+ (instancetype)lineWithColor:(UIColor *)color;
+ (instancetype)lineWithColor:(UIColor *)color width:(CGFloat)width;

+ (CGFloat)defaultCornerRadius;
+ (CGFloat)defaultLineWidth;

ORNPosition ORNPositionMake(CGFloat horizontal, CGFloat vertical);

@property (nonatomic, readonly) UIColor *color;
@property (nonatomic, readonly) ORNOrnamentOptions implicitOptions;

@end

@protocol ORNOrnamentable

- (void)ornament;
- (void)ornament:(ORNOrnament *)ornament withOptions:(ORNOrnamentOptions)options;
- (BOOL)isOrnamentedWithOptions:(ORNOrnamentOptions)options;
- (NSArray *)colorsForOptionsList:(NSArray *)list;

@property (nonatomic) NSUInteger ornamentationStyle;

@optional

- (void)setOuterShadowInRect:(CGRect)rect radius:(CGFloat)radius options:(ORNOrnamentOptions)options;
- (void)setInnerShadowInRect:(CGRect)rect withStrokeRect:(CGRect)strokeRect strokeWidth:(CGFloat)strokeWidth radius:(CGFloat)radius options:(ORNOrnamentOptions)options withoutOptions:(ORNOrnamentOptions)withoutOptions;

@property (nonatomic) CAGradientLayer<ORNColorable> *ornamentationLayer;
@property (nonatomic, readonly) NSDictionary *colorsForOptions;

@end

@interface UIView (ORNOrnament)

- (ORNOrnament *)orn_ornamentWithOptions:(ORNOrnamentOptions)options;
- (void)orn_ornament:(ORNOrnament *)ornament withOptions:(ORNOrnamentOptions)options;
- (BOOL)orn_isOrnamentedWithOptions:(ORNOrnamentOptions)options;
- (NSArray *)orn_colorsForOptionsList:(NSArray *)list;
- (void)orn_setShadowInRect:(CGRect)rect withStrokeRect:(CGRect)strokeRect strokeWidth:(CGFloat)strokeWidth radius:(CGFloat)radius roundedCorners:(UIRectCorner)corners options:(ORNOrnamentOptions)options withoutOptions:(ORNOrnamentOptions)options;
- (void)orn_getOrnamentMeasurement:(CGFloat *)measurement position:(ORNPosition *)position withOptions:(ORNOrnamentOptions)options;

@end
