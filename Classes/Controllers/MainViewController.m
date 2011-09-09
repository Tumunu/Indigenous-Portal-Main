//
//  MainViewController.m
//  indi006
//
//  Created by Cleave Pokotea on 9/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//

#import "MainViewController.h"
#import "HtmlViewController.h"
#import "AudioViewController.h"
#import "VideoViewController.h"
#import "iPortalAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@implementation MainViewController

@synthesize background;
@synthesize myTable;
@synthesize oddCell;
@synthesize cellString;
@synthesize hvc;
@synthesize avc;
@synthesize vvc;
@synthesize what;

- (void)dealloc {
    
    [avc release];
    [vvc release];
    [hvc release];
    [super dealloc];
}

- (void)viewDidLoad {
    LOG(@"-= NEWS CONTROLLER =-");
    LOG_CML;
    
    [[iPortalAppDelegate get] hideActivityIndicator];
    [self setupView];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Delegate 
- (void)aboutViewControllerDidFinish:(AboutViewController *)controller {
    LOG_CML;
    
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Actions
- (IBAction)showAbout {  
    LOG_CML;
	
    [iPortalAppDelegate playEffect:kEffectButton];
    [iPortalAppDelegate playEffect:kEffectPage];
	AboutViewController *controller = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
	controller.delegate = self;
	
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (IBAction)showVideoList {
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    self.what = 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self switchView];
}

- (IBAction)showAudioList {
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    self.what = 2;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self switchView];
}

- (IBAction)refreshList{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString * newsAddress = @"http://www.tumunu.com/iportal/main-feed.php";
    [iPortalAppDelegate get].what = 1;
    [[iPortalAppDelegate get] grabFeed:newsAddress];
    [self.myTable reloadData];
}

- (void)setBackgroundImage {
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	NSInteger i = [[iPortalAppDelegate get].localNewsFeed count];
	LOG(@"Number of rows: %d",i);
    
	return i;
}

// Manages the height of the cell.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {  
    
    NSDictionary * s = [[iPortalAppDelegate get].localNewsFeed objectAtIndex:indexPath.row];
    cellString = [[s objectForKey:@"description"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Default label size
    CGSize labelSize = CGSizeMake(273.0, 10.0);
    
    if ([cellString length] > 0) {
        //LOG(@"String length is greater than zero");
        
        // Scaled label size
        labelSize = [cellString sizeWithFont: [UIFont systemFontOfSize: 12.0] constrainedToSize: CGSizeMake(273.0, 1000.0) lineBreakMode: UILineBreakModeTailTruncation];
    }
    //LOG(@"label height: %2f | %2f", labelSize.height, indexPath.row);
    
    return 65.0 + labelSize.height;
} 

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	LOG(@"cellForRowAtIndexPath %@", indexPath);
    
	UITableViewCell *customCell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"RssTableCell"];
    
	if (customCell == nil) {
        
		[[NSBundle mainBundle] loadNibNamed:@"RssTableCell" owner:self options:NULL];
		customCell = oddCell;
		LOG(@"customizing %@", customCell);
	} else {
        
		LOG(@"reusing %@", customCell.reuseIdentifier);
	}
    
    LOG(@"Set cell content");
	UILabel* titleLabel = (UILabel*) [customCell viewWithTag:1];
	UILabel* authorLabel = (UILabel*) [customCell viewWithTag:2];
	UILabel* dateLabel = (UILabel*) [customCell viewWithTag:3];
    UILabel* contentLabel = (UILabel*) [customCell viewWithTag:4];
    
    int i = indexPath.row;
    NSDictionary * s = [[iPortalAppDelegate get].localNewsFeed objectAtIndex:i];
    //LOG(@"NS Dict: %@", s);
    
	titleLabel.text = [s objectForKey:@"title"];
    authorLabel.text = [s objectForKey:@"author"];
    //authorLabel.text = @"";
    dateLabel.text = [s objectForKey:@"pubDate"];
    contentLabel.text = [s objectForKey:@"description"];
	
    return customCell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [iPortalAppDelegate playEffect:kEffectPage];
    // Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
    NSDictionary * s = [[iPortalAppDelegate get].localNewsFeed objectAtIndex:indexPath.row];
    [iPortalAppDelegate get].cellURL = [s objectForKey:@"link"];   
    
    LOG(@"Cell %@ selected open link %@", indexPath, [iPortalAppDelegate get].cellURL);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [iPortalAppDelegate get].what = 1; // We set this so the HTML View knows where to return
    [self viewOnlineContent];
}

- (void)setupView {
    LOG_CML;
    
#if __IPHONE_3_0
    // UIViewController slips up under status bar. We need to reset it to where it should be placed
    self.view.frame = [[UIScreen mainScreen] applicationFrame];
#endif
    
    [self setBackgroundImage]; 
    [iPortalAppDelegate get].what = 1;
    [[iPortalAppDelegate get] checkFeed];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewOnlineContent {
    LOG_CML;
    
    HtmlViewController *thvc = [[HtmlViewController alloc] initWithNibName:@"HtmlView" bundle:nil];
    self.hvc = thvc;
    [thvc release];
    
    UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
    [theWindow addSubview:[hvc view]];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.45];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"swap"];    
}


- (void)switchView {
    LOG_CML;
    
    VideoViewController *tvvc = [[VideoViewController alloc] initWithNibName:@"VideoView" bundle:nil];
    self.vvc = tvvc;
    [tvvc release];
    
    AudioViewController *tavc = [[AudioViewController alloc] initWithNibName:@"AudioView" bundle:nil];
    self.avc = tavc;
    [tavc release];
    
    UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
    // remove the current view
    [currentView removeFromSuperview];
    
    switch(self.what) {
        case 1:
            // replace vvc
            [theWindow addSubview:[vvc view]];
            break;
        case 2:
            // replace with avc
            [theWindow addSubview:[avc view]];
            break;
    }
    
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.40];
	[animation setType:kCATransitionPush];
	//[animation setSubtype:kCATransitionFromTop];
    [animation setSubtype:kCATransitionFromLeft];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"swap"];    
}


@end
