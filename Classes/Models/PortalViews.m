//
//  PortalViews.m
//  iPortal
//
//  Created by Cleave Pokotea on 9/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import "PortalViews.h"

@implementation PortalViews


- (id)init
{
    if ((self = [super init]) != NULL)
	{
        newsViewController = [[NewsViewController alloc] initWithNibName:@"NewsView" bundle:nil];
        videoViewController = [[VideoViewController alloc] initWithNibName:@"VideoView" bundle:nil];
        audioViewController = [[AudioViewController alloc] initWithNibName:@"AudioView" bundle:nil];
	}
    return(self);
}

- (void)dealloc 
{
    [newsViewController release];    
    [videoViewController release];    
    [audioViewController release];
}

- (void)switchView:(int)whatView
{
    // Pass a blank array
    NSMutableArray *dud = [NSMutableArray array];
    [self switchView:whatView withFeed:dud];
}

- (void)switchView:(int)whatView withFeed:(NSMutableArray *)feed
{
    LOG_CML;
    
    UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view view
	UIView *theWindow = [currentView superview];
    // remove the current view
    [currentView removeFromSuperview];
    
    switch(whatView) 
    {
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
