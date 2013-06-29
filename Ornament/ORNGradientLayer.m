//
//  ORNGradientLayer.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNGradientLayer.h"

@implementation ORNGradientLayer

@synthesize needsRecoloringOnLayout = _needsRecoloringOnLayout;

#pragma mark ORNColorable

- (void)colorInView:(UIView<ORNOrnamentable> *)view withOptions:(ORNOrnamentOptions)options
{
    UIColor *color = [view orn_ornamentWithOptions:options].color;
    self.colors = @[(id)[UIColor clearColor].CGColor, (id)color.CGColor];
}

@end
