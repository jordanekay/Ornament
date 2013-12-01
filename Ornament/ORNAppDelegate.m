//
//  ORNAppDelegate.m
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNAppDelegate.h"
#import "ORNDemoTableViewController.h"
#import "ORNNavigationController.h"
#import "UIApplication+ORNStatusBar.h"
#import "UIColor+ORNAdditions.h"

@implementation ORNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    [application orn_setStatusBarStyle:ORNStatusBarStyleDefault];
    ORNDemoTableViewController *tableViewController = [[ORNDemoTableViewController alloc] initWithOrnamentationStyle:ORNTableViewStyleGroupedEtched];
    ORNNavigationController *navigationController = [[ORNNavigationController alloc] initWithRootViewController:tableViewController];
    self.window.rootViewController = navigationController;
    [application orn_setStatusBarHidden:NO];
    
    return YES;
}

@end
