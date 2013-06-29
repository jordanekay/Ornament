//
//  ORNTableViewCellContainerView.m
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNTableViewCellContainerView.h"

@implementation ORNTableViewCellContainerView

#pragma mark - UIView

- (void)setHighlighted:(BOOL)highlighted
{
    if (self.highlights && _highlighted != highlighted) {
        _highlighted = highlighted;
        for (UILabel *label in self.labels) {
            label.highlighted = highlighted;
        }
    }
}

@end
