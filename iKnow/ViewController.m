//
//  ViewController.m
//  Extended Tableview Test
//
//  Created by Mark ter Luun on 06-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*UIImage *buttonrightimage = [UIImage imageNamed:@"profile_icon.png"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:buttonrightimage style:UIBarButtonItemStyleBordered target:self action:@selector(openMethode)];*/
    
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
    
    if ([[AppDelegate sharedAppDelegate] sessionEmployee] != nil)
    {
        UIImage *buttonrightimage = [UIImage imageNamed:@"profile_icon.png"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:buttonrightimage style:UIBarButtonItemStyleBordered target:self action:@selector(showProfile)];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *target = [segue destinationViewController];
    if ([target isKindOfClass:[LoginViewController class]]) {
        LoginViewController *loginTarget = (LoginViewController*)target;
        [loginTarget setParentView:self];
    }
}

- (IBAction)openSearch:(id)sender {
    //[self performSegueWithIdentifier:@"pushSearchResults" sender:self];
    /*if (! self.swipeController) {
        NSLog(@"swipe controller not found");
    }
    [self.swipeController showLeft];*/
}

- (IBAction)openLogin:(id)sender
{
}

- (void)showProfile
{
    [self performSegueWithIdentifier:@"pushProfile" sender:self];
}

- (void)loggedinCheck
{
    if ([[AppDelegate sharedAppDelegate] sessionEmployee] != nil) {
        UIImage *buttonrightimage = [UIImage imageNamed:@"profile_icon.png"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:buttonrightimage style:UIBarButtonItemStyleBordered target:self action:@selector(showProfile)];
    }
}
@end
