//
//  ORNSwitch.h
//  Ornament
//
//  Created by Jordan Kay on 8/12/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <TTSwitch/TTSwitch.h>
#import "ORNOrnament.h"

typedef NS_ENUM(NSUInteger, ORNSwitchStyle) {
    ORNSwitchStyleDefault,
    ORNSwitchStyleCustom
};

@interface ORNSwitch : TTSwitch <ORNOrnamentable>

@end
