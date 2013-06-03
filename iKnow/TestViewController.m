//
//  TestViewController.m
//  iKnow
//
//  Created by Mark ter Luun on 03-06-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([IKEmployee login:@"bert.meijerink@stenden.com" password:@"test123"]) {
        IKEmployee *employee = [[AppDelegate sharedAppDelegate] sessionEmployee];
        
        NSLog(@"Welcome, %@ %@", [employee firstName], [employee lastName]);
    }
    else {
        NSLog(@"Fail");
    }
}

@end
