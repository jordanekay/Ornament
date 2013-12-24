//
//  ORNSwitch.m
//  Ornament
//
//  Created by Jordan Kay on 8/12/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNSwitch.h"

@implementation ORNSwitch

@synthesize ornamentationStyle = _ornamentationStyle;

#pragma mark - ORNOrnamentable

- (void)ornament
{

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
    return nil;
}

@end
