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
    NSArray *employees = [IKEmployee employeesFromService];
    IKEmployee *employee = (IKEmployee*)[employees objectAtIndex:0];
    [employee login:@"test123"];
}

@end
