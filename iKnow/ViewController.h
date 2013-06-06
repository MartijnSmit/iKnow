//
//  ViewController.h
//  Extended Tableview Test
//
//  Created by Mark ter Luun on 06-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Table1DataSource.h"
#import "Table2DataSource.h"
#import "Table1Delegate.h"
#import "Table2Delegate.h"

@class LoginViewController;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *Table1;
@property (weak, nonatomic) IBOutlet UITableView *Table2;

@property (nonatomic, retain) NSObject<UITableViewDataSource> *ds1;
@property (nonatomic, retain) NSObject<UITableViewDataSource> *ds2;
@property (nonatomic, retain) NSObject<UITableViewDelegate> *dg1;
@property (nonatomic, retain) NSObject<UITableViewDelegate> *dg2;

- (IBAction)openSearch:(id)sender;
- (IBAction)openLogin:(id)sender;
- (void)loggedinCheck;
@end
