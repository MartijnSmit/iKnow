//
//  Table2DataSource.m
//  iKnow
//
//  Created by Martijn Smit on 07-05-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import "Table2DataSource.h"


@implementation Table2DataSource
int numberOfTextRows;

- (id)init
{
    // Set test data
    //[self setItems:[[NSArray alloc] initWithObjects:@"Table 2 item 1", @"Table 2 item 2", @"Table 2 item 3", @"Table 2 item 4", @"Table 2 item 5", nil]];
    
    [self fetchTweets];
    
    
    // Pull to Refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    //set the title for pull request
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"pull to Refresh"];
    //call he refresh function
    [refreshControl addTarget:self action:@selector(refreshMyTableView)
             forControlEvents:UIControlEventValueChanged];
    refreshControl = refreshControl;
    
    [self refreshControl];
    
    // Initialize the super class
    return [super init];
}

// Fetch the tweet messages
- (void)fetchTweets
{
	// Show activity indicator when loading tweets
	//UIApplication *app = [UIApplication sharedApplication];
	//[app setNetworkActivityIndicatorVisible:YES];
    
		//int amount = tweetsPerPage * pages;
		NSString *url = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=stenden"];
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        NSDictionary *twitterSearchResult;
        
        NSError* error;
        BOOL informatie = true;
        
        
        if (data == nil) {
            //[alertView show];
            NSLog(@"Wat zit er in data? %@", data);
            NSLog(@"geen informatie fout");
            informatie = false;
        }
        else{
            twitterSearchResult = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&error];
        }
		/*int preCount = [tweets count];
		tweets = [twitterSearchResult objectForKey:@"results"];
		int postCount = [tweets count];
		int diff = postCount - preCount;
		if (diff < tweetsPerPage) {
			end = YES;*/
        
        _items = [twitterSearchResult objectForKey:@"results"];
        //[self setItems:[twitterSearchResult objectForKey:@"results"]];
        //NSLog(@"Hello is there anybody in there? %@", _items);
        
        /*dispatch_async(dispatch_get_main_queue(), ^{
            // reload the tableview
            
            //[app setNetworkActivityIndicatorVisible:NO];
            if (informatie == false) {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Geen internet" message:@"Er kon geen verbinding worden gemaakt, probeer het later nog eens..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
        });*/
    //});
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%d", [[self items] count]);
    return [[self items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *tweetcell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    static NSString *CellIdentifier = @"TweetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    //cell.textLabel.numberOfLines = self.numberOfTextRows;
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSInteger mod = [indexPath row] % 2;
    if (mod == 1) {
        [cell.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"twitterbg1.png"]]];
        
    }else{
        [cell.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"twitterbg2.png"]]];
    }
    
    // Tableview background
    [tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"twitter_bg.png"]]];
    // Seperator
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"twitter_seperator.png"]];
    [tableView setSeparatorColor:color];
    
    // Set labels with twitter items
    NSDictionary *tweet = [_items objectAtIndex:indexPath.row];
    
    UILabel *titelLabel = (UILabel *)[cell viewWithTag:1];
    titelLabel.text = [tweet objectForKey:@"text"];
    
    UILabel *subLabel = (UILabel *)[cell viewWithTag:2];
    subLabel.text = [tweet objectForKey:@"from_user"];
    
    UIImageView *thumb = (UIImageView *)[cell viewWithTag:3];
    [thumb setClipsToBounds:YES];
    [thumb setFrame:CGRectMake(10.0,20.0,100.0,100.0)];
    thumb.contentMode = UIViewContentModeScaleAspectFill;
    
    thumb.image = nil;
    //thumb.image = [UIImage imageNamed:@"tempthumb.png"];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.hidesWhenStopped = TRUE;
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    CGFloat x = thumb.frame.size.width/2-25;
    CGFloat y = thumb.frame.size.height/2-25;
    CGRect frame;
    frame = CGRectMake(x,y,50,50);
    indicator.frame = frame;
    
    //[indicator startAnimating];
    //[thumb addSubview:indicator];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        
        NSString *imgURL;
        
        imgURL = [tweet objectForKey:@"profile_image_url"];
        
        UIImage *newImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]]];
        
        NSLog(@"url = %@",imgURL);
        
        //[indicator stopAnimating];
        //[indicator removeFromSuperview];
        
        //thumb.alpha = 0.0f;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            thumb.image = newImage;
            //[self imageAnimate:thumb];
            //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        });
        
    });
    return cell; 
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *tweet = [_items objectAtIndex:indexPath.row];
    
    // Display the tweets & tweetauthor
	NSString *tweets = [tweet objectForKey:@"text"];
	NSString *tweetauthor = [tweet objectForKey:@"from_user"];
	NSString *display = [NSString stringWithFormat:@"%@\n\n%@", tweets, tweetauthor];
    
   // NSString *text =
    //NSString *text = [_items objectAtIndex:[indexPath row]];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [display sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    NSLog(@"Height? %f", height);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}*/


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <[_items count])
    {
        CGFloat     result = 44.0f;
        NSString*   text = nil;
        CGFloat     width =220 ;
        
        if (text)
        {
            
            CGSize      textSize = { width, 20000.0f };     // width and height of text area
            CGSize      size = [text sizeWithFont:[UIFont boldSystemFontOfSize:15] constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
            
            size.height += 90.0f;           // top and bottom margin
            result = MAX(size.height, result)  ;    // at least one row
        }
        
        return result;
        
    }
    else
    {
        return 230.0;
    }
}

-(void)refreshTableView{
    
    //set the title while refreshing
    _refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing the TableView"];
    //set the date and time of refreshing
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc]init];
    [formattedDate setDateFormat:@"MMM d, h:mm a"];
    NSString *lastupdated = [NSString stringWithFormat:@"Last Updated on %@",[formattedDate stringFromDate:[NSDate date]]];
    _refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:lastupdated];
    //end the refreshing
    [_refreshControl endRefreshing];
    
}

/*- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if((indexPath.row)==0)
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage            imageNamed:@"twitter_bg.png"]]; //set image for cell 0
    if (indexPath.row==1)
        cell.backgroundColor = [UIColor colorWithRed:.8 green:.6 blue:.6 alpha:1]; //set color for cell 1
    
    tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"twitter_bg.png"]]; //set image for UITableView
}*/

@end
