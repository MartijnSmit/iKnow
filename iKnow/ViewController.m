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

- (void)openLogin:(id)sender
{
    /*NSLog(@"Wat is dit? %@", [[AppDelegate sharedAppDelegate] sessionEmployee]);
    
    if ([[AppDelegate sharedAppDelegate] sessionEmployee] != nil) {
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_icon.png"]];
    }
    else{
        
    }*/
}

- (IBAction)testRightitemBG:(id)sender {
       // _rightBarButton.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_icon.png"]];
    //NSLog(@"joaah %@", _rightBarButton.);
    UIImage *buttonrightimage = [UIImage imageNamed:@"profile_icon.png"];
    /*UIBarButtonItem *vettehap = [[UIBarButtonItem alloc]init];
    [vettehap setBackgroundImage:buttonrightimage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //[self.navigationItem setRightBarButtonItem:vettehap];
    self.navigationItem.rightBarButtonItem = vettehap;
    */
    _rightBarButton.title = @"barry";
    NSLog(@"ja tiefus button wat is je naam %@", _rightBarButton.title);
    
    [_rightBarButton setBackgroundImage:buttonrightimage forState:UIControlStateNormal barMetrics:0];
}

- (IBAction)openSearch:(id)sender {
    [self performSegueWithIdentifier:@"pushSearchResults" sender:self];
    /*if (! self.swipeController) {
        NSLog(@"swipe controller not found");
    }
    [self.swipeController showLeft];*/
}


- (void)viewDidAppear:(BOOL)animated
{

}
@end
