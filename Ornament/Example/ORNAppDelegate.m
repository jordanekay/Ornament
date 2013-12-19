//
//  ORNAppDelegate.m
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNAppearance.h"
#import "ORNAppDelegate.h"
#import "ORNDemoTableViewController.h"
#import "ORNNavigationController.h"
#import "UIApplication+ORNStatusBar.h"
#import "UIColor+ORNAdditions.h"
#import "UIDevice+ORNVersion.h"

@implementation ORNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [ORNAppearance setupAppearance];
    
    [application orn_setStatusBarStyle:ORNStatusBarStyleDefault];
    ORNDemoTableViewController *tableViewController = [[ORNDemoTableViewController alloc] initWithTableViewStyle:ORNTableViewStyleGrouped];
    ORNNavigationController *navigationController = [[ORNNavigationController alloc] initWithRootViewController:tableViewController];
    self.window.rootViewController = navigationController;
    [application orn_setStatusBarHidden:NO];

    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if ([UIDevice orn_isIOS7]) {
        CGRect frame = navigationController.view.frame;
        frame.origin.y += statusBarHeight;
        frame.size.height -= statusBarHeight;
        navigationController.view.frame = frame;
    } else {
        CGRect frame = navigationController.navigationBar.frame;
        frame.size.height += statusBarHeight;
        navigationController.navigationBar.frame = frame;
    }

    return YES;
}

@end
