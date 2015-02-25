//
//  MNSNumber.m
//  Mensa
//
//  Created by Jordan Kay on 12/6/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "MNSNumber.h"

@interface MNSNumber ()

@property (nonatomic) NSInteger value;
@property (nonatomic) NSArray *factors;
@property (nonatomic, getter = isPrime) BOOL prime;

@end

@implementation MNSNumber

- (instancetype)initWithValue:(NSInteger)value
{
    if (self = [super init]) {
        _value = value;
    }
    return self;
}

- (BOOL)isPrime
{
    return [self.factors count] == 2;
}

- (NSArray *)factors
{
    if (!_factors) {
        NSMutableSet *factors = [NSMutableSet set];
        for (NSInteger i = 1; i <= sqrt(self.value) + 1; i++) {
            if (self.value % i == 0) {
                [factors addObject:@(i)];
                [factors addObject:@(self.value / i)];
            }
        }
        _factors = [[factors allObjects] sortedArrayUsingSelector:@selector(compare:)];
    }
    return _factors;
}

@end
