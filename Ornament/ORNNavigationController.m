//
//  ORNNavigationController.m
//  Ornament
//
//  Created by Jordan Kay on 11/28/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNNavigationBar.h"
#import "ORNNavigationController.h"

@implementation ORNNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController navigationBarStyle:(ORNNavigationBarStyle)style
{
    if (self = [super initWithNavigationBarClass:[ORNNavigationBar class] toolbarClass:nil]) {
        ((ORNNavigationBar *)self.navigationBar).ornamentationStyle = style;
        [self pushViewController:rootViewController animated:NO];
    }
    return self;
}

- (void)setNavigationBarStyle:(ORNNavigationBarStyle)navigationBarStyle
{
    ORNNavigationBar *navigationBar = (ORNNavigationBar *)self.navigationBar;
    navigationBar.ornamentationStyle = navigationBarStyle;
    [CATransaction commit];
    [CATransaction setDisableActions:YES];
    [navigationBar ornament];
    [CATransaction begin];
}

- (ORNNavigationBarStyle)navigationBarStyle
{
    return ((ORNNavigationBar *)self.navigationBar).ornamentationStyle;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [(ORNNavigationBar *)self.navigationBar ornament];
}

#pragma mark - UINavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    return [self initWithRootViewController:rootViewController navigationBarStyle:ORNNavigationBarStyleBlue];
}

@end
