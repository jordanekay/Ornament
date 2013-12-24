//
//  ORNPropertyViewController.m
//  Ornament
//
//  Created by Jordan Kay on 12/21/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNPropertyViewController.h"

@implementation ORNPropertyViewController

#pragma mark - MNSHostedViewController

- (UIView *)viewForObject:(id)object
{
    UIView *view = [super viewForObject:object];
    UIView *propertyView = (self.displayStyle == ORNPropertyDisplayStyleLight) ? self.lightPropertyView : self.darkPropertyView;
    return propertyView ?: view;
}

@end
