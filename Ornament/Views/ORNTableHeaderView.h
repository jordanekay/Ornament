//
//  ORNTableHeaderView.h
//  Ornament
//
//  Created by Jordan Kay on 11/17/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORNOrnament.h"
#import "ORNTableView.h"

@interface ORNTableHeaderView : UITableViewHeaderFooterView <ORNOrnamentable>

+ (CGFloat)defaultPadding;
+ (CGFloat)defaultPaddingTop;
+ (CGFloat)minimumHeight;

@property (nonatomic) BOOL usesUppercaseTitles;
@property (nonatomic, getter = isGroupedStyle) BOOL groupedStyle;

@end
