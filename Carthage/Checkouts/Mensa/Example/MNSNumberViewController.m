//
//  MNSNumberViewController.m
//  Mensa
//
//  Created by Jonathan Wight on 7/26/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "MNSNumber.h"
#import "MNSNumberView.h"
#import "MNSNumberViewController.h"

@implementation MNSNumberViewController

#pragma mark - MNSHostedViewController

- (void)updateView:(MNSNumberView *)view withObject:(MNSNumber *)number
{
    view.valueLabel.text = [NSString stringWithFormat:@"%ld", number.value];
}

- (void)selectObject:(MNSNumber *)number
{
    NSString *factorsString = [number.factors componentsJoinedByString:@", "];
    NSString *message = [NSString stringWithFormat:@"The factors of %ld are %@.", number.value, factorsString];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alertView show];
}

@end
