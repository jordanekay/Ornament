//
//  MNSNumberCollectionViewController.m
//  Mensa
//
//  Created by Jordan Kay on 1/14/14.
//  Copyright (c) 2014 Jordan Kay. All rights reserved.
//

#import "MNSNumber.h"
#import "MNSNumberView.h"
#import "MNSNumberViewController.h"
#import "MNSNumberCollectionViewController.h"
#import "MNSPrimeFlag.h"
#import "MNSPrimeFlagViewController.h"

static const NSUInteger kNumberCount = 83;
static const CGFloat kMaxFontSize = 105.0f;
static const CGFloat kSectionInset = 10.0f;

@interface MNSNumberCollectionViewController ()

@property (nonatomic) NSMutableArray *objects;

@end

@implementation MNSNumberCollectionViewController
{
    BOOL _primeFlagsShowing;
}

- (IBAction)togglePrimeFlags:(UIBarButtonItem *)sender
{
    _primeFlagsShowing = !_primeFlagsShowing;
    sender.title = (_primeFlagsShowing) ? @"Hide Flags" : @"Show Flags";

    _objects = nil;
    [self reloadDataAndUpdateCollectionView:YES];
}

- (NSArray *)objects
{
    if (!_objects) {
        _objects = [NSMutableArray array];
        for (NSInteger i = 1; i <= kNumberCount; i++) {
            MNSNumber *number = [[MNSNumber alloc] initWithValue:i];
            [_objects addObject:number];
            if (_primeFlagsShowing && number.isPrime) {
                MNSPrimeFlag *flag = [[MNSPrimeFlag alloc] initWithNumber:number];
                [_objects addObject:flag];
            }
        }
    }
    return _objects;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.sectionInset = UIEdgeInsetsMake(kSectionInset, kSectionInset, kSectionInset, kSectionInset);
}

#pragma mark - MNSDataMediatorDelegate

- (void)dataMediator:(MNSDataMediator *)dataMediator willLoadHostedViewForViewController:(MNSHostedViewController *)viewController
{
    if ([viewController isKindOfClass:[MNSPrimeFlagViewController class]]) {
        ((MNSPrimeFlagViewController *)viewController).displayStyle = MNSPrimeFlagDisplayStyleCompact;
    }
}

- (void)dataMediator:(MNSDataMediator *)dataMediator didUseViewController:(MNSHostedViewController *)viewController withObject:(id)object
{
    if ([object isKindOfClass:[MNSNumber class]]) {
        // Custom font size changing behavior for this collection view controller
        MNSNumber *number = (MNSNumber *)object;
        CGFloat fontSize = kMaxFontSize - number.value;
        MNSNumberView *view = (MNSNumberView *)[viewController viewForObject:number];
        view.valueLabel.font = [view.valueLabel.font fontWithSize:fontSize];
    }
}

- (NSArray *)sections
{
    return @[self.objects];
}

@end
