//
//  Table2DataSource.h
//  iKnow
//
//  Created by Martijn Smit on 07-05-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Table2DataSource : NSObject <UITableViewDataSource>
@property (nonatomic, strong) NSArray *items;

- (id)init;
- (void)fetchTweets;
@end
