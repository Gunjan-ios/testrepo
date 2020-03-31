//
//  NavigationViewController.m
//  Karnataka Tourism
//
//  Created by Mayank Bhatt on 8/21/15.
//  Copyright (c) 2015 Mayank Bhatt. All rights reserved.
//

#import "KMNavigationViewController.h"
#import "KMLeftPanelViewController.h"
#import "UIViewController+REFrostedViewController.h"

@interface KMNavigationViewController ()
@property (strong, readwrite, nonatomic) KMLeftPanelViewController *menuViewController;
@end

@implementation KMNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

@end
