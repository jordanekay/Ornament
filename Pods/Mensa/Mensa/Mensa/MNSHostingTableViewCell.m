//
//  MNSHostingTableViewCell.m
//  Mensa
//
//  Created by Jonathan Wight on 7/18/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <objc/runtime.h>
#import "MNSHostingTableViewCell.h"

@interface MNSHostingTableViewCell ()

@end

@implementation MNSHostingTableViewCell

- (void)loadHostedView
{
    NSParameterAssert(self.hostedViewController.view.superview == NULL);
    UIView *hostedView = self.hostedViewController.view;
    hostedView.frame = self.contentView.bounds;
    hostedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:hostedView];
}

+ (Class)subclassWithViewControllerClass:(Class)viewControllerClass
{
	NSString *className = [NSString stringWithFormat:@"%@_%@", NSStringFromClass(self), NSStringFromClass(viewControllerClass)];
    Class class = NSClassFromString(className);
    if (!class) {
        class = objc_allocateClassPair(self, [className UTF8String], 0);
        id (^block)(id) = ^(id self) {
            return viewControllerClass;
        };
        IMP implementation = imp_implementationWithBlock([block copy]);
        // #@: == return a class (#), self (@), cmd selector (:)
        class_addMethod(class, NSSelectorFromString(@"hostedViewControllerClass"), implementation, "#@:");
        objc_registerClassPair(class);
    }
	return class;
}

- (void)setParentViewController:(UIViewController *)parentViewController
{
    if (_parentViewController != parentViewController) {
        if (_parentViewController) {
            [self.hostedViewController willMoveToParentViewController:nil];
            [self.hostedViewController.view removeFromSuperview];
            [self.hostedViewController removeFromParentViewController];
        }

        _parentViewController = parentViewController;

        if (_parentViewController) {
            [_parentViewController addChildViewController:self.hostedViewController];
            [self loadHostedView];
            [self.hostedViewController didMoveToParentViewController:_parentViewController];
        }
    }
}

#pragma mark - UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		Class class = self.hostedViewControllerClass;
		_hostedViewController = [[class alloc] initWithNibName:NSStringFromClass(class) bundle:nil];
    }
    return self;
}

@end
