//
//  ORNNavigationBar.h
//  Ornament
//
//  Created by Jordan Kay on 11/28/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNOrnament.h"

typedef NS_ENUM(NSUInteger, ORNNavigationBarStyle) {
    ORNNavigationBarStyleBlue,
    ORNNavigationBarStyleBlueSimple,
    ORNNavigationBarStyleBlack,
    ORNNavigationBarStyleBlackTranslucent
};

@interface ORNNavigationBar : UINavigationBar <ORNOrnamentable>

@property (nonatomic) UINavigationItem *item;
@property (nonatomic) IBOutlet UIButton *leftBarButton;
@property (nonatomic) IBOutlet UIButton *rightBarButton;
@property (nonatomic, readonly, getter = isTranslucentStyle) BOOL translucentStyle;

@end
