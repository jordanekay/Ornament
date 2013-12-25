//
//  ORNGroupedTableViewCell.m
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNColorable.h"
#import "ORNGradientLayer.h"
#import "ORNLayer.h"
#import "ORNShadowLayer.h"
#import "ORNSwitch.h"
#import "ORNTableView.h"
#import "ORNTableViewConstants.h"
#import "ORNTableViewCell.h"
#import "ORNTableViewController.h"
#import "UIColor+ORNAdditions.h"
#import "UIDevice+ORNVersion.h"
#import "UIFont+ORNSystem.h"

#define ACCESSORY_PADDING ([UIDevice orn_isIOS7] ? -9.0f : 16.0f)
#define IMAGE_PADDING ([UIDevice orn_isIOS7] ? -4.0f : 2.0f)
#define CONTROL_PADDING ([UIDevice orn_isIOS7] ? -4.0f : 1.0f)
#define LAYOUT_ADJUSTMENT ([UIDevice orn_isIOS7] ? 1.0f : 0.0f)
#define ANIMATION_DURATION .5f

@interface ORNTableViewCell ()

@property (nonatomic) ORNLayer *separatorLayer;
@property (nonatomic) ORNLayer *borderLayer;
@property (nonatomic) ORNShadowLayer *innerShadowLayer;
@property (nonatomic) ORNShadowLayer *highlightedInnerShadowLayer;
@property (nonatomic) ORNGradientLayer *shadeLayer;
@property (nonatomic) ORNGradientLayer *highlightedShadeLayer;
@property (nonatomic) UIImageView *backgroundView;
@property (nonatomic, readonly) UIView *containerView;
@property (nonatomic, readonly) UIRectCorner roundedCorners;

@end

@implementation ORNTableViewCell
{
    UIEdgeInsets _insets;
    CGFloat _radius;
    CGFloat _borderWidth;
    CGFloat _strokeWidth;
}

- (UIImage *)customBackgroundImageForRoundedCorners:(UIRectCorner)corners
{
    return nil;
}

- (UIImage *)customHighlightedBackgroundImageForRoundedCorners:(UIRectCorner)corners
{
    return nil;
}

- (void)setHostTableView:(ORNTableView *)hostTableView
{
    if (_hostTableView != hostTableView) {
        _hostTableView = hostTableView;

        self.backgroundColor = [UIColor clearColor];
        _separatorLayer.backgroundColor = hostTableView.separatorColor.CGColor;

        [hostTableView orn_getOrnamentMeasurement:&_radius position:&_insets withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeLayout];
        [hostTableView orn_getOrnamentMeasurement:&_strokeWidth position:NULL withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeStroke];
        [hostTableView orn_getOrnamentMeasurement:&_borderWidth position:NULL withOptions:ORNOrnamentTableViewScopeCell | ORNOrnamentTypeBorder];

        [self _addBorderLayer];
        [self _addInnerShadowLayers];
        [self _addShadeLayers];
    }
}

- (void)setSectionBreakAbove:(BOOL)sectionBreakAbove
{
    if (_sectionBreakAbove != sectionBreakAbove) {
        _sectionBreakAbove = sectionBreakAbove;
        _borderLayer.hidden = sectionBreakAbove;
    }
}

- (void)setSectionBreakBelow:(BOOL)sectionBreakBelow
{
    if (_sectionBreakBelow != sectionBreakBelow) {
        _sectionBreakBelow = sectionBreakBelow;
        _separatorLayer.hidden = sectionBreakBelow;

        CGFloat cornerRadius = sectionBreakBelow ? (_radius - _strokeWidth) : 0.0f;
        _shadeLayer.cornerRadius = cornerRadius;
        _highlightedShadeLayer.cornerRadius = cornerRadius;
    }
}

- (ORNLayer *)separatorLayer
{
    return _separatorLayer ?: (_separatorLayer = [ORNLayer layer]);
}

