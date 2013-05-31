//
//  ViewController.m
//  Extended Tableview Test
//
//  Created by Mark ter Luun on 06-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+RNSwipeViewController.h"
#import "RNSwipeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set tables
    // Table1
    [self setDs1:[[Table1DataSource alloc] initWithTestData]];
    [self setDg1:[[Table1Delegate alloc] init]];
    
    [[self Table1] setDataSource:[self ds1]];
    [[self Table1] setDelegate:[self dg1]];
    
    [[self Table1] reloadData];
    
    // Table2
    [self setDs2:[[Table2DataSource alloc] init]];
    [self setDg2:[[Table2Delegate alloc] init]];
    
    [[self Table2] setDataSource:[self ds2]];
    [[self Table2] setDelegate:[self dg2]];

    [[self Table2] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openSearch:(id)sender {
    [self performSegueWithIdentifier:@"pushSearchResults" sender:self];
    /*if (! self.swipeController) {
        NSLog(@"swipe controller not found");
    }
    [self.swipeController showLeft];*/
}

- (IBAction)openLogin:(id)sender {
}
@end
