//
//  MNSHostingTableViewCell.h
//  Mensa
//
//  Created by Jonathan Wight on 7/18/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "MNSHostedViewController.h"

@interface MNSHostingTableViewCell : UITableViewCell

- (void)loadHostedView;
+ (Class)subclassWithViewControllerClass:(Class)inViewControllerClass;

@property (nonatomic, readonly) Class hostedViewControllerClass;
@property (nonatomic, readonly) MNSHostedViewController *hostedViewController;
@property (nonatomic, weak) UIViewController *parentViewController;

@end
