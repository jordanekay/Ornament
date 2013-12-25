//
//  ORNTableViewController.h
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <Mensa/MNSTableViewController.h>
#import "ORNSwitch.h"
#import "ORNTableView.h"

@interface ORNTableViewController : MNSTableViewController

- (instancetype)initWithTableViewStyle:(ORNTableViewStyle)style; // Designated initializer
- (instancetype)initWithStyle:(UITableViewStyle)style __unavailable;
- (void)ornamentTableView:(ORNTableView *)tableView;

@property (nonatomic) ORNTableViewStyle tableViewStyle;
@property (nonatomic, readonly) BOOL isGroupedStyle;
@property (nonatomic, readonly) BOOL usesUppercaseSectionHeaderTitles;

@end
