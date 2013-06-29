//
//  ORNSwizzle.m
//  Ornament
//
//  Created by Jordan Kay on 11/17/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "ORNSwizzle.h"

void ORNSwizzle(Class c, SEL a, SEL b)
{
    Method origMethod = class_getInstanceMethod(c, a);
    Method newMethod = class_getInstanceMethod(c, b);
    if (class_addMethod(c, a, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(c, b, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, newMethod);
    }
}