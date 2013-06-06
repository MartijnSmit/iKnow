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
    //[[_emailButton titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    //[_emailButton setTitle:[employee email] forState:UIControlStateNormal];
     _emailLabel.text = [employee email];
    _profileImage.image = [employee photo];
    NSLog(@"skills?? %@", [employee skills]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // Wordt opgeroepen als de email verzonden is
    // Verwijdert de email view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)goBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)openEmail:(id)sender {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // Het onderwerp van de email
    [picker setSubject:@"Questions and information"];
    
    IKEmployee *employee = [[AppDelegate sharedAppDelegate] sessionEmployee];
    // Het emailadres
    // Drie selecties: "aan" "cc" en "bcc"
    [picker setToRecipients:[NSArray arrayWithObjects:[employee email], nil]];
    //[picker setCcRecipients:[NSArray arrayWithObject:@""]];
    //[picker setBccRecipients:[NSArray arrayWithObject:@""]];
    
    // Vulling van email body tekst
    NSString *emailBody = @"My question:";
    
    // Dit is niet een HTML geformatte email
    [picker setMessageBody:emailBody isHTML:NO];
    
    // Laat de email view zien
    [self presentViewController:picker animated:YES completion:nil];
}
@end
