//
//  RootViewController.m
//  iKnow
//
//  Created by Martijn Smit on 23-05-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import "RootViewController.h"
#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@interface RootViewController ()

@end

@implementation RootViewController

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
    
    self.centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"];
    //self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"];
    self.rightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"rightViewController"];
    //self.bottomViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bottomViewController"];
    
    if (IS_IPAD) {
        self.rightVisibleWidth = 768;
    }
    
    self.swipeDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Swipe delegate

- (void)swipeController:(RNSwipeViewController *)swipeController willShowController:(UIViewController *)controller {
    NSLog(@"will show");
}

- (void)swipeController:(RNSwipeViewController *)swipeController didShowController:(UIViewController *)controller {
    NSLog(@"did show");
}

@end
