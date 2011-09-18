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
#import "NavViewController.h"


@interface RootViewController : UIViewController <FlickrControllerDelegate>
{
    NavViewController *NavViewController;
    PortalFeeds *feeds;
    FlickrController* flickrData;
    
    NSMutableArray *backgroundImagesArray;
    UIImageView *coverImageView;
}

@property (nonatomic, retain) NavViewController *NavViewController;
@property (nonatomic, retain) PortalFeeds *feeds;
@property (nonatomic, retain) FlickrController *flickrData;
@property (nonatomic, retain) UIImageView *coverImageView;
@property (nonatomic, assign) NSMutableArray *backgroundImagesArray;

- (void)initSplashCover;

@end
