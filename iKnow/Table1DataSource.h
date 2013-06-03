//
//  Table1DataSource.h
//  Extended Tableview Test
//
//  Created by Mark ter Luun on 06-05-13.
//  Copyright (c) 2013 Vestech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Table1DataSource : NSObject <UITableViewDataSource>
@property (nonatomic, strong) NSArray *items;

- (id)initWithTestData;
@end
