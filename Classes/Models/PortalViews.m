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
        newsViewController = [[NewsViewController alloc] init];
        videoViewController = [[VideoViewController alloc] init];
        audioViewController = [[AudioViewController alloc] init];
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
    NSArray *dudArray = [NSArray array];
    [self switchView:whatView withFeed:dudArray];
}

- (void)switchView:(UIView *)currentView (int)whatView withFeed:(NSArray *)feed
{
    LOG_CML;
    
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
