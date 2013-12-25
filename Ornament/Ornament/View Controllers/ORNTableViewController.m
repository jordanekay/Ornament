//
//  ORNTableViewController.m
//  Ornament
//
//  Created by Jordan Kay on 6/29/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNTableHeaderView.h"
#import "ORNTableViewController.h"
#import "ORNNavigationController.h"
#import "UIApplication+ORNStatusBar.h"
#import "UIDevice+ORNVersion.h"

static NSString *cellIdentifier = @"ORNTableViewCell";
static NSString *headerViewIdentifier = @"ORNTableHeaderView";
static NSMutableDictionary *footers;

@implementation ORNTableViewController
{
    UIEdgeInsets _tableViewInsets;
    UIEdgeInsets _tableViewSectionInsets;
}

- (instancetype)initWithTableViewStyle:(ORNTableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        _tableViewStyle = style;
    }

    return self;
}

- (void)ornamentTableView:(ORNTableView *)tableView
{
    // Subclasses implement
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
    [self ornamentTableView:tableView];

    [tableView orn_getOrnamentMeasurement:NULL position:&_tableViewInsets withOptions:ORNOrnamentTableViewScopeTable | ORNOrnamentTypeLayout];
    [tableView orn_getOrnamentMeasurement:NULL position:&_tableViewSectionInsets withOptions:ORNOrnamentTableViewScopeSection | ORNOrnamentTypeLayout];

    self.view = view;
}

- (void)_layoutTableView
{
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom = _tableViewSectionInsets.bottom - _tableViewInsets.bottom;

    if ([UIDevice orn_isIOS7]) {
        CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        insets.top += statusBarHeight;
    }

    ORNNavigationController *navigationController = [self orn_navigationController];
    if (navigationController) {
        CGFloat navBarHeight = [self orn_navigationController].navigationBar.bounds.size.height;
        insets.top += navBarHeight;
    }

    if (!self.isGroupedStyle) {
        insets.top += 1.0f;
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
    [self _layoutTableView];
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
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(ORNTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ORNTableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentifier];
    if (!headerView) {
        headerView = [[ORNTableHeaderView alloc] initWithReuseIdentifier:headerViewIdentifier];
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
    return (_tableViewSectionInsets.top < 0.0f && (tableView.numberOfSections <= section + 1 || ![self tableView:tableView titleForHeaderInSection:section + 1])) ? tableView.separatorHeight : 0.0f;
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(ORNTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ORNTableViewCell *cell = (ORNTableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[ORNTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.hostTableView = tableView;
    cell.highlightsContents = (self.tableViewStyle != ORNTableViewStyleGroove);
    return cell;
}

#pragma mark - MNSTableViewController

+ (Class)cellClass
{
    return [ORNTableViewCell class];
}

@end
