//
//  LoginViewController.m
//  iKnow
//
//  Created by Martijn Smit on 23-05-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

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
	// Do any additional setup after loading the view.
    //[self getUserLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [sender locationInView:nil]; //Passing nil gives us coordinates in the window
        
        //Then we convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
        
        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil])
        {
            // Remove the recognizer first so it's view.window is valid.
            [self.view.window removeGestureRecognizer:sender];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    
    [recognizer setNumberOfTapsRequired:1];
    recognizer.cancelsTouchesInView = NO; //So the user can still interact with controls in the modal view
    [self.view.window addGestureRecognizer:recognizer];
    
}

- (void)loggedIn:(id)sender
{
    //NSLog(@"Logged in");
}

/*-(void)viewWillAppear:(BOOL)animated
{
        [self.view.superview setBounds:CGRectMake(0, 0, 450, 480)];
}*/

- (void)checkLogin
{
    [IKEmployee login:@"" password:@""];
}

/*- (void)getUserLogin
{
    NSError *error;
    NSData *loginData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://92.70.42.51:8000/IknowService.svc//login?email=jeroen.pijpker@stenden.com&password=test123"]];
    NSDictionary *loginItems;
    loginItems = [NSJSONSerialization JSONObjectWithData:loginData
                                            options:kNilOptions
                                                   error:&error];
    NSLog(@"data? %@", loginItems);
    
    for(NSDictionary *data in loginItems)
    {
        // Key is het object
        if (data)
        {
            NSString *key = [data objectForKey:@"key"];
            NSLog(@"key is?: %@", key);
        }
    }
}*/

@end
