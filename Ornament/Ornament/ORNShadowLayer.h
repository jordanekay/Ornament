//
//  ORNShadowLayer.h
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNColorable.h"

@interface ORNShadowLayer : CALayer <ORNColorable>

@property (nonatomic) CGFloat horizontalInset;
@property (nonatomic) CGFloat verticalInset;
@property (nonatomic) UIRectCorner roundedCorners;

@end
