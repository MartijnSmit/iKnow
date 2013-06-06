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
    [self testSearch];
}

- (void)testSkills
{
    NSArray *employees  = [IKEmployee employeesFromService];
    IKEmployee *employee = (IKEmployee*)[employees objectAtIndex:0];
    NSLog(@"%@", [employee skills]);
}

- (void)testSearch
{
    NSArray *tags = [IKTag tagsFromService];
    NSMutableArray *searchTags = [[NSMutableArray alloc] init];
    
    [searchTags addObject:[tags objectAtIndex:0]];
    [searchTags addObject:[tags objectAtIndex:4]];
    [searchTags addObject:[tags objectAtIndex:6]];
    
    NSArray *searchResults = [IKTag searchEmployeesByTags:searchTags];
    NSLog(@"%@", searchResults);
}

@end