- (ORNLayer *)borderLayer
{
    return _borderLayer ?: (_borderLayer = [ORNLayer layer]);
}

- (ORNShadowLayer *)innerShadowLayer
{
    return _innerShadowLayer ?: (_innerShadowLayer = [ORNShadowLayer layer]);
}

- (ORNShadowLayer *)highlightedInnerShadowLayer
{
    return _highlightedInnerShadowLayer ?: (_highlightedInnerShadowLayer = [ORNShadowLayer layer]);
}

- (ORNGradientLayer *)shadeLayer
{
    return _shadeLayer ?: (_shadeLayer = [ORNGradientLayer layer]);
}

- (ORNGradientLayer *)highlightedShadeLayer
{
    return _highlightedShadeLayer ?: (_highlightedShadeLayer = [ORNGradientLayer layer]);
}

- (UIView *)containerView
{
    return [self.contentView.subviews firstObject];
}

- (UIRectCorner)roundedCorners
{
    UIRectCorner roundedCorners = ~UIRectCornerAllCorners;
    if (self.sectionBreakAbove) {
        roundedCorners |= (UIRectCornerTopLeft | UIRectCornerTopRight);
    }
    if (self.sectionBreakBelow) {
        roundedCorners |= (UIRectCornerBottomLeft | UIRectCornerBottomRight);
    }
    return roundedCorners;
}

- (void)_addBorderLayer
{
    ORNOrnamentOptions options = ORNOrnamentTableViewScopeCell | ORNOrnamentTypeBorder;
    if ([self.hostTableView isOrnamentedWithOptions:options]) {
        [self.layer addSublayer:self.borderLayer];
        [self _fillBorderLayerHighlighted:NO];
    }
}

- (void)_addInnerShadowLayers
{
    ORNOrnamentOptions options = ORNOrnamentTableViewScopeSection | ORNOrnamentTypeShadow | ORNOrnamentShadowPositionSides;
    ORNShadowLayer *layer = [self.hostTableView isOrnamentedWithOptions:options | ORNOrnamentStateDefault] ? self.innerShadowLayer : nil;
    ORNShadowLayer *highlightedLayer = [self.hostTableView isOrnamentedWithOptions:options | ORNOrnamentStateHighlighted] ? self.highlightedInnerShadowLayer : nil;

    CGFloat radius = _radius - _strokeWidth * 2;
    CGFloat separatorHeight = self.hostTableView.separatorHeight;
    layer.horizontalInset = _strokeWidth;
    layer.verticalInset = separatorHeight;
    layer.cornerRadius = radius;
    highlightedLayer.horizontalInset = _strokeWidth;
    highlightedLayer.verticalInset = separatorHeight;
    highlightedLayer.cornerRadius = radius;
    [self _addLayer:layer highlightedLayer:highlightedLayer withOptions:options];
}

- (void)_addShadeLayers
{
    ORNOrnamentOptions options = ORNOrnamentTableViewScopeCell | ORNOrnamentTypeShade;
    ORNGradientLayer *layer = [self.hostTableView isOrnamentedWithOptions:options | ORNOrnamentStateDefault] ? self.shadeLayer : nil;
    ORNGradientLayer *highlightedLayer = [self.hostTableView isOrnamentedWithOptions:options | ORNOrnamentStateHighlighted] ? self.highlightedShadeLayer : nil;
    [self _addLayer:layer highlightedLayer:highlightedLayer withOptions:options];
}

- (void)_addLayer:(CALayer<ORNColorable> *)layer highlightedLayer:(CALayer<ORNColorable> *)highlightedLayer withOptions:(ORNOrnamentOptions)options
{
    [self _colorLayer:layer withOptions:options | ORNOrnamentStateDefault];
    [self _colorLayer:highlightedLayer withOptions:options | ORNOrnamentStateHighlighted];
}

