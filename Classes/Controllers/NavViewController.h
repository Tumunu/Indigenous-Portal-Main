//
//  NavViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortalViewsMediator.h"
#import "PortalFeeds.h"


@class CustomAlertViewController;

@protocol RootNavDelegate
@required
- (void)rootNavHide;
@end


@interface NavViewController : UIViewController 
{
    UIImageView *backgroundImage;

    CustomAlertViewController *customAlertViewController;
    PortalFeeds *portalFeeds;
    PortalViewsMediator *PortalViewsMediator;
    
    id<RootNavDelegate> delegate;
}

@property (nonatomic, retain) UIImageView *backgroundImage;
@property (nonatomic, retain) CustomAlertViewController *customAlertViewController;
@property (nonatomic, retain) PortalFeeds *portalFeeds;
@property (nonatomic, retain) PortalViewsMediator *PortalViewsMediator;
@property (nonatomic, assign) id <RootNavDelegate> delegate;

- (id)initWithFeed:(PortalFeeds *)portalFeeds;
- (IBAction)showNews;
- (IBAction)showVideo;
- (IBAction)showAudio;

- (void)setBackgroundImage;


@end
