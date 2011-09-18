//
//  PortalViewsMediator.h
//  iPortal
//
//  Created by Cleave Pokotea on 9/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootViewController.h"
#import "NewsViewController.h"
#import "VideoViewController.h"
#import "AudioViewController.h"
#import "CustomAlertViewController.h"


enum ViewType
{
    kNews=0,
    kAudio,
    kVideo,
	kNumViewTypes
};


@interface PortalViewsMediator : NSObject
{
    @private
    RootViewController *rootViewController;
    NewsViewController *newsViewController;    
    VideoViewController *videoViewController;    
    AudioViewController *audioViewController;
    
    UIViewController *currentViewController;
}


@property (nonatomic, readonly)RootViewController *rootViewController;
@property (nonatomic, readonly)NewsViewController *newsViewController;
@property (nonatomic, readonly)VideoViewController *videoViewController;
@property (nonatomic, readonly)AudioViewController *audioViewController;
@property (nonatomic, readonly)UIViewController *currentViewController;


- (void)switchView:(UIView *)currentView whatView:(int)nextView withFeed:(NSArray *)feed;

// Necessary evil
+ (PortalViewsMediator *)sharedInstance;

@end
