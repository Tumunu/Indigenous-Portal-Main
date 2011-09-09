//
//  NavViewController.m
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import "NavViewController.h"
#import "MainViewController.h"
#import "AudioViewController.h"
#import "VideoViewController.h"
#import "iPortalAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@implementation NavViewController

@synthesize background;
@synthesize mvc;
@synthesize avc;
@synthesize vvc;
@synthesize what;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    LOG(@"-= NAV CONTROLLER =-");
    LOG_CML;
    
    [super viewDidLoad];
    [self setBackgroundImage]; 
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


- (void)dealloc {
    LOG_CML;
    
    [mvc release];
    [avc release];
    [vvc release];
    [super dealloc];
}

- (IBAction)showNewsList {
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    self.what = 1;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self switchView];
}

- (IBAction)showVideoList {
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    self.what = 2;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self switchView];
}

- (IBAction)showAudioList {
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    self.what =3;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self switchView];
}

- (void)setBackgroundImage {
	LOG_CML;
    
	UIImageView *customBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main-nav-163dpi.png"]];
	self.background = customBackground;
	[customBackground release];
	
	[self.view addSubview:background];
	LOG(@"Added background subview %@ to %@", background, self.view);
	[self.view sendSubviewToBack:background];
}

- (void)switchView {
    LOG_CML;
    
    MainViewController *tmvc = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
    self.mvc = tmvc;
    [tmvc release];
    
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
            // replace with mvc
            [theWindow addSubview:[mvc view]];
            break;
        case 2:
            // replace vvc
            [theWindow addSubview:[vvc view]];
            break;
        case 3:
            // replace with avc
            [theWindow addSubview:[avc view]];
            break;
    }
    
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.85];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromTop];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"swap"];    
}

@end
