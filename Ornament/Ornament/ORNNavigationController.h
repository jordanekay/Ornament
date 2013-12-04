//
//  ORNNavigationController.h
//  Ornament
//
//  Created by Jordan Kay on 11/28/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNNavigationBar.h"

@interface ORNNavigationController : UINavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController navigationBarStyle:(ORNNavigationBarStyle)style;

@property (nonatomic) ORNNavigationBarStyle navigationBarStyle;

@end