- (void)_colorLayer:(CALayer<ORNColorable> *)layer withOptions:(ORNOrnamentOptions)options
{
    [self.backgroundView.layer addSublayer:layer];
    layer.hidden = !!(options | ORNOrnamentStateHighlighted);
    if (!layer.needsRecoloringOnLayout) {
        [layer colorInView:self.hostTableView withOptions:options, nil];
    }
}

- (void)_layoutBackgroundView
{
    CGFloat separatorHeight = self.hostTableView.separatorHeight;
    CGRect backgroundFrame = self.layer.bounds;
    CGRect containerFrame = backgroundFrame;

    backgroundFrame.origin.y -= (_insets.top + _radius);
    backgroundFrame.size.height += (_insets.top + _insets.bottom + _radius * 2);
    containerFrame.origin.x += (_insets.left + separatorHeight);
    containerFrame.size.width -= (_insets.left + _insets.right + separatorHeight * 2);

    if (self.sectionBreakAbove) {
        backgroundFrame.origin.y += (_insets.top + _radius);
        backgroundFrame.size.height -= (_insets.top + _radius);
        containerFrame.origin.y += (_insets.top + separatorHeight);
        containerFrame.size.height -= (_insets.top + separatorHeight);
    }
    if (self.sectionBreakBelow) {
        backgroundFrame.size.height -= (_insets.bottom + _radius);
        containerFrame.size.height -= (_insets.top + separatorHeight);
    }

    self.backgroundView.frame = backgroundFrame;
    self.containerView.frame = containerFrame;
}

- (void)_layoutSeparatorLayer
{
    if (_separatorLayer) {
        CGRect separatorFrame = self.layer.bounds;
        CGFloat separatorHeight = self.hostTableView.separatorHeight;
        // TODO: Cell border too
        separatorFrame.origin.x += (_insets.left + _strokeWidth);
        separatorFrame.origin.y = separatorFrame.size.height - separatorHeight;
        separatorFrame.size.width -= (_insets.left + _insets.right + _strokeWidth * 2);
        separatorFrame.size.height = separatorHeight;
        _separatorLayer.frame = separatorFrame;
    }
}

- (void)_layoutBorderLayer
{
    if (_borderLayer) {
        CGRect borderFrame = self.separatorLayer.frame;
        borderFrame.origin.y = 0.0f;
        borderFrame.size.height = _borderWidth;
        _borderLayer.frame = borderFrame;
    }
}

- (void)_fillBorderLayerHighlighted:(BOOL)highlighted
{
    ORNOrnamentOptions options = ORNOrnamentTableViewScopeCell | ORNOrnamentTypeBorder | (highlighted ? ORNOrnamentStateHighlighted : ORNOrnamentStateDefault);
    [self.borderLayer colorInView:self.hostTableView withOptions:options, nil];
}

- (void)_layoutInnerLayer:(CALayer *)layer overStroke:(BOOL)overStroke
{
    if (layer) {
        CGFloat strokeWidth = overStroke ? 0.0f : _strokeWidth;
        CGRect frame = self.backgroundView.bounds;
        frame.origin.x += (_insets.left + strokeWidth);
        frame.origin.y += (_insets.top + strokeWidth);
        frame.size.width -= (_insets.left + _insets.right + strokeWidth * 2);
        frame.size.height -= (_insets.top + _insets.bottom + strokeWidth * 2);

        CGFloat separatorHeight = self.hostTableView.separatorHeight;
        if (!self.sectionBreakAbove) {
            frame.origin.y += (_radius - separatorHeight);
            frame.size.height -= (_radius - separatorHeight);
        }
        if (!self.sectionBreakBelow && _radius > MIN_SECTION_CORNER_RADIUS) {
            frame.size.height -= (_radius + (overStroke ? _strokeWidth : 0.0f));
        }

        layer.frame = frame;
    }
}

