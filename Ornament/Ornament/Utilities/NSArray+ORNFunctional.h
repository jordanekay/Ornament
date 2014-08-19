//
//  NSArray+ORNFunctional.h
//  Ornament
//
//  Created by Jordan Kay on 11/27/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ORNFunctional)

- (NSArray *)orn_mapWithBlock:(id (^)(id obj, NSUInteger idx))block;

@end
