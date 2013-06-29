//
//  ORNSwitch.m
//  Ornament
//
//  Created by Jordan Kay on 8/12/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNSwitch.h"

@implementation ORNSwitch

- (void)_valueChanged
{
    if (self.containingCellIndexPath && [self.delegate respondsToSelector:@selector(switch:didSetOn:forIndexPath:)]) {
        [self.delegate switch:self didSetOn:self.isOn forIndexPath:self.containingCellIndexPath];
    }
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(_valueChanged) forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

#pragma mark - ORNBoolean

- (void)setValue:(BOOL)value
{
    self.on = value;
}

- (BOOL)value
{
    return self.isOn;
}

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

- (void)getOrnamentMeasurement:(CGFloat *)measurement position:(ORNPosition *)position withOptions:(ORNOrnamentOptions)options
{
    [self orn_getOrnamentMeasurement:measurement position:position withOptions:options];
}

@end
