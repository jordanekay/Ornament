//
//  ORNTableViewController.m
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNTableHeaderView.h"
#import "ORNTableViewController.h"
#import "UIApplication+ORNStatusBar.h"
#import "UIDevice+ORNVersion.h"

static NSMutableDictionary *footers;

@implementation ORNTableViewController
{
    UIEdgeInsets _tableViewInsets;
    UIEdgeInsets _tableViewSectionInsets;
}

- (instancetype)initWithTableViewStyle:(ORNTableViewStyle)style
{
    if ([super initWithStyle:UITableViewStylePlain]) {
        _tableViewStyle = style;
    }

    return self;
}

- (void)setTableViewStyle:(ORNTableViewStyle)style
{
    if (_tableViewStyle != style) {
        _tableViewStyle = style;

        UIView *view = self.view;
        [self _setupTableView];
        [self _layoutTableView:YES];
        [[UIApplication sharedApplication] orn_setStatusBarHidden:NO];
        [view removeFromSuperview];
    }
}

- (BOOL)isGroupedStyle
{
    ORNTableView *tableView = (ORNTableView *)self.tableView;
    return (tableView.ornamentationStyle != ORNTableViewStylePlain);
}

- (BOOL)usesUppercaseSectionHeaderTitles
{
    ORNTableView *tableView = (ORNTableView *)self.tableView;
    return (tableView.ornamentationStyle == ORNTableViewStyleMetal);
}

- (BOOL)_sectionBreakAboveForIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0;
}

- (BOOL)_sectionBreakBelowForIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == [self tableView:self.tableView numberOfRowsInSection:indexPath.section] - 1);
}

- (void)_setupTableView
{
    UIView *view = [[UIView alloc] init];

    ORNTableView *tableView = [[ORNTableView alloc] initWithFrame:CGRectZero ornamentationStyle:self.tableViewStyle];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.pinsHeaderViewsToTop = (self.tableViewStyle == ORNTableViewStylePlain);
    [view addSubview:tableView];

    [tableView ornament];
    if ([tableView.delegate respondsToSelector:@selector(ornamentTableView:)]) {
        [tableView.delegate performSelector:@selector(ornamentTableView:) withObject:tableView];
    }
    [tableView orn_getOrnamentMeasurement:NULL position:&_tableViewInsets withOptions:ORNOrnamentTableViewScopeTable | ORNOrnamentTypeLayout];
    [tableView orn_getOrnamentMeasurement:NULL position:&_tableViewSectionInsets withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeLayout];

    self.view = view;
}

- (void)_layoutTableView:(BOOL)hasLaidOut
{
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom = _tableViewSectionInsets.bottom - _tableViewInsets.bottom;
    
    if (self.isGroupedStyle || self.navigationController) {
        insets.top += 1.0f;
    }
    if (![UIDevice orn_isIOS7] || (hasLaidOut || !self.navigationController)) {
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        insets.top += statusBarHeight;
    }
    if (!([UIDevice orn_isIOS7] && !hasLaidOut) && self.navigationController.navigationBar.isTranslucent) {
        CGFloat navBarHeight = self.navigationController.navigationBar.bounds.size.height;
        insets.top += navBarHeight;
    }

    UIEdgeInsets scrollIndicatorInsets = self.tableView.scrollIndicatorInsets;
    scrollIndicatorInsets.top = insets.top;
    self.tableView.scrollIndicatorInsets = scrollIndicatorInsets;

    insets.top += _tableViewSectionInsets.bottom;
    self.tableView.contentInset = insets;
    self.tableView.sectionHeaderHeight = MAX(_tableViewSectionInsets.top + _tableViewSectionInsets.bottom + [ORNTableHeaderView defaultPadding], [ORNTableHeaderView minimumHeight]);
}

#pragma mark - NSObject

+ (void)initialize
{
    if (self == [ORNTableViewController class]) {
        footers = [NSMutableDictionary new];
    }
}

#pragma mark - UIViewController

- (void)loadView
{
    [self _setupTableView];
    [self _layoutTableView:NO];
}

- (BOOL)wantsFullScreenLayout
{
    return YES;
}

#pragma mark - UITableViewController

- (UITableView *)tableView
{
    return [self.view.subviews lastObject];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ORNTableViewCell *cellToDisplay = (ORNTableViewCell *)cell;
    cellToDisplay.sectionBreakAbove = [self _sectionBreakAboveForIndexPath:indexPath];
    cellToDisplay.sectionBreakBelow = [self _sectionBreakBelowForIndexPath:indexPath];
    [cell.layer setNeedsLayout];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(ORNTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifier = @"ORNTableHeaderView";
    ORNTableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!headerView) {
        headerView = [[ORNTableHeaderView alloc] initWithReuseIdentifier:identifier];
        headerView.ornamentationStyle = tableView.ornamentationStyle;
        headerView.groupedStyle = self.isGroupedStyle;
        headerView.usesUppercaseTitles = self.usesUppercaseSectionHeaderTitles;
        [headerView ornament];
    }

    return headerView;
}

- (UIView *)tableView:(ORNTableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view;
    if (_tableViewSectionInsets.top < 0.0f) {
        view = footers[@(section)];
        if (!view) {
            view = [UIView new];
            view.backgroundColor = tableView.separatorColor;
            footers[@(section)] = view;
        }
    }
    return view;
}

- (CGFloat)tableView:(ORNTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 45.0f; // TODO
    if ([self _sectionBreakAboveForIndexPath:indexPath]) {
        height += _tableViewSectionInsets.top + tableView.separatorHeight;
    }
    if ([self _sectionBreakBelowForIndexPath:indexPath]) {
        height += _tableViewSectionInsets.bottom;
    }
    height += tableView.separatorHeight;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ([self tableView:tableView titleForHeaderInSection:section]) ? tableView.sectionHeaderHeight : 0.0f;
}

- (CGFloat)tableView:(ORNTableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (_tableViewSectionInsets.top < 0.0f && ![self tableView:tableView titleForHeaderInSection:section + 1]) ? tableView.separatorHeight : 0.0f;
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(ORNTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ORNTableViewCellStyle style = [self tableView:tableView cellStyleForRowAtIndexPath:indexPath];
    NSString *identifier = [NSString stringWithFormat:@"%i", style];
    ORNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSString *template = [self tableView:tableView templateForRowAtIndexPath:indexPath];
        cell = [[ORNTableViewCell alloc] initWithOrnamentationStyle:style template:template reuseIdentifier:identifier];
        cell.highlightsContents = (self.tableViewStyle != ORNTableViewStyleGroove);
        cell.hostTableView = tableView;
    }
    cell.accessoryType = [self tableView:tableView cellAccessoryTypeForRowAtIndexPath:indexPath];
    // TODO: leftAccessoryView
    if ([cell.accessoryView isKindOfClass:[ORNSwitch class]]) {
        ORNSwitch *accessorySwitch = (ORNSwitch *)cell.accessoryView;
        accessorySwitch.containingCellIndexPath = indexPath;
        accessorySwitch.delegate = self;
    }
    return cell;
}

#pragma mark ORNTableViewDelegate

- (NSString *)tableView:(ORNTableView *)tableView templateForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.tableViewStyle == ORNTableViewStyleMetal) ? @"ORNTableViewCellCollectionDark" : @"ORNTableViewCellCollection";
}

- (ORNTableViewCellStyle)tableView:(ORNTableView *)tableView cellStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ORNTableViewCellStyleDefault;
}

- (ORNTableViewCellAccessory)tableView:(ORNTableView *)tableView cellAccessoryTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ORNTableViewCellAccessoryNone;
}

@end
