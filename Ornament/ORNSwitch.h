//
//  ORNSwitch.h
//  Ornament
//
//  Created by Jordan Kay on 8/12/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNBoolean.h"
#import "ORNOrnament.h"

typedef NS_ENUM(NSUInteger, ORNSwitchStyle) {
    ORNSwitchStyleDefault,
    ORNSwitchStyleCustom
};

@protocol ORNSwitchDelegate;

@interface ORNSwitch : UISwitch <ORNBoolean, ORNOrnamentable>

@property (nonatomic) NSIndexPath *containingCellIndexPath;
@property (nonatomic, weak) id<ORNSwitchDelegate> delegate;

@end

@protocol ORNSwitchDelegate <NSObject>

@optional

- (void)switch:(ORNSwitch *)s didSetOn:(BOOL)on forIndexPath:(NSIndexPath *)indexPath;

@end
