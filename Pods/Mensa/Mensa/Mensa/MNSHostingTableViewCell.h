//
//  MNSHostingTableViewCell.h
//  Mensa
//
//  Created by Jonathan Wight on 7/18/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "MNSHostedViewController.h"

@interface MNSHostingTableViewCell : UITableViewCell

/**
 * Adds the hosted view controller’s view for the given object to the cell’s content view.
 */
- (void)loadHostedViewForObject:(id)object;

- (void)setParentViewController:(UIViewController *)parentViewController withObject:(id)object;

/**
 * Use this method to apply custom logic in a base MNSHostingTableViewCell subclass
 * when this cell is used as a metrics cell in a table view. Useful for setting the cell’s
 * layoutInsets property based on the table view used.
 */
- (void)useAsMetricsCellInTableView:(UITableView *)tableView;

/**
 * Returns a subclass of this class to instantiate cells hosting view controllers of
 * a specific class.
 */
+ (Class)subclassWithViewControllerClass:(Class)viewControllerClass;

@property (nonatomic) UIEdgeInsets layoutInsets;
@property (nonatomic, readonly) Class hostedViewControllerClass;
@property (nonatomic, readonly) MNSHostedViewController *hostedViewController;
@property (nonatomic, weak) UIViewController *parentViewController;

@end
