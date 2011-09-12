//
//  PortalViews.h
//  iPortal
//
//  Created by Cleave Pokotea on 9/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>
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

@interface PortalViews : NSObject
{
    NewsViewController *newsViewController;    
    VideoViewController *videoViewController;    
    AudioViewController *audioViewController;
}

@property (nonatomic, retain)NewsViewController *newsViewController;
@property (nonatomic, retain)VideoViewController *videoViewController;
@property (nonatomic, retain)AudioViewController *audioViewController;


- (void)switchView:(UIView *)currentView whatView:(int)nextView withFeed:(NSArray *)feed;

@end
