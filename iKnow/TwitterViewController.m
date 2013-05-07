//
//  TwitterViewController.m
//  AriensZorgpalet
//
//  Created by Martijn Smit on 11-09-12.
//  Copyright (c) 2012 WeMa IT. All rights reserved.
//

#import "TwitterViewController.h"
#import "TwitterItemViewController.h"
//#import "loadingAnimator.h"
#import <Twitter/Twitter.h>

@interface TwitterViewController ()
@property (strong, nonatomic) NSMutableDictionary *thumbnails;
@end

@implementation TwitterViewController
{
  //	PullToRefreshView *pull;
	int pages;
	int tweetsPerPage;
	bool end;
  //  loadingAnimator *load;
}

@synthesize thumbnails = _thumbnails;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    UIImage *backgroundImage = [UIImage imageNamed:@"header"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Terug"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    
    //backBarButton
    UIColor * headercolor = [UIColor colorWithRed:35/255.0f green:65/255.0f blue:143/255.0f alpha:1.0f];
    [[UIBarButtonItem appearance] setTintColor:headercolor];
	
	// Apply the background image
	//UIImage *image = [UIImage imageNamed:@"bg.jpg"];
	//[self.tableView setBackgroundColor:[UIColor colorWithPatternImage:image]];
	
	// Ceate the Pull to refresh-view
//	pull = [[PullToRefreshView alloc] initWithScrollView:self.tableView];
//	[pull setDelegate:self];
	//[pull setBackgroundColor:[UIColor colorWithPatternImage:image]];
//	[self.tableView addSubview:pull];
    
    //create a loading indicator for the view
   // load = [[loadingAnimator alloc] initWithView:(UIView *) self.view withBackground:NO];
   // [self.view addSubview:load];
    
	// Load the tweets
	pages = 1;
	end = NO;
	tweetsPerPage = 25;
    [self fetchTweets];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view
{
	pages = 1;
	end = NO;
	tweets = nil;
	[self fetchTweets];
}*/

- (void)fetchTweets
{
    /*if ([pull getState] == 0)
    {
        [load startLoading];
        [self.tableView setContentOffset:CGPointZero animated:YES];
    }*/
    
	// Don't load new tweets if the end has been reached
	if (YES == end) {
		return;
	}
	
	// Load the new tweets
	UIApplication *app = [UIApplication sharedApplication];
	[app setNetworkActivityIndicatorVisible:YES];
	
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		//int amount = tweetsPerPage * pages;
		NSString *url = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=stenden"]; //amount
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
		int preCount = [tweets count];
		tweets = [twitterSearchResult objectForKey:@"results"];
		int postCount = [tweets count];
		int diff = postCount - preCount;
		if (diff < tweetsPerPage) {
			end = YES;
		}
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
			[app setNetworkActivityIndicatorVisible:NO];
         //   [load stopLoading];
            if (informatie == false) {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Geen internet" message:@"Er kon geen verbinding worden gemaakt, probeer het later nog eens..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
		//	[pull finishedLoading];
        });
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}

-(void)imageAnimate:(UIImageView *)image
{
    //NSLog(@"Animation starts...");
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationCurveLinear
                     animations:^{
                         image.alpha=1;
                     }
                     completion:^(BOOL finished){
                         //NSLog(@"Animation is finished...");
                     }];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
    //begin
    UILabel *titelLabel = (UILabel *)[cell viewWithTag:1];
    titelLabel.text = [tweet objectForKey:@"text"];
    
    UILabel *subLabel = (UILabel *)[cell viewWithTag:2];
    subLabel.text = [tweet objectForKey:@"from_user"];
    
    //NSString *name = [tweet objectForKey:@"from_user"];
    //NSString *text = [tweet objectForKey:@"text"];
    
    UIImageView *thumb = (UIImageView *)[cell viewWithTag:3];
    [thumb setClipsToBounds:YES];
    [thumb setFrame:CGRectMake(0.0,0.0,80.0,80.0)];
    thumb.contentMode = UIViewContentModeScaleAspectFill;
    
    thumb.image = nil;
    thumb.image = [UIImage imageNamed:@"tempthumb.png"];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.hidesWhenStopped = TRUE;
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
    CGFloat x = thumb.frame.size.width/2-25;
    CGFloat y = thumb.frame.size.height/2-25;
    CGRect frame;
    frame = CGRectMake(x,y,50,50);
    indicator.frame = frame;
    
    [indicator startAnimating];
    [thumb addSubview:indicator];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        
        NSString *imgURL;
        
        imgURL = [tweet objectForKey:@"profile_image_url"];
        
        UIImage *newImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]]];
        
        NSLog(@"url = %@",imgURL);
        
        [indicator stopAnimating];
        [indicator removeFromSuperview];
        
        thumb.alpha = 0.0f;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            thumb.image = newImage;
            [self imageAnimate:thumb];
            //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        });
        
    });
    //einde
	
	/*[cell.textLabel setText:[NSString stringWithFormat:@"Door @%@", name]];
	//[cell.textLabel setTextColor:[UIColor whiteColor]];
	
	[cell.detailTextLabel setText:text];
	//[cell.detailTextLabel setTextColor:[UIColor whiteColor]];
	[cell.detailTextLabel setNumberOfLines:1];
	[cell.detailTextLabel setLineBreakMode:UILineBreakModeWordWrap];
	
	// Get the cell's image
	NSString *imageUrl = (NSString*)[tweet objectForKey:@"profile_image_url"];
	UIImage *image;
	if ([_thumbnails objectForKey:imageUrl] == nil) { // Load into the thumbnails cache
		NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
		image = [UIImage imageWithData:data];
	}
	else { // Load from the thumbnails cache
		image = [_thumbnails objectForKey:imageUrl];
	}
	
	// Set the cell's image
	[cell.imageView setImage:image];
	[cell.imageView setBackgroundColor:[UIColor clearColor]];*/
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == tweets.count - 1) {
		pages += 1;
		[self fetchTweets];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *tweet = [tweets objectAtIndex:row];
        
        TwitterItemViewController *detailController = segue.destinationViewController;
        detailController.detailItem = tweet;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    // set navigationbar and backbutton
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    UIImage *backgroundImage = [UIImage imageNamed:@"header"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Terug"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    
    //backBarButton
    UIColor * headercolor = [UIColor colorWithRed:35/255.0f green:65/255.0f blue:143/255.0f alpha:1.0f];
    [[UIBarButtonItem appearance] setTintColor:headercolor];
    
    [super viewWillAppear:animated];
    // Unselect the selected row if any
    NSIndexPath*    selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

// Twitter
- (IBAction)tweetButton:(id)sender {
    
    if([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *tweetComposer = [[TWTweetComposeViewController alloc]
                                                       
                                                       init];
        [tweetComposer setInitialText:@"@iKnow"];
        [self presentModalViewController:tweetComposer animated:YES];
        
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Oeps er ging iets fout" message:@"Niet mogelijk om te tweeten \ue40e heb je de twitter app wel geinstalleerd?"
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
}

@end
