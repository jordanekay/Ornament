//
//  ORNLayer.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNLayer.h"
#import "ORNOrnament.h"

@implementation ORNLayer

@synthesize needsRecoloringOnLayout = _needsRecoloringOnLayout;

#pragma mark ORNColorable

- (void)colorInView:(UIView<ORNOrnamentable> *)view withOptions:(ORNOrnamentOptions)options, ...
{
    UIColor *color = [view orn_ornamentWithOptions:options].color;
    self.backgroundColor = color.CGColor;
}

@end
