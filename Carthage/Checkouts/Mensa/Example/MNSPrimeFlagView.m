//
//  MNSPrimeFlagView.m
//  Mensa
//
//  Created by Jordan Kay on 12/7/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "MNSPrimeFlagView.h"

@interface MNSPrimeFlagView ()

@property (nonatomic) NSString *formatString;

@end

@implementation MNSPrimeFlagView

#pragma mark - NSObject

- (void)awakeFromNib
{
    self.formatString = self.textLabel.text;
}

@end
