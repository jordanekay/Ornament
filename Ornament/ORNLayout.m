//
//  ORNLayout.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNLayout.h"

@implementation ORNLayout

#pragma mark ORNOrnament

- (void)getMeasurement:(CGFloat *)measurement position:(ORNPosition *)position
{
    if (measurement) *measurement = self.radius;
    if (position) *position = self.insets;
}

- (ORNOrnamentOptions)implicitOptions
{
    return ORNOrnamentTypeLayout;
}

@end
