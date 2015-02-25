//
//  MNSNumber.h
//  Mensa
//
//  Created by Jordan Kay on 12/6/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

@interface MNSNumber : NSObject

- (instancetype)initWithValue:(NSInteger)value;

@property (nonatomic, readonly) NSInteger value;
@property (nonatomic, readonly) NSArray *factors;
@property (nonatomic, readonly, getter = isPrime) BOOL prime;

@end
