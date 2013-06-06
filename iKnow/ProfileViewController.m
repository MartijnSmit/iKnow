//
//  ProfileViewController.m
//  iKnow
//
//  Created by Martijn Smit on 04-06-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Set all the labels
    IKEmployee *employee = [[AppDelegate sharedAppDelegate] sessionEmployee];
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@", [employee firstName], [employee lastName]];
    [_emailButton setLineBreakMode:UILineBreakModeWordWrap];
    [_emailButton setTitle:[employee email] forState:UIControlStateNormal];
    _profileImage.image = [employee photo];
    NSLog(@"skills?? %@", [employee skills]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
