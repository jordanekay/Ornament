//
//  MNSPrimeFlagViewController.h
//  Mensa
//
//  Created by Jordan Kay on 12/7/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "MNSHostedViewController.h"

typedef NS_ENUM(NSUInteger, MNSPrimeFlagDisplayStyle) {
    MNSPrimeFlagDisplayStyleDefault,
    MNSPrimeFlagDisplayStyleCompact
};

@interface MNSPrimeFlagViewController : MNSHostedViewController

@property (nonatomic) MNSPrimeFlagDisplayStyle displayStyle;
@property (nonatomic) IBOutlet UIView *defaultView;
@property (nonatomic) IBOutlet UIView *compactView;

@end
