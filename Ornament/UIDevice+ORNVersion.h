//
//  UIDevice+ORNVersion.h
//  Ornament
//
//  Created by Jordan Kay on 7/18/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

@interface UIDevice (ORNVersion)

+ (BOOL)orn_meetsVersion:(NSString *)version;
+ (BOOL)orn_isIOS7;

@end
