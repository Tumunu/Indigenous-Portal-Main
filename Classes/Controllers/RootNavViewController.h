//
//  RootNavViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortalViews.h"
#import "PortalFeeds.h"


@class CustomAlertViewController;

@protocol RootNavDelegate
@required
- (void)rootNavHide;
@end


@interface RootNavViewController : UIViewController 
{
    UIImageView *backgroundImage;

    CustomAlertViewController *customAlertViewController;
    PortalFeeds *portalFeeds;
    PortalViews *portalViews;
    
    id<RootNavDelegate> delegate;
}

@property (nonatomic, retain) UIImageView *backgroundImage;
@property (nonatomic, retain) CustomAlertViewController *customAlertViewController;
@property (nonatomic, retain) PortalFeeds *portalFeeds;
@property (nonatomic, retain) PortalViews *portalViews;
@property (nonatomic, assign) id <RootNavDelegate> delegate;

- (id)initWithFeed:(PortalFeeds *)portalFeeds;
- (IBAction)showNews;
- (IBAction)showVideo;
- (IBAction)showAudio;

- (void)setBackgroundImage;


@end
