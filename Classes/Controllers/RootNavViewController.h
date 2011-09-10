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


@interface RootNavViewController : UIViewController 
{
    UIImageView *backgroundImage;

    CustomAlertViewController *customAlertViewController;
    PortalFeeds *portalFeeds;
    PortalViews *portalViews;
}

@property (nonatomic, retain) UIImageView *backgroundImage;
@property (nonatomic, retain) CustomAlertViewController *customAlertViewController;
@property (nonatomic, retain) PortalFeeds *portalFeeds;

- (id)initWithFeed:(PortalFeeds *)portalFeeds;
- (IBAction)showNewsList;
- (IBAction)showVideoList;
- (IBAction)showAudioList;

- (void)setBackgroundImage;


@end
