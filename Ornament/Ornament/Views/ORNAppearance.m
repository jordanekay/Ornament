//
//  ORNAppearance.m
//  Ornament
//
//  Created by Jordan Kay on 12/1/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNAppearance.h"
#import "UIFont+ORNSystem.h"
#import "ORNSwitch.h"

#define TITLE_FONT [UIFont orn_boldSystemFontOfSize:12.0f]
#define TITLE_TEXT_COLOR [UIColor whiteColor]
#define TITLE_TEXT_SHADOW_COLOR [UIColor colorWithWhite:0.0f alpha:0.6f]
#define TITLE_TEXT_SHADOW_OFFSET UIOffsetMake(0.0f, -1.0f)
#define TITLE_ADJUSTMENT -5.0f

@implementation ORNAppearance

+ (void)setupAppearance
{
    [[ORNSwitch appearance] setTrackImage:[UIImage imageNamed:@"round-switch-track"]];
    [[ORNSwitch appearance] setOverlayImage:[UIImage imageNamed:@"round-switch-overlay"]];
    [[ORNSwitch appearance] setTrackMaskImage:[UIImage imageNamed:@"round-switch-mask"]];
    [[ORNSwitch appearance] setThumbImage:[UIImage imageNamed:@"round-switch-thumb"]];
    [[ORNSwitch appearance] setThumbHighlightImage:[UIImage imageNamed:@"round-switch-thumb-highlight"]];
    [[ORNSwitch appearance] setThumbMaskImage:[UIImage imageNamed:@"round-switch-mask"]];
    [[ORNSwitch appearance] setThumbInsetX:-3.0f];
    [[ORNSwitch appearance] setThumbOffsetY:-3.0f];
}

@end
