//
//  ORNTableViewController.h
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNSwitch.h"
#import "ORNTableView.h"

@interface ORNTableViewController : UITableViewController <ORNTableViewDelegate, ORNSwitchDelegate>

- (instancetype)initWithTableViewStyle:(ORNTableViewStyle)style;

@property (nonatomic) ORNTableViewStyle tableViewStyle;
@property (nonatomic, readonly) BOOL isGroupedStyle;
@property (nonatomic, readonly) BOOL usesUppercaseSectionHeaderTitles;

@end
