//
//  MNSHostedViewController.m
//  Mensa
//
//  Created by Jordan Kay on 12/6/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "MNSHostingTableViewCell.h"
#import "MNSHostedViewController.h"

@implementation MNSHostedViewController

- (void)updateView:(UIView *)view withObject:(id)object
{
    // Subclasses implement
}

- (void)selectObject:(id)object
{
    // Subclasses implement
}

- (BOOL)canSelectObject:(id)object
{
    return YES;
}

- (UIView *)viewForObject:(id)object
{
    return self.view;
}

@end
