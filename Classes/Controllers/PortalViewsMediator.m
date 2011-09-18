//
//  PortalViewsMediator.m
//  iPortal
//
//  Created by Cleave Pokotea on 9/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PortalViewsMediator.h"


@interface PortalViewsMediator ()
- (void)initialize;
@end


@implementation PortalViewsMediator


@synthesize rootViewController;
@synthesize newsViewController;
@synthesize videoViewController;
@synthesize audioViewController;
@synthesize currentViewController;

static PortalViewsMediator *sharedMediator = nil;

- (void)initialize
{
    rootViewController = [[rootViewController alloc] init];
    newsViewController = [[NewsViewController alloc] init];
    videoViewController = [[VideoViewController alloc] init];
    audioViewController = [[AudioViewController alloc] init];
    currentViewController = rootViewController;
}



/*
 Switch View
 
 1. On view choice animate nav view top to bottom
 2. slide in new view
 */
- (void)switchView:(UIView *)currentView whatView:(int)nextView withFeed:(NSArray *)feed
{
    LOG_CML;

    switch(nextView) 
    {
        case kNews:
            [currentView insertSubview:[newsViewController view] atIndex:1];
            break;
        case kVideo:
            [currentView insertSubview:[videoViewController view] atIndex:1];
            break;
        case kAudio:
            [currentView insertSubview:[audioViewController view] atIndex:1];
            break;
    }
    
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.85];
	[animation setType:kCATransitionPush];
	[animation setSubtype:kCATransitionFromRight];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[currentView layer] addAnimation:animation forKey:@"viewSwitch"];    
}

- (void)showAlert
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


+ (PortalViewsMediator *)sharedInstance
{
    if (sharedMediator == nil) 
    {
        sharedInstance = [[super allocWithZone:NULL] init];
        [sharedMediator initialize];
    }
    
    return sharedMediator;
}

+ (id) allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id) copyWithZone:(NSZone*)zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax;
}

- (void) release
{}

- (id) autorelease
{
    return self;
}

@end
