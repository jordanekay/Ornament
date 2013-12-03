//
//  ORNTableViewCell.h
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

@class ORNTableView;
@class ORNTableViewCellContainerView;
@class ORNTableViewController;

typedef NS_ENUM(NSUInteger, ORNTableViewCellStyle) {
    ORNTableViewCellStyleDefault,
    ORNTableViewCellStyleValue1,
    ORNTableViewCellStyleValue2,
    ORNTableViewCellStyleSubtitle,
    ORNTableViewCellStyleCentered
};

typedef NS_ENUM(NSUInteger, ORNTableViewCellAccessory) {
    ORNTableViewCellAccessoryNone,
    ORNTableViewCellAccessoryChevron,
    ORNTableViewCellAccessoryDetailButton,
    ORNTableViewCellAccessoryCheckmark,
    ORNTableViewCellAccessorySwitch,
    ORNTableViewCellAccessoryImage
};

enum {
    ORNTableViewCellContentsTextLabel,
    ORNTableViewCellContentsDetailTextLabel
};

@interface ORNTableViewCell : UITableViewCell

- (instancetype)initWithOrnamentationStyle:(ORNTableViewCellStyle)style template:(NSString *)temp reuseIdentifier:(NSString *)reuseIdentifier;

/**
 * Custom cell background images, depending on which corners are rounded
 * Default is nil; subclasses can return appropriate image asset
 */
- (UIImage *)customBackgroundImageForRoundedCorners:(UIRectCorner)corners;
- (UIImage *)customHighlightedBackgroundImageForRoundedCorners:(UIRectCorner)corners;

@property (nonatomic) NSArray *textContents;
@property (nonatomic) NSArray *imageContents;
@property (nonatomic) NSArray *booleanContents;
@property (nonatomic) BOOL highlightsContents;
@property (nonatomic) BOOL sectionBreakAbove;
@property (nonatomic) BOOL sectionBreakBelow;
@property (nonatomic, weak) ORNTableView *hostTableView;

@end
