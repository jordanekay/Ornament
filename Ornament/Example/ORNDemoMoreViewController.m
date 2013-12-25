//
//  ORNDemoMoreViewController.m
//  Ornament
//
//  Created by Jordan Kay on 12/24/13.
//  Copyright (c) 2013 Jordan Kay. All rights reserved.
//

#import "ORNDemoMoreViewController.h"

#define TITLE_LABEL @"GitHub"
#define DONE_LABEL @"Done"
#define GITHUB_URL @"http://www.github.com/jordanekay/Ornament"

@implementation ORNDemoMoreViewController

- (void)_loadWebPage
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:GITHUB_URL]];
    [self.webView loadRequest:request];
}

- (void)_dismiss
{
    [self.webView stopLoading];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _loadWebPage];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:DONE_LABEL style:UIBarButtonItemStyleDone target:self action:@selector(_dismiss)];
}

- (NSString *)title
{
    return TITLE_LABEL;
}

@end
