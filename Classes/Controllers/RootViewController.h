//
//  RootViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 10/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortalFeeds.h"
#import "FlickrController.h"
#import "RootNavViewController.h"


@interface RootViewController : UIViewController <FlickrControllerDelegate>
{
    RootNavViewController *rootNavViewController;
    PortalFeeds *feeds;
    FlickrController* flickrData;
    
    NSMutableArray *backgroundImagesArray;
    UIImageView *coverImageView;
}

@property (nonatomic, retain) RootNavViewController *rootNavViewController;
@property (nonatomic, retain) PortalFeeds *feeds;
@property (nonatomic, retain) FlickrController *flickrData;
@property (nonatomic, retain) UIImageView *coverImageView;
@property (nonatomic, assign) NSMutableArray *backgroundImagesArray;

- (void)initSplashCover;

@end
