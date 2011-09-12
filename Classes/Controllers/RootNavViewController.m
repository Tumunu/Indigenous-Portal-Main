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
#import "PortalFeeds.h"
#import "PortalViews.h"


@implementation RootNavViewController

@synthesize backgroundImage;
@synthesize customAlertViewController;
@synthesize portalFeeds;
@synthesize portalViews;
@synthesize delegate;


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
    if(![portalFeeds checkIsDataSourceAvailable]) 
    {
        //TODO: custom alert
    }
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{}

#pragma mark -
- (IBAction)showNews 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [self.delegate rootNavHide];
    [portalViews switchView:[[self view] superview] whatView:kNews withFeed:[portalFeeds.localNewsFeed copy]];
}

- (IBAction)showVideo 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [self.delegate rootNavHide];
    [portalViews switchView:[[self view] superview] whatView:kVideo withFeed:[portalFeeds.localVideoFeed copy]];
}

- (IBAction)showAudio 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [self.delegate rootNavHide];
    [portalViews switchView:[[self view] superview] whatView:kAudio withFeed:[portalFeeds.localAudioFeed copy]];
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
