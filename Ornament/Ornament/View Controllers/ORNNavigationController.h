//
//  ORNNavigationController.h
//  Ornament
//
//  Created by Jordan Kay on 11/28/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNNavigationBar.h"

@interface ORNNavigationController : UIViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController navigationBarStyle:(ORNNavigationBarStyle)style;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;

@property (nonatomic) ORNNavigationBarStyle navigationBarStyle;
@property (nonatomic) IBOutlet ORNNavigationBar *navigationBar;
@property (nonatomic, readonly) UIViewController *visibleViewController;
@property (nonatomic, copy, readonly) NSArray *viewControllers;

@end
