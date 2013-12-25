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

- (void)_replaceTableViewController:(NSNotification *)notification
{
    ORNTableViewStyle style = [notification.userInfo[ORNDemoTableViewControllerTableViewStyle] unsignedIntegerValue];
    BOOL shouldShowMoreSection = [notification.userInfo[ORNDemoTableViewControllerShouldShowMoreSection] boolValue];

    ORNDemoTableViewController *tableViewController = [[ORNDemoTableViewController alloc] initWithTableViewStyle:style];
    tableViewController.shouldShowMoreSection = shouldShowMoreSection;

    ORNNavigationController *navigationController =  (ORNNavigationController *)self.window.rootViewController;
    navigationController.visibleViewController = tableViewController;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:ORNDemoTableViewControllerTableViewStyle object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_replaceTableViewController:) name:ORNDemoTableViewControllerShouldReplaceNotification object:tableViewController];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [ORNAppearance setupAppearance];

    ORNDemoTableViewController *tableViewController = [[ORNDemoTableViewController alloc] initWithTableViewStyle:ORNTableViewStyleGrouped];
    ORNNavigationController *navigationController = [[ORNNavigationController alloc] initWithRootViewController:tableViewController];
    self.window.rootViewController = navigationController;
    [application orn_setStatusBarHidden:NO];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_replaceTableViewController:) name:ORNDemoTableViewControllerShouldReplaceNotification object:tableViewController];

    return YES;
}

@end
