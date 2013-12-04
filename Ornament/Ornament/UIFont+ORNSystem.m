//
//  UIFont+ORNSystem.m
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "UIFont+ORNSystem.h"

#define SYSTEM_FONT_NAME @"HelveticaNeue"
#define BOLD_SYSTEM_FONT_NAME @"HelveticaNeue-Bold"

@implementation UIFont (ORNSystem)

+ (UIFont *)orn_systemFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:SYSTEM_FONT_NAME size:size];
}

+ (UIFont *)orn_boldSystemFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:BOLD_SYSTEM_FONT_NAME size:size];
}

@end
