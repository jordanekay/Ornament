//
//  ORNTableHeaderView.h
//  Ornament
//
//  Created by Jordan Kay on 11/17/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNOrnament.h"
#import "ORNTableView.h"

@interface ORNTableHeaderView : UITableViewHeaderFooterView <ORNOrnamentable>

- (instancetype)initWithTableView:(ORNTableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier __unavailable;

+ (CGFloat)defaultPadding;
+ (CGFloat)defaultPaddingTop;
+ (CGFloat)tablePadding;
+ (CGFloat)minimumHeight;

@end
