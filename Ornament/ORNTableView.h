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

@protocol ORNTableViewDelegate;

@interface ORNTableView : UITableView <ORNOrnamentable>

- (instancetype)initWithFrame:(CGRect)frame ornamentationStyle:(ORNTableViewStyle)style;

/**
 * Height of table view cell separator.
 * Default is 1 pt.
 */
@property (nonatomic) CGFloat separatorHeight;
@property (nonatomic, readonly) UIImage *backgroundImage;
@property (nonatomic, readonly) UIImage *highlightedBackgroundImage;
@property (nonatomic, readonly) ORNTableViewStyle ornamentationStyle;
@property (nonatomic, readonly) BOOL isGroupedStyle;
@property (nonatomic, readonly) BOOL usesUppercaseSectionHeaderTitles;
@property (nonatomic) BOOL pinsHeaderViewsToTop;

@end

@protocol ORNTableViewDelegate <UITableViewDelegate>

- (NSString *)tableView:(ORNTableView *)tableView templateForRowAtIndexPath:(NSIndexPath *)indexPath;
- (ORNTableViewCellStyle)tableView:(ORNTableView *)tableView cellStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (ORNTableViewCellAccessory)tableView:(ORNTableView *)tableView cellAccessoryTypeForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (void)ornamentTableView:(ORNTableView *)tableView;

@end
