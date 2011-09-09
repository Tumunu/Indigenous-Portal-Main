//
//  AudioViewController.m
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AudioViewController.h"
#import "MainViewController.h"
#import "VideoViewController.h"
#import "iPortalAppDelegate.h"
#import "PlayerViewController.h"
#import "Article.h"
#import "Feeds.h"


@implementation AudioViewController

@synthesize background;
@synthesize audioTable;
@synthesize audioTableCell;
@synthesize ipvc;
@synthesize mvc;
@synthesize vvc;

- (void)dealloc 
{
    [feed release];
    [mvc release];
    [vvc release];
    [ipvc release];
    [super dealloc];
}

- (void)viewDidLoad 
{
    LOG_CML;
    
    feed = [[Feeds alloc] init];

    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];	
}

- (void)viewDidUnload
{}

#pragma mark -
#pragma mark Delegate 
- (void)aboutViewControllerDidFinish:(AboutViewController *)controller 
{
    LOG_CML;
    
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Actions
- (IBAction)showAbout 
{  
    LOG_CML;
	
    [iPortalAppDelegate playEffect:kEffectButton];
    [iPortalAppDelegate playEffect:kEffectPage];
	AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
	controller.delegate = self;
	
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (IBAction)showNewsList 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self switchView:kNews];
}
- (IBAction)showVideoList 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self switchView:kVideo];
}

- (IBAction)refreshList
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [feed grabFeed:kAudio url:@"http://www.tumunu.com/iportal/audio-feed.php"];
    [self.audioTable reloadData];
}

- (void)setBackgroundImage 
{
	LOG_CML;
    
	UIImageView *customBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bkgnd.png"]];
	self.background = customBackground;
	[customBackground release];
	
	[self.view addSubview:background];
	LOG(@"Added background subview %@ to %@", background, self.view);
	[self.view sendSubviewToBack:background];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    LOG_CML;
    
	NSInteger feedCount = [feed.localAudioFeed count];
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
    
	UITableViewCell *customCell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"AudioTableCell"];
    
	if (customCell == nil) 
    {
		[[NSBundle mainBundle] loadNibNamed:@"AudioTableCell" owner:self options:NULL];
		customCell = audioTableCell;
		LOG(@"customizing %@", customCell);
	} 
    else 
    {
		LOG(@"reusing %@", customCell.reuseIdentifier);
	}
    
    LOG(@"Set cell content");
	UILabel* titleLabel = (UILabel*) [customCell viewWithTag:1];
	UILabel* dateLabel = (UILabel*) [customCell viewWithTag:3];
    
    int i = indexPath.row;
    NSDictionary * s = [feed.localAudioFeed objectAtIndex:i];
    
	titleLabel.text = [s objectForKey:@"title"];
    dateLabel.text = [s objectForKey:@"pubDate"];
	
    return customCell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    LOG_CML;

    [iPortalAppDelegate playEffect:kEffectPage];
    NSDictionary * s = [feed.localAudioFeed objectAtIndex:indexPath.row];
    //[Article.cellURL = [s objectForKey:@"link"];
        
    [self showPlayer];
}

- (void)setupView 
{
    LOG_CML;
    
#if __IPHONE_3_0
    // UIViewController slips up under status bar. We need to reset it to where it should be placed
    self.view.frame = [[UIScreen mainScreen] applicationFrame];
#endif
    
    [self setBackgroundImage]; 

    [feed checkFeed:kAudio];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)showPlayer 
{
    LOG_CML;
    
    PlayerViewController *tpvc = [[PlayerViewController alloc] initWithNibName:@"PlayerView" bundle:nil];
    self.ipvc = tpvc;
    [tpvc release];
    
    UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
    [theWindow addSubview:[ipvc view]];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.85];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"swap"];     
}

- (void)switchView:(int)whatView
{
    LOG_CML;
    
    VideoViewController *tvvc = [[VideoViewController alloc] initWithNibName:@"VideoView" bundle:nil];
    self.vvc = tvvc;
    [tvvc release];
    
    MainViewController *tmvc = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
    self.mvc = tmvc;
    [tmvc release];
    
    UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
    // remove the current view
    [currentView removeFromSuperview];
    
    switch(whatView) 
    {
        case kNews:
            [theWindow addSubview:[mvc view]];
            break;
        case kVideo:
            [theWindow addSubview:[vvc view]];
            break;
    }
    
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.40];
	[animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"swap"];    
}


@end
