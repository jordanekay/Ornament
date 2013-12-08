//
//  ORNGradientLayer.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "NSArray+ORNFunctional.h"
#import "ORNOrnament.h"
#import "ORNOrnamentMacros.h"
#import "ORNGradientLayer.h"

@implementation ORNGradientLayer

@synthesize needsRecoloringOnLayout = _needsRecoloringOnLayout;

#pragma mark ORNColorable

- (void)colorInView:(UIView<ORNOrnamentable> *)view withOptions:(ORNOrnamentOptions)options, ...
{
    NSMutableArray *optionsList = [NSMutableArray array];
    ORN_MAKE_OPTIONS_LIST(optionsList, options);
    NSMutableArray *colors = [NSMutableArray arrayWithArray:[view colorsForOptionsList:optionsList]];

    if ([colors count] == 1) {
        [colors insertObject:[UIColor clearColor] atIndex:0];
    }

    self.colors = [colors orn_mapWithBlock:^(UIColor *color, NSUInteger idx) {
        return (id)color.CGColor;
    }];
}

@end
