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

#define SWITCH_THUMB_INSET 3.0f

@implementation ORNAppearance

+ (void)setupAppearance
{
    [[ORNSwitch appearance] setTrackImage:[UIImage imageNamed:@"bg_switch_track"]];
    [[ORNSwitch appearance] setOverlayImage:[UIImage imageNamed:@"bg_switch_overlay"]];
    [[ORNSwitch appearance] setTrackMaskImage:[UIImage imageNamed:@"bg_switch_mask"]];
    [[ORNSwitch appearance] setThumbImage:[UIImage imageNamed:@"bg_switch_thumb"]];
    [[ORNSwitch appearance] setThumbHighlightImage:[UIImage imageNamed:@"bg_switch_thumb_highlight"]];
    [[ORNSwitch appearance] setThumbMaskImage:[UIImage imageNamed:@"bg_switch_mask"]];
    [[ORNSwitch appearance] setThumbInsetX:-SWITCH_THUMB_INSET];
    [[ORNSwitch appearance] setThumbOffsetY:-SWITCH_THUMB_INSET];
}

@end
