//
//  UIApplication+ORNStatusBar.h
//  Ornament
//
//  Created by Jordan Kay on 8/12/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

typedef NS_ENUM(NSUInteger, ORNStatusBarStyle) {
    ORNStatusBarStyleDefault,
    ORNStatusBarStyleLightContent,
    ORNStatusBarStyleLightContentTranslucent
};

@interface UIApplication (ORNStatusBar)

- (ORNStatusBarStyle)orn_statusBarStyle;
- (void)orn_setStatusBarStyle:(ORNStatusBarStyle)style;
- (void)orn_setStatusBarStyle:(ORNStatusBarStyle)style animated:(BOOL)animated;
- (void)orn_setStatusBarHidden:(BOOL)hidden;
- (void)orn_setStatusBarHidden:(BOOL)hidden animated:(BOOL)animated;
- (CGRect)orn_statusBarFrame;

@end
