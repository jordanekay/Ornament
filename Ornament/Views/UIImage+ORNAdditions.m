//
//  UIImage+ORNAdditions.m
//  Ornament
//
//  Created by Jordan Kay on 12/21/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "UIImage+ORNAdditions.h"

@implementation UIImage (ORNAdditions)

- (UIImage *)orn_buttonBackgroundImage
{
    CGFloat inset = floorf(self.size.width / 2);
    UIEdgeInsets insets = {.left = inset, .right = inset};
    return [self resizableImageWithCapInsets:insets];
}

@end
