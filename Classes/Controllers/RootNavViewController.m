//
//  RootNavViewController.m
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "iPortalAppDelegate.h"
#import "RootNavViewController.h"
#import "CustomAlertViewController.h"
#import "PortalFeeds.h"
#import "PortalViews.h"


@implementation RootNavViewController

@synthesize backgroundImage;
@synthesize customAlertViewController;
@synthesize portalFeeds;
@synthesize portalViews;


- (void)dealloc 
{
    LOG_CML;
    
    if(customAlertViewController) 
    {
        [customAlertViewController release];
    }
    
    [portalFeeds release];
    [portalViews release];
    
    [super dealloc];
}

- (id)initWithFeed:(PortalFeeds *)feed
{
    [super initWithNibName:@"RootNavView" bundle:nil];
    portalFeeds = feed;
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}

- (void)viewDidLoad 
{
    LOG_CML;
    
    [self setBackgroundImage];
    [super viewDidLoad];
    
    portalViews = [[PortalViews alloc] init];
    
    // Should also be placed elsewhere but pfft...
    if(![feeds checkIsDataSourceAvailable]) 
    {
        CustomAlertViewController * tempCustomeAlertViewController = [[CustomAlertViewController alloc] init];
        self.customAlertViewController = tempCustomeAlertViewController;
        [tempCustomeAlertViewController release];
        
        // Use “bounds” instead of “applicationFrame” — the latter will introduce 
        // a 20 pixel empty status bar (unless you want that..)
        self.customAlertViewController.view.frame = [UIScreen mainScreen].applicationFrame;
        self.customAlertViewController.view.alpha = 0.0;
        [window addSubview:[customAlertViewController view]];
        
        // Don't yell at me about not using NULL.  They're the same, it's just convention 
        // to use one for pointers and the other one for everything else.
        [UIView beginAnimations:nil context:nil];    
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.33];  //.25 looks nice as well.
        self.customAlertViewController.view.alpha = 1.0;
        [UIView commitAnimations];
    }
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{}

#pragma mark -
- (IBAction)showNewsList 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [portalViews switchView:kNews withFeed:[portalFeeds.localNewsFeed copy]];
}

- (IBAction)showVideoList 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [portalViews switchView:kVideo withFeed:[portalFeeds.localVideoFeed copy]];
}

- (IBAction)showAudioList 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [portalViews switchView:kAudio withFeed:[portalFeeds.localAudioFeed copy]];
}

#pragma mark -
- (void)setBackgroundImage 
{
	LOG_CML;
    
	UIImageView *tempUIImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main-nav-163dpi.png"]];
	self.backgroundImage = tempUIImage;
	[tempUIImage release];
	
	[self.view addSubview:backgroundImage];
	[self.view sendSubviewToBack:backgroundImage];
}


@end
