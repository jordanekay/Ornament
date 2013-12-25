//
//  ORNTableView.h
//  Ornament
//
//  Created by Jordan Kay on 7/15/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNOrnament.h"
#import "ORNTableViewCell.h"

typedef NS_ENUM(NSUInteger, ORNTableViewStyle) {
    ORNTableViewStylePlain,
    ORNTableViewStyleGrouped,
    ORNTableViewStyleGroupedEtched,
    ORNTableViewStyleCard,
    ORNTableViewStyleMetal,
    ORNTableViewStyleGroove,
    ORNTableViewStyleCustom
};

@interface ORNTableView : UITableView <ORNOrnamentable>

- (instancetype)initWithFrame:(CGRect)frame ornamentationStyle:(ORNTableViewStyle)style;

/**
 * Height of table view cell separator.
 * Default is 1 pt.
 */
@property (nonatomic) CGFloat separatorHeight;
@property (nonatomic, readonly) UIImage *backgroundImage;
@property (nonatomic, readonly) UIImage *highlightedBackgroundImage;
@property (nonatomic) BOOL pinsHeaderViewsToTop;

@end
