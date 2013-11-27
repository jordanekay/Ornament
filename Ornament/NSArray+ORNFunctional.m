//
//  NSArray+ORNFunctional.m
//  Ornament
//
//  Created by Jordan Kay on 11/27/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "NSArray+ORNFunctional.h"

@implementation NSArray (ORNFunctional)

- (NSArray *)orn_mapWithBlock:(id (^)(id obj, NSUInteger idx))block
{
    if (!block) {
        return self;
    }

    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id object = block(obj, idx);
        if (object) {
            [result addObject:block(obj, idx)];
        }
    }];
    return result;
}

@end
