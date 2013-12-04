//
//  ORNOrnamentMacros.h
//  Ornament
//
//  Created by Jordan Kay on 11/30/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#define ORN_MAKE_OPTIONS_LIST(array, options) \
va_list list; \
va_start(list, options); \
for (ORNOrnamentOptions o = options; o > 0; o = va_arg(list, ORNOrnamentOptions)) { \
    [array addObject:@(o)]; \
} \
va_end(list); \
