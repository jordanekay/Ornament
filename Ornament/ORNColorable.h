//
//  ORNColorable.h
//  Ornament
//
//  Created by Jordan Kay on 8/3/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNOrnament.h"

@protocol ORNColorable <NSObject>

- (void)colorInView:(UIView<ORNOrnamentable> *)view withOptions:(ORNOrnamentOptions)options;

@property (nonatomic, readonly) BOOL needsRecoloringOnLayout;

@end
