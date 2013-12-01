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

#define ORN_CACHED_COLORS(...) \
int i = 0; \
int args[] = {__VA_ARGS__, 0}; \
NSMutableDictionary *dict = [NSMutableDictionary dictionary]; \
while ((args[i])) { \
    static NSMutableDictionary *colors; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        colors = [NSMutableDictionary dictionary]; \
    }); \
    int hex = args[i + 1]; \
    NSNumber *value = @(hex); \
    UIColor *color = colors[value]; \
    if (!color) { \
        color = [UIColor orn_colorWithHex:hex]; \
        colors[value] = color; \
    } \
    dict[@(args[i])] = color; \
    i += 2; \
} \
return dict; \

#define ORN_CACHED_COLOR(NAME, ASSIGNMENT) ORN_CACHED_VALUE(UIColor *, NAME, ASSIGNMENT)
