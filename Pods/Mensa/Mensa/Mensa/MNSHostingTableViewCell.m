//
//  MNSHostingTableViewCell.m
//  Mensa
//
//  Created by Jonathan Wight on 7/18/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import <objc/runtime.h>
#import "MNSHostingTableViewCell.h"

@implementation MNSHostingTableViewCell

- (void)loadHostedViewForObject:(id)object
{
    UIView *hostedView = [self.hostedViewController viewForObject:object];
    NSParameterAssert(hostedView.superview == NULL);

    hostedView.frame = self.contentView.bounds;
    hostedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:hostedView];
}

- (void)useAsMetricsCellInTableView:(UITableView *)tableView
{
    // Subclasses implement
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

- (void)setParentViewController:(UIViewController *)parentViewController withObject:(id)object
{
    if (_parentViewController != parentViewController) {
        if (_parentViewController) {
            UIView *view = [self.hostedViewController viewForObject:object];
            [self.hostedViewController willMoveToParentViewController:nil];
            [view removeFromSuperview];
            [self.hostedViewController removeFromParentViewController];
        }

        _parentViewController = parentViewController;

        if (_parentViewController) {
            [_parentViewController addChildViewController:self.hostedViewController];
            [self loadHostedViewForObject:object];
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

        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

@end
