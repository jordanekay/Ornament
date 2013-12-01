//
//  UIApplication+ORNStatusBar.m
//  Ornament
//
//  Created by Jordan Kay on 8/12/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNColorable.h"
#import "ORNGradientLayer.h"
#import "ORNNavigationBar.h"
#import "ORNNavigationController.h"
#import "ORNLayer.h"
#import "ORNOrnament.h"
#import "UIApplication+ORNStatusBar.h"
#import "UIDevice+ORNVersion.h"

#define WIDTH [UIApplication sharedApplication].keyWindow.bounds.size.width
#define HEIGHT ([UIDevice orn_isIOS7] ? 21.0f : 20.0f)

#define BACKGROUND_COLOR [UIColor colorWithWhite:0.98f alpha:1.0f]
#define BACKGROUND_COLOR_LIGHT_CONTENT [UIColor blackColor]
#define BACKGROUND_COLOR_LIGHT_CONTENT_TRANSLUCENT [UIColor colorWithWhite:0.0f alpha:0.4f]
#define SHADE_COLOR [UIColor colorWithWhite:0.0f alpha:0.2f]
#define BORDER_COLOR [UIColor colorWithWhite:0.6f alpha:1.0f]

@interface ORNStatusBar : UIView <ORNOrnamentable>

@property (nonatomic) ORNGradientLayer *backgroundLayer;
@property (nonatomic) ORNLayer *borderLayer;

@end

@implementation UIApplication (ORNStatusBar)

static ORNStatusBar *statusBar;

- (void)orn_setStatusBarStyle:(ORNStatusBarStyle)style
{
    [self orn_setStatusBarStyle:style animated:NO];
}

- (void)orn_setStatusBarStyle:(ORNStatusBarStyle)style animated:(BOOL)animated
{
    if ([UIDevice orn_isIOS7]) {
        [statusBar removeFromSuperview];
        statusBar = [[ORNStatusBar alloc] init];
        statusBar.ornamentationStyle = style;
        [statusBar ornament];
        [self.keyWindow addSubview:statusBar];
    }
}

- (void)orn_setStatusBarHidden:(BOOL)hidden
{
    [self orn_setStatusBarHidden:hidden animated:NO];
}

- (void)orn_setStatusBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    if ([UIDevice orn_isIOS7]) {
        statusBar.hidden = hidden;
        if (!hidden) {
            [statusBar.superview bringSubviewToFront:statusBar];
        }
    }
}

- (CGRect)orn_statusBarFrame
{
    return statusBar.frame;
}

@end

@implementation ORNStatusBar

@synthesize ornamentationStyle = _ornamentationStyle;

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:(CGRect){.size = {WIDTH, HEIGHT}}]) {
        _backgroundLayer = [ORNGradientLayer layer];
        _borderLayer = [ORNLayer layer];
    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect frame = self.layer.bounds;
    self.backgroundLayer.frame = frame;
    
    CGFloat borderHeight;
    [self orn_getOrnamentMeasurement:&borderHeight position:NULL withOptions:ORNOrnamentTypeBorder];
    frame.origin.y = frame.size.height - borderHeight;
    frame.size.height = borderHeight;
    self.borderLayer.frame = frame;
}

#pragma mark - ORNOrnamentable

- (void)ornament
{
    switch (self.ornamentationStyle) {
        case ORNStatusBarStyleDefault:
            self.backgroundColor = BACKGROUND_COLOR;
            [self ornament:[ORNOrnament lineWithColor:BORDER_COLOR] withOptions:ORNOrnamentTypeBorder];
            break;
        case ORNStatusBarStyleLightContent:
            self.backgroundColor = BACKGROUND_COLOR_LIGHT_CONTENT;
            break;
        case ORNStatusBarStyleLightContentTranslucent:
            self.backgroundColor = BACKGROUND_COLOR_LIGHT_CONTENT_TRANSLUCENT;
            break;
    }

    [self.backgroundLayer colorInView:self withOptions:ORNOrnamentTypeShade, nil];
    [self.borderLayer colorInView:self withOptions:ORNOrnamentTypeBorder, nil];
    [self.layer addSublayer:self.backgroundLayer];
    [self.layer addSublayer:self.borderLayer];
    [self setNeedsLayout];
}

- (void)ornament:(ORNOrnament *)ornament withOptions:(ORNOrnamentOptions)options
{
    [self orn_ornament:ornament withOptions:options];
}

- (BOOL)isOrnamentedWithOptions:(ORNOrnamentOptions)options
{
    return [self orn_isOrnamentedWithOptions:options];
}

- (NSArray *)colorsForOptionsList:(NSArray *)list
{
    return @[SHADE_COLOR];
}

@end