- (void)_colorInnerShadowLayers
{
    UIRectCorner roundedCorners = self.roundedCorners;
    ORNOrnamentOptions options = ORNOrnamentTableViewScopeSection | ORNOrnamentTypeShadow | ORNOrnamentShadowPositionSides;

    if (_innerShadowLayer) {
        _innerShadowLayer.roundedCorners = roundedCorners;
        if (_innerShadowLayer.needsRecoloringOnLayout) {
            [_innerShadowLayer colorInView:self.hostTableView withOptions:options | ORNOrnamentStateDefault, nil];
        }
    }
    if (_highlightedInnerShadowLayer) {
        _highlightedInnerShadowLayer.roundedCorners = roundedCorners;
        if (_highlightedInnerShadowLayer.needsRecoloringOnLayout) {
            [_highlightedInnerShadowLayer colorInView:self.hostTableView withOptions:options | ORNOrnamentStateHighlighted, nil];
        }
    }
}

- (void)_setContainerViewHighlighted:(BOOL)highlighted
{
    if (self.highlightsContents) {
        for (UIView *view in self.containerView.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                ((UILabel *)view).highlighted = highlighted;
            } else if ([view isKindOfClass:[UIImageView class]]) {
                ((UIImageView *)view).highlighted = highlighted;
            }
        }
    }
}

- (void)_unhighlightContainerView
{
    [self _setContainerViewHighlighted:NO];
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self _layoutBackgroundView];

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self _layoutSeparatorLayer];
    [self _layoutBorderLayer];
    [self _layoutInnerLayer:_innerShadowLayer overStroke:YES];
    [self _layoutInnerLayer:_shadeLayer overStroke:NO];
    [self _colorInnerShadowLayers];
    [CATransaction commit];
}

#pragma mark - UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];

        self.layer.masksToBounds = YES;
        [self.layer addSublayer:self.separatorLayer];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:YES];

    if (highlighted) {
        self.backgroundView.image = [self customBackgroundImageForRoundedCorners:self.roundedCorners] ?: self.hostTableView.highlightedBackgroundImage;
         [self _setContainerViewHighlighted:YES];
    } else {
        self.backgroundView.image = [self customHighlightedBackgroundImageForRoundedCorners:self.roundedCorners] ?: self.hostTableView.backgroundImage;
        [self _setContainerViewHighlighted:NO];
    }

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _innerShadowLayer.hidden = highlighted;
    _shadeLayer.hidden = highlighted;
    _highlightedShadeLayer.hidden = !highlighted;
    _highlightedInnerShadowLayer.hidden = !highlighted;
    if (highlighted) {
        [self _fillBorderLayerHighlighted:YES];
        [self _layoutInnerLayer:_highlightedInnerShadowLayer overStroke:YES];
        [self _layoutInnerLayer:_highlightedShadeLayer overStroke:NO];
    } else {
        [self _fillBorderLayerHighlighted:NO];
    }
    [CATransaction commit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (!selected && animated) {
        self.backgroundView.image = self.hostTableView.highlightedBackgroundImage;
        [self _fillBorderLayerHighlighted:YES];
        [self _setContainerViewHighlighted:YES];
        self.userInteractionEnabled = NO;
        [UIView transitionWithView:self.backgroundView duration:ANIMATION_DURATION options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.backgroundView.image = self.hostTableView.backgroundImage;
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
        [CATransaction begin];
        [CATransaction setAnimationDuration:ANIMATION_DURATION * 2];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [self _fillBorderLayerHighlighted:NO];
        [CATransaction commit];
        [self performSelector:@selector(_unhighlightContainerView) withObject:nil afterDelay:ANIMATION_DURATION / 2];
    }
}

- (UITableViewCellSelectionStyle)selectionStyle
{
    return UITableViewCellSelectionStyleNone;
}

#pragma mark - MNSHostingTableViewCell

- (void)useAsMetricsCellInTableView:(ORNTableView *)tableView
{
    UIEdgeInsets insets;
    [tableView orn_getOrnamentMeasurement:NULL position:&insets withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeLayout];
    self.layoutInsets = insets;
}

@end
