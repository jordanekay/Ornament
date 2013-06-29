//
//  ORNLine.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNLine.h"

@implementation ORNLine

#pragma mark ORNOrnament

- (void)getMeasurement:(CGFloat *)measurement position:(ORNPosition *)position
{
    if (measurement) *measurement = self.width;
}

- (ORNOrnamentOptions)implicitOptions
{
    return 0;
}

@end
