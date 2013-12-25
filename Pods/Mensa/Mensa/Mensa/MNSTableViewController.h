//
//  MNSTableViewController.h
//  Mensa
//
//  Created by Jonathan Wight on 7/26/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "MNSTableViewSection.h"
#import "MNSHostedViewController.h"
#import "MNSHostingTableViewCell.h"
#import "MNSViewControllerRegistrar.h"

@interface MNSTableViewController : UITableViewController

+ (Class)cellClass;
- (void)reloadBackingSectionsWithTableViewReload:(BOOL)fully;
- (void)prepareToLoadHostedViewForViewController:(MNSHostedViewController *)viewController;
- (void)hostViewController:(MNSHostedViewController *)viewController withObject:(id)object;
- (BOOL)canSelectObject:(id)object forViewController:(MNSHostedViewController *)viewController;
- (void)selectObject:(id)object forViewController:(MNSHostedViewController *)viewController;

@property (nonatomic, readonly) NSArray *sections;

@end
