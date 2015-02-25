//
//  MNSPrimeFlagViewController.m
//  Mensa
//
//  Created by Jordan Kay on 12/7/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "MNSNumber.h"
#import "MNSPrimeFlag.h"
#import "MNSPrimeFlagView.h"
#import "MNSPrimeFlagViewController.h"

@implementation MNSPrimeFlagViewController

#pragma mark - MNSHostedViewController

- (void)updateView:(MNSPrimeFlagView *)view withObject:(MNSPrimeFlag *)flag
{
    if (view.textLabel) {
        view.textLabel.text = [NSString stringWithFormat:view.formatString, flag.number.value];
    }
}

- (UIView *)viewForObject:(MNSPrimeFlag *)flag
{
    [super viewForObject:flag];
    return (self.displayStyle == MNSPrimeFlagDisplayStyleDefault) ? self.defaultView : self.compactView;
}

@end
