//
//  MNSPrimeFlag.h
//  Mensa
//
//  Created by Jordan Kay on 12/7/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

@class MNSNumber;

@interface MNSPrimeFlag : NSObject

- (instancetype)initWithNumber:(MNSNumber *)number;

@property (nonatomic, readonly) MNSNumber *number;

@end
