//
//  MNSViewHosting.m
//  Mensa
//
//  Created by Jordan Kay on 1/13/14.
//  Copyright (c) 2014 Jordan Kay. All rights reserved.
//

#import "MNSViewHosting.h"
#import "MNSHostedViewController.h"

@implementation MNSViewHosting

+ (void)loadHostedViewForObject:(id)object inCell:(id<MNSHostingCell>)cell
{
    UIView *hostedView = [cell.hostedViewController viewForObject:object];
    NSParameterAssert(hostedView.superview == NULL);

    hostedView.frame = cell.hostingView.bounds;
    hostedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [cell.hostingView addSubview:hostedView];
}

+ (void)setParentViewController:(UIViewController *)parentViewController forCell:(id<MNSHostingCell>)cell withObject:(id)object
{
    if (cell.parentViewController != parentViewController) {
        if (cell.parentViewController) {
            UIView *view = [cell.hostedViewController viewForObject:object];
            [cell.hostedViewController willMoveToParentViewController:nil];
            [view removeFromSuperview];
            [cell.hostedViewController removeFromParentViewController];
        }

        cell.parentViewController = parentViewController;

        if (cell.parentViewController) {
            [cell.parentViewController addChildViewController:cell.hostedViewController];
            [MNSViewHosting loadHostedViewForObject:object inCell:cell];
            [cell.hostedViewController didMoveToParentViewController:cell.parentViewController];
        }
    }
}

+ (void)adjustLayoutConstraintsForCell:(UIView<MNSHostingCell> *)cell contentView:(UIView *)contentView
{
//    [self _adjustConstraintsForCell:cell toPriority:UILayoutPriorityDefaultHigh];
//    [self _addEqualityConstraintsToCell:cell contentView:contentView];
}

+ (void)_adjustConstraintsForCell:(UIView<MNSHostingCell> *)cell toPriority:(UILayoutPriority)priority
{
    UIView *hostedView = cell.hostedViewController.view;
    for (NSLayoutConstraint *constraint in hostedView.constraints) {
        NSLayoutConstraint *adjustedConstraint = [NSLayoutConstraint constraintWithItem:constraint.firstItem attribute:constraint.firstAttribute relatedBy:constraint.relation toItem:constraint.secondItem attribute:constraint.secondAttribute multiplier:constraint.multiplier constant:constraint.constant];
        adjustedConstraint.priority = priority;

        [hostedView removeConstraint:constraint];
        [hostedView addConstraint:adjustedConstraint];
    }
}

+ (void)_addEqualityConstraintsToCell:(UIView<MNSHostingCell> *)cell contentView:(UIView *)contentView
{
    for (NSLayoutAttribute attribute = NSLayoutAttributeWidth; attribute <= NSLayoutAttributeHeight; attribute++) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:cell.hostedViewController.view attribute:attribute multiplier:1.0f constant:0.0f];
        [cell addConstraint:constraint];
    }
}

@end
