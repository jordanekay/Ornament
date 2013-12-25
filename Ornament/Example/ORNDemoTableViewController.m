//
//  ORNPlainDemoTableViewController.m
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <Mensa/MNSProperty.h>
#import "NSArray+ORNFunctional.h"
#import "ORNDemoTableViewController.h"
#import "ORNNavigationController.h"
#import "ORNPropertyViewController.h"
#import "ORNTableViewCell.h"
#import "UIColor+ORNAdditions.h"

#define TITLE_LABEL @"Ornament"
#define RESET_LABEL @"Reset"
#define STYLES_LABEL @"Styles"
#define OPTIONS_LABEL @"Options"
#define MORE_LABEL @"More"

#define CURRENT_STYLE_LABEL @"Current Style"
#define SHOW_MORE_SECTION_LABEL @"Show More Section"

#define PLAIN_LABEL @"Plain"
#define GROUPED_LABEL @"Grouped"
#define GROUPED_ETCHED_LABEL @"Grouped Etched"
#define CARD_LABEL @"Card"
#define METAL_LABEL @"Metal"
#define GROOVE_LABEL @"Groove"

NSString *ORNDemoTableViewControllerShouldReplaceNotification = @"ORNDemoTableViewControllerShouldReplaceNotification";
NSString *ORNDemoTableViewControllerTableViewStyle = @"ORNDemoTableViewControllerTableViewStyle";
NSString *ORNDemoTableViewControllerShouldShowMoreSection = @"ORNDemoTableViewControllerShouldShowMoreSection";

@interface ORNDemoTableViewController ()

@property (nonatomic) NSArray *styles;
@property (nonatomic) NSArray *options;
@property (nonatomic) MNSProperty *moreProperty;
@property (nonatomic, readonly) NSArray *styleNames;

@end

@implementation ORNDemoTableViewController
{
    NSUInteger _sectionCount;
}

- (NSArray *)styles
{
    if (!_styles) {
        _styles = [self.styleNames orn_mapWithBlock:^(NSString *name, NSUInteger idx) {
            return [[MNSProperty alloc] initWithName:name value:(self.tableViewStyle == idx) ? @YES : @NO];
        }];
    }
    return _styles;
}

- (NSArray *)options
{
    MNSProperty *currentStyleProperty = [[MNSProperty alloc] initWithName:CURRENT_STYLE_LABEL value:self.styleNames[self.tableViewStyle]];

    @weakify(self);
    MNSProperty *showMoreSectionProperty = [[MNSProperty alloc] initWithName:SHOW_MORE_SECTION_LABEL value:@(self.shouldShowMoreSection)];
    showMoreSectionProperty.options |= MNSPropertyOptionAllowsUserInput;
    showMoreSectionProperty.valueChangedBlock = ^(id value) {
        @strongify(self);
        [self _toggleShouldShowMoreSection];
    };

    return @[currentStyleProperty, showMoreSectionProperty];
}

- (MNSProperty *)moreProperty
{
    NSString *name = [MORE_LABEL stringByAppendingString:@"…"];
    MNSProperty *property = [[MNSProperty alloc] initWithName:name value:^{
        NSLog(@"Hi");
    }];
    property.options |= MNSPropertyOptionHidesDisclosureForValue;
    return property;
}

- (void)_toggleShouldShowMoreSection
{
    self.shouldShowMoreSection = !self.shouldShowMoreSection;
    [self reloadBackingSectionsWithTableViewReload:NO];

    NSUInteger section = (_shouldShowMoreSection ? _sectionCount - 1 : _sectionCount);
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex:section];

    if (self.shouldShowMoreSection) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        [self.tableView insertSections:sections withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } else {
        [self.tableView deleteSections:sections withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)_switchTableViewStyle:(ORNTableViewStyle)style
{
    if (self.tableViewStyle != style) {
        [self orn_navigationController].navigationBarStyle = navigationBarStyleForTableViewStyle(style);
        NSDictionary *userInfo = @{ORNDemoTableViewControllerTableViewStyle: @(style), ORNDemoTableViewControllerShouldShowMoreSection: @(self.shouldShowMoreSection)};
        [[NSNotificationCenter defaultCenter] postNotificationName:ORNDemoTableViewControllerShouldReplaceNotification object:self userInfo:userInfo];
    }
}

- (void)_reset
{
    [self _switchTableViewStyle:ORNTableViewStyleGrouped];
}

ORNNavigationBarStyle navigationBarStyleForTableViewStyle(ORNTableViewStyle style)
{
    ORNNavigationBarStyle navigationBarStyle;
    switch (style) {
        case ORNTableViewStylePlain:
        case ORNTableViewStyleMetal:
            navigationBarStyle = ORNNavigationBarStyleBlackTranslucent;
            break;
        case ORNTableViewStyleGrouped:
        case ORNTableViewStyleCard:
        case ORNTableViewStyleCustom:
            navigationBarStyle = ORNNavigationBarStyleBlue;
            break;
        case ORNTableViewStyleGroupedEtched:
            navigationBarStyle = ORNNavigationBarStyleBlueSimple;
            break;
        case ORNTableViewStyleGroove:
            navigationBarStyle = ORNNavigationBarStyleBlack;
            break;
    }
    return navigationBarStyle;
}

#pragma mark - NSObject

+ (void)initialize
{
    if (self == [ORNDemoTableViewController class]) {
        [MNSViewControllerRegistrar registerViewControllerClass:[ORNPropertyViewController class] forModelClass:[MNSProperty class]];
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RESET_LABEL style:UIBarButtonItemStyleBordered target:self action:@selector(_reset)];
}

- (NSString *)title
{
    return TITLE_LABEL;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - MNSTableViewController

- (void)prepareToLoadHostedViewForViewController:(ORNPropertyViewController *)viewController
{
    viewController.displayStyle = (self.tableViewStyle == ORNTableViewStyleMetal) ? ORNPropertyDisplayStyleDark : ORNPropertyDisplayStyleLight;
}

- (void)selectObject:(MNSProperty *)property forViewController:(MNSPropertyViewController *)viewController
{
    [super selectObject:property forViewController:viewController];
    NSUInteger index = [self.styles indexOfObject:property];
    if (index != NSNotFound) {
        ORNTableViewStyle style = (ORNTableViewStyle)index;
        [self _switchTableViewStyle:style];
    }
}

- (NSArray *)sections
{
    NSMutableArray *sections = [NSMutableArray array];
    [sections addObject:[MNSTableViewSection sectionWithTitle:STYLES_LABEL objects:self.styles]];
    [sections addObject:[MNSTableViewSection sectionWithTitle:OPTIONS_LABEL objects:self.options]];
    if (self.shouldShowMoreSection) {
        [sections addObject:@[self.moreProperty]];
    }
    _sectionCount = [sections count];
    return sections;
}

#pragma mark - ORNTableViewController

- (instancetype)initWithTableViewStyle:(ORNTableViewStyle)style
{
    if (self = [super initWithTableViewStyle:style]) {
        _styleNames = @[PLAIN_LABEL, GROUPED_LABEL, GROUPED_ETCHED_LABEL, CARD_LABEL, METAL_LABEL, GROOVE_LABEL];
    }
    return self;
}

@end
