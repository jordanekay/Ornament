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

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [(ORNNavigationBar *)self.navigationBar ornament];
}

#pragma mark - UINavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithNavigationBarClass:[ORNNavigationBar class] toolbarClass:nil]) {
        [self pushViewController:rootViewController animated:NO];
    }
    return self;
}

@end
