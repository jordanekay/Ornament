//
//  ORNCaching.h
//  Ornament
//
//  Created by Jordan Kay on 11/17/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#define ORN_CACHED_VALUE(TYPE, NAME, ASSIGNMENT) \
+ (TYPE)NAME \
{ \
    static TYPE NAME; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        NAME = ASSIGNMENT; \
    }); \
    return NAME; \
}
