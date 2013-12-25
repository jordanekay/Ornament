//
//  ORNPlainDemoTableViewController.h
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNTableViewController.h"

extern NSString *ORNDemoTableViewControllerShouldReplaceNotification;
extern NSString *ORNDemoTableViewControllerTableViewStyle;
extern NSString *ORNDemoTableViewControllerShouldShowMoreSection;

@interface ORNDemoTableViewController : ORNTableViewController

@property (nonatomic) BOOL shouldShowMoreSection;

@end
