//
//  RightViewController.m
//  iKnow
//
//  Created by Martijn Smit on 23-05-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import "RightViewController.h"
#import "UIViewController+RNSwipeViewController.h"
#import "RNSwipeViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
    if (! self.swipeController) {
        NSLog(@"swipe controller not found");
    }
    [self.swipeController resetView];
}
@end
