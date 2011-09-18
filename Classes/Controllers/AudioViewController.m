//
//  AudioViewController.m
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AudioViewController.h"
#import "NewsViewController.h"
#import "VideoViewController.h"
#import "iPortalAppDelegate.h"
#import "PlayerViewController.h"


@implementation AudioViewController

@synthesize backgroundImage;
@synthesize audioTable;
@synthesize audioTableCell;
@synthesize playerViewController;
@synthesize newsViewController;
@synthesize videoViewController;
@synthesize portalFeeds;
@synthesize portalArticle;

- (void)dealloc 
{
    [newsViewController release];
    [videoViewController release];
    [playerViewController release];
    [PortalViewsMediator release];
    [portalFeeds release];
    [portalArticle release];
    [super dealloc];
}

- (void)viewDidLoad 
{
    LOG_CML;

    [super viewDidLoad];
    [self setupView];
    [[PortalViewsMediator alloc] init];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];	
}

- (void)viewDidUnload
{}

#pragma mark -
- (void)setupView 
{
    LOG_CML;
    
#if __IPHONE_3_0
    // UIViewController slips up under status bar. We need to reset it to where it should be placed
    self.view.frame = [[UIScreen mainScreen] applicationFrame];
#endif
    
    [self setBackgroundImage]; 
    
    portalFeeds = [[PortalFeeds alloc] init];
    [portalFeeds checkFeed:kAudio];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)setBackgroundImage 
{
	LOG_CML;
    
	UIImageView *tempUIImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bkgnd.png"]];
	self.backgroundImage = tempUIImage;
	[tempUIImage release];
	
	[self.view addSubview:backgroundImage];
	[self.view sendSubviewToBack:backgroundImage];
}

#pragma mark -
#pragma mark Delegates 
- (void)aboutViewControllerDidFinish:(AboutViewController *)controller 
{
    LOG_CML;
    
	[self dismissModalViewControllerAnimated:YES];
}

-(void)feedItems:(NSArray *)items
{
    
}

#pragma mark -
#pragma mark Actions
- (IBAction)showAbout 
{  
    LOG_CML;
	
    [iPortalAppDelegate playEffect:kEffectButton];
    [iPortalAppDelegate playEffect:kEffectPage];
    
	AboutViewController *tempAboutViewController = [[AboutViewController alloc] init];
	tempAboutViewController.delegate = self;
	[self presentModalViewController:tempAboutViewController animated:YES];
	[tempAboutViewController release];
}

- (IBAction)showNewsList 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [PortalViewsMediator switchView:kNews];
}
- (IBAction)showVideoList 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [PortalViewsMediator switchView:kVideo];
}

- (IBAction)refreshList
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [portalFeeds grabFeed:kAudio url:@"http://www.tumunu.com/iportal/audio-feed.php"];
    [self.audioTable reloadData];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    LOG_CML;
    
	NSInteger feedCount = [portalFeeds.localAudioFeed count];
	LOG(@"Number of rows: %d",feedCount);
    
	return feedCount;
}

// Manages the height of the cell.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    // TODO: Adjustable cell
    return 54;
} 

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	LOG(@"cellForRowAtIndexPath %@", indexPath);
    
	UITableViewCell *customCell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"AudioTableCell"];
    
	if (customCell == nil) 
    {
		[[NSBundle mainBundle] loadNibNamed:@"AudioTableCell" owner:self options:NULL];
		customCell = audioTableCell;
	}
    
	UILabel *titleLabel = (UILabel *) [customCell viewWithTag:1];
	UILabel *dateLabel = (UILabel *) [customCell viewWithTag:3];
    
    NSDictionary *article = [portalFeeds.localAudioFeed objectAtIndex:indexPath.row];
	titleLabel.text = [article objectForKey:@"title"];
    dateLabel.text = [article objectForKey:@"pubDate"];
	
    return customCell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    LOG_CML;

    [iPortalAppDelegate playEffect:kEffectPage];
    NSDictionary *article = [portalFeeds.localAudioFeed objectAtIndex:indexPath.row];
    self.portalArticle.articleURL = [article objectForKey:@"link"];
        
    [self showPlayer];
}

#pragma mark -
- (void)showPlayer 
{
    LOG_CML;
    
    PlayerViewController *tempPlayerViewController = [[PlayerViewController alloc] init];
    self.playerViewController = tempPlayerViewController;
    [tempPlayerViewController release];
    
    UIView *currentView = self.view;
	UIView *theWindow = [currentView superview];
	
	[currentView removeFromSuperview];
    [theWindow addSubview:[playerViewController view]];
	
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.85];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"swap"];     
}


@end
