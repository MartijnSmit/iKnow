//
//  TwitterViewController.h
//  AriensZorgpalet
//
//  Created by Martijn Smit on 11-09-12.
//  Copyright (c) 2012 WeMa IT. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "pullToRefreshView.h"
#import <MessageUI/MessageUI.h>

@interface TwitterViewController : UITableViewController { //<PullToRefreshViewDelegate> {
    NSArray *tweets;
}

- (void)fetchTweets;
- (IBAction)tweetButton:(id)sender;
@end
