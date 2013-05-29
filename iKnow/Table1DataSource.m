//
//  Table1DataSource.m
//  Extended Tableview Test
//
//  Created by Mark ter Luun on 06-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import "Table1DataSource.h"

@implementation Table1DataSource

- (id)initWithTestData
{
    // Set test data
    [self setItems:[[NSArray alloc] initWithObjects:@"Table 1 item 1", @"Table 1 item 2", @"Table 1 item 3", nil]];
    
    // Initialize the super class
    return [super init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *prototype = [tableView dequeueReusableCellWithIdentifier:@"prototype"];
    
    [[prototype textLabel] setText:(NSString *)[[self items] objectAtIndex:[indexPath row]]];
    [[prototype detailTextLabel] setText:@"Detail"];
    
    // Tableview background
    [tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"skill_bg.png"]]];
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"skill_seperator.png"]];
    [tableView setSeparatorColor:color];
    
    return prototype;
}
@end
