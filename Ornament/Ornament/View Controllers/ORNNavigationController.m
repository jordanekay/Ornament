//
//  ORNNavigationController.m
//  Ornament
//
//  Created by Jordan Kay on 11/28/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNNavigationBar.h"
#import "ORNNavigationController.h"
#import "UIDevice+ORNVersion.h"

#define ANIMATION_DURATION .35

@interface ORNNavigationController ()

@property (nonatomic, copy) NSArray *viewControllers;

@end

@implementation ORNNavigationController
{
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
    [self _replaceViewController:lastViewController withViewController:viewController animated:animated];

    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:viewController.title];
    [self.navigationBar pushNavigationItem:item animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    UIViewController *viewController = [viewControllers lastObject];
    [viewControllers removeObject:viewController];
    self.viewControllers = viewControllers;
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

//- (void)setViewControllers:(NSArray *)viewControllers
//{
//    if (_viewControllers != viewControllers) {
//        _viewControllers = [viewControllers copy];
//        NSLog(@"%@", [[viewControllers lastObject] title]);
//    }
//}

- (void)_replaceViewController:(UIViewController *)lastViewController withViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    CGRect frame = self.view.bounds;
    frame.origin.x += frame.size.width;
    frame.origin.y = self.navigationBar.bounds.size.height;
    frame.size.height -= frame.origin.y;
    if ([UIDevice orn_isIOS7]) {
        frame.origin.y -= [UIApplication sharedApplication].statusBarFrame.size.height;
    }
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
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBarStyle = _navigationBarStyle;
}

//- (BOOL)shouldAutorotate
//{
////    return [self.visibleViewController shouldAutorotate];
//}

@end
