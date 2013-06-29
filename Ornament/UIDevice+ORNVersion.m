//
//  UIDevice+ORNVersion.m
//  Ornament
//
//  Created by Jordan Kay on 7/18/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNCaching.h"
#import "UIDevice+ORNVersion.h"

@implementation UIDevice (ORNVersion)

+ (BOOL)orn_meetsVersion:(NSString *)version
{
    return [[[self currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedAscending;
}

ORN_CACHED_VALUE(BOOL, orn_isIOS7, [self orn_meetsVersion:@"7.0"]);

@end
