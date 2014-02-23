//
//  ORNPath.h
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNColorable.h"

@interface ORNPath : UIBezierPath <ORNColorable>

+ (instancetype)pathWithRect:(CGRect)rect;
+ (instancetype)pathWithOvalInRect:(CGRect)rect;
+ (instancetype)pathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)radius;
+ (instancetype)pathWithRoundedRect:(CGRect)rect corners:(UIRectCorner)corners radius:(CGFloat)radius;

@end
