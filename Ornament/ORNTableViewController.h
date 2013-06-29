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

- (instancetype)initWithOrnamentationStyle:(ORNTableViewStyle)style;
- (void)setOrnamentationStyle:(ORNTableViewStyle)style animated:(BOOL)animated;

@property (nonatomic) ORNTableViewStyle ornamentationStyle;

@end
