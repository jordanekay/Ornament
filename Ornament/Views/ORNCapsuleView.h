//
//  ORNCapsuleView.h
//  Ornament
//
//  Created by Jordan Kay on 2/23/14.
//  Copyright (c) 2014 Jordan Kay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ORNOrnament.h"

@interface ORNCapsuleView : UIImageView <ORNOrnamentable>

@property (nonatomic) UIRectCorner roundedCorners;
@property (nonatomic, getter = isHorizontallyResizable) BOOL horizontallyResizable;
@property (nonatomic, getter = isVerticallyResizable) BOOL verticallyResizable;

@end
