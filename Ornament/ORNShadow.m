//
//  ORNShadow.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNShadow.h"


@implementation ORNShadow

#pragma mark ORNOrnament

- (void)getMeasurement:(CGFloat *)measurement position:(ORNPosition *)position
{
    if (measurement) *measurement = self.blur;
    if (position) *position = self.position;
}

- (ORNOrnamentOptions)implicitOptions
{
    return ORNOrnamentTypeShadow;
}

@end
