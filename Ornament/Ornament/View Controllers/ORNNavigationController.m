//
//  ORNNavigationController.m
//  Ornament
//
//  Created by Jordan Kay on 11/28/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <objc/runtime.h>
#import "ORNNavigationBar.h"
#import "ORNNavigationController.h"
#import "ORNSwizzle.h"
#import "UIDevice+ORNVersion.h"

#define ANIMATION_DURATION .35

@interface ORNNavigationController ()

@property (nonatomic, copy) NSArray *viewControllers;

@end

@interface ORNNavigationItem : UINavigationItem

@property (nonatomic, weak) ORNNavigationBar *navigationBar;

@end

@implementation ORNNavigationController
{
    UIView *_viewToPush;
    ORNNavigationBarStyle _navigationBarStyle;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    return [self initWithRootViewController:rootViewController navigationBarStyle:ORNNavigationBarStyleBlue];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController navigationBarStyle:(ORNNavigationBarStyle)style
{
    if (self = [super initWithNibName:@"ORNNavigationController" bundle:[NSBundle mainBundle]]) {
        _navigationBarStyle = style;
        _viewControllers = [NSArray array];
        [self pushViewController:rootViewController animated:NO];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *lastViewController = [self.viewControllers lastObject];
    self.viewControllers = [self.viewControllers arrayByAddingObject:viewController];

    _viewToPush = self.view;
    ORNNavigationItem *item = [[ORNNavigationItem alloc] initWithTitle:viewController.title];
    item.navigationBar = self.navigationBar;
    [viewController orn_setNavigationController:self];

    [self _replaceViewController:lastViewController withViewController:viewController animated:animated];
    [self.navigationBar pushNavigationItem:item animated:animated];
    _viewToPush = nil;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    UIViewController *viewController = [viewControllers lastObject];
    [viewControllers removeObject:viewController];
    self.viewControllers = viewControllers;

    if ([viewControllers count]) {

    } else {
        [viewController willMoveToParentViewController:nil];
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }
    [self.navigationBar popNavigationItemAnimated:animated];

    return viewController;
}

- (void)setNavigationBarStyle:(ORNNavigationBarStyle)navigationBarStyle
{
    self.navigationBar.ornamentationStyle = navigationBarStyle;
    [self.navigationBar ornament];
}

- (ORNNavigationBarStyle)navigationBarStyle
{
    return self.navigationBar.ornamentationStyle;
}

- (UIViewController *)visibleViewController
{
    return [self.viewControllers lastObject];
}

- (void)setVisibleViewController:(UIViewController *)visibleViewController
{
    [self popViewControllerAnimated:NO];
    [self pushViewController:visibleViewController animated:NO];
}

- (void)_replaceViewController:(UIViewController *)lastViewController withViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    CGRect frame = self.view.bounds;
    frame.origin.x += frame.size.width;
    viewController.view.frame = frame;

    [self addChildViewController:viewController];
    [self.view insertSubview:viewController.view belowSubview:self.navigationBar];
    [viewController didMoveToParentViewController:self];

    frame.origin.x = 0;
    if (animated) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            viewController.view.frame = frame;
        }];
    } else {
        viewController.view.frame = frame;
    }

    if (lastViewController) {
        frame = lastViewController.view.frame;
        frame.origin.x -= frame.size.width;
        if (animated) {
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
                lastViewController.view.frame = frame;
            }];
        } else {
            lastViewController.view.frame = frame;
        }
    }

    frame = viewController.view.frame;
    if (!viewController.wantsFullScreenLayout) {
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        frame.origin.y += statusBarHeight;
        frame.size.height -= statusBarHeight;
    }
    if (!self.navigationBar.isTranslucentStyle) {
        CGFloat navigationBarHeight = self.navigationBar.bounds.size.height;
        frame.origin.y += navigationBarHeight;
        frame.size.height -= navigationBarHeight;
    }
    viewController.view.frame = frame;
}

#pragma mark - NSObject

+ (void)initialize
{
    if (self == [ORNNavigationController class]) {
        ORNSwizzle([UIViewController class], @selector(navigationItem), @selector(orn_navigationItem));
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBarStyle = _navigationBarStyle;

    if ([UIDevice orn_isIOS7]) {
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        for (NSLayoutConstraint *constraint in self.view.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeTop) {
                constraint.constant += statusBarHeight;
            }
        }
    }
}

- (BOOL)shouldAutorotate
{
    return [self.visibleViewController shouldAutorotate];
}

@end

@implementation ORNNavigationItem
{
    NSMutableDictionary *_barButtonActions;
}

@synthesize navigationBar = navigationBar_;

- (void)setNavigationBar:(ORNNavigationBar *)navigationBar
{
    navigationBar_ = navigationBar;
    navigationBar.item = self;
}

- (void)_barButtonAction:(UIButton *)sender
{
    [_barButtonActions[@(sender.hash)] invoke];
}

#pragma mark - UINavigationItem

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super initWithTitle:title]) {
        _barButtonActions = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)buttonItem
{
    [self _setBarButton:self.navigationBar.leftBarButton forBarButtonItem:buttonItem];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)buttonItem
{
    [self _setBarButton:self.navigationBar.rightBarButton forBarButtonItem:buttonItem];
}

- (void)_setBarButton:(UIButton *)button forBarButtonItem:(UIBarButtonItem *)item
{
    if (item) {
        [button setTitle:item.title forState:UIControlStateNormal];
        button.selected = (item.style == UIBarButtonItemStyleDone);
        button.hidden = NO;
    } else {
        [button setTitle:nil forState:UIControlStateNormal];
        button.selected = NO;
        button.hidden = YES;
    }

    if (item.action) {
        NSMethodSignature *signature = [[item.target class] instanceMethodSignatureForSelector:item.action];
        NSInvocation *action = [NSInvocation invocationWithMethodSignature:signature];
        action.target = item.target;
        action.selector = item.action;
        _barButtonActions[@(button.hash)] = action;

        [button removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(_barButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end

@implementation UIViewController (ORNNavigationController)

- (void)orn_setNavigationController:(ORNNavigationController *)navigationController
{
    objc_setAssociatedObject(self, @selector(orn_navigationController), navigationController, OBJC_ASSOCIATION_ASSIGN);
}

- (ORNNavigationController *)orn_navigationController
{
    return objc_getAssociatedObject(self, @selector(orn_navigationController));
}

- (UINavigationItem *)orn_navigationItem
{
    return [self orn_navigationController] ? [self orn_navigationController].navigationBar.item : [self orn_navigationItem];
}

@end
