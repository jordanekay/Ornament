//
//  MNSPrimeFlag.m
//  Mensa
//
//  Created by Jordan Kay on 12/7/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "MNSNumber.h"
#import "MNSPrimeFlag.h"

@interface MNSPrimeFlag ()

@property (nonatomic) MNSNumber *number;

@end

@implementation MNSPrimeFlag

- (instancetype)initWithNumber:(MNSNumber *)number
{
    if (self = [super init]) {
        _number = number;
    }
    return self;
}

@end
