//
//  Table2DataSource.m
//  iKnow
//
//  Created by Martijn Smit on 07-05-13.
//  Copyright (c) 2013 WeMa IT. All rights reserved.
//

#import "Table2DataSource.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
#define FIXED_HEIGHT_SECTION 80.0F

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
    
    // Set labels with twitter items
    NSDictionary *tweet = [_items objectAtIndex:indexPath.row];
    
    UILabel *titelLabel = (UILabel *)[cell viewWithTag:1];
    titelLabel.text = [tweet objectForKey:@"text"];
    
    UILabel *subLabel = (UILabel *)[cell viewWithTag:2];
    subLabel.text = [tweet objectForKey:@"from_user"];
    
    UIImageView *thumb = (UIImageView *)[cell viewWithTag:3];
    [thumb setClipsToBounds:YES];
    [thumb setFrame:CGRectMake(0.0,0.0,80.0,80.0)];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*CGSize theSize = [theObject.theStringToDisplay sizeWithFont:[UIFont systemFontOfSize:18.0f] constrainedToSize:CGSizeMake(265.0f, 9999.0f) lineBreakMode:UILineBreakModeWordWrap];
    // This gets the size of the rectangle needed to draw a multi-line string
    self.numberOfTextRows = round(theSize.height / 18);
    // 18 is the size of the font used in the text label
    // This will give us the number of lines in the multi-line string
    
    if ((indexPath.section == FIXED_HEIGHT_SECTION) || (self.numberOfTextRows < 2)) {
        return 44;
        // 44 is the default row height; use it for empty or one-line cells (or in other table sections)
    } else {
        return theSize.height + 16;
        // 16 seems to provide a decent space above/below; tweak to taste
    }*/
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

@end
