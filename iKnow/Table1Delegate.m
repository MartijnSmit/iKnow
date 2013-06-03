//
//  Table1Delegate.m
//  Extended Tableview Test
//
//  Created by Mark ter Luun on 06-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import "Table1Delegate.h"

@implementation Table1Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *text = [[cell textLabel] text];
    NSString *detail = [[cell detailTextLabel] text];
    NSString *msg = [NSString stringWithFormat:@"%@\nDetail text: %@", text, detail];
    
    [[[UIAlertView alloc] initWithTitle:@"Table 1 item selected" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
}
@end
