//
//  ORNTableViewCellContainerView.h
//  Ornament
//
//  Created by Jordan Kay on 11/2/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

@interface ORNTableViewCellContainerView : UIView

@property (nonatomic) BOOL highlights;
@property (nonatomic, getter = isHighlighted) BOOL highlighted;
@property (nonatomic, readonly) IBOutletCollection(UILabel) NSArray *labels;
@property (nonatomic, readonly) IBOutletCollection(UIImageView) NSArray *imageViews;

@end
