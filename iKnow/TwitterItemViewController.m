//
//  TwitterItemViewController.m
//  AriensZorgpalet
//
//  Created by Martijn Smit 1/8/12.
//  Copyright (c) 2012 WeMa IT All rights reserved.
//

#import "TwitterItemViewController.h"

@interface TwitterItemViewController ()
- (void)configureView;
@end

@implementation TwitterItemViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;

#pragma mark - Managing the detail item


- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        NSDictionary *tweet = self.detailItem;
        
        NSString *name = (NSString*)[tweet objectForKey:@"from_user"];
        NSString *text = (NSString*)[tweet objectForKey:@"text"];
        
        nameLabel.text = [NSString stringWithFormat:@"Door @%@", name];
        twitterTextbox.text = text;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageUrl = [tweet objectForKey:@"profile_image_url"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
			UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
				[profileImage setContentMode:UIViewContentModeScaleAspectFit];
				[profileImage setImage:image];
                
            });
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    UIImage *backgroundImage = [UIImage imageNamed:@"header"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Terug"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    
    //backBarButton
    [[UIBarButtonItem appearance] setTintColor:[UIColor blueColor]];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillAppear:(BOOL)animated
{
    // set navigationbar and backbutton
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    UIImage *backgroundImage = [UIImage imageNamed:@"header"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Terug"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    
    //backBarButton
    [[UIBarButtonItem appearance] setTintColor:[UIColor blueColor]];
}

@end
