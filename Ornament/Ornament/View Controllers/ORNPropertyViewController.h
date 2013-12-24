//
//  ORNPropertyViewController.h
//  Ornament
//
//  Created by Jordan Kay on 12/21/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <Mensa/MNSPropertyViewController.h>
#import "MNSPropertyView.h"

typedef NS_ENUM(NSUInteger, ORNPropertyDisplayStyle) {
    ORNPropertyDisplayStyleLight,
    ORNPropertyDisplayStyleDark
};

@interface ORNPropertyViewController : MNSPropertyViewController

@property (nonatomic) ORNPropertyDisplayStyle displayStyle;
@property (nonatomic) IBOutlet MNSPropertyView *lightPropertyView;
@property (nonatomic) IBOutlet MNSPropertyView *darkPropertyView;

@end
