//
//  AudioViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"
#import "PortalViewsMediator.h"
#import "PortalFeeds.h"
#import "PortalArticle.h"

@class PlayerViewController;
@class NewsViewController;
@class VideoViewController;

@interface AudioViewController : UIViewController <AboutViewControllerDelegate, PortalFeedsDelegate, UITableViewDelegate, UITableViewDataSource> 
{
    UIImageView *backgroundImage;
    UITableView *audioTable;
    UITableViewCell *audioTableCell;
    
    PlayerViewController *playerViewController;
    NewsViewController *newsViewController;
    VideoViewController *videoViewController;
    PortalViewsMediator *PortalViewsMediator;
    PortalFeeds *portalFeeds;
    PortalArticle *portalArticle;
}

@property (nonatomic, retain) UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UITableView *audioTable;
@property (nonatomic, retain) IBOutlet UITableViewCell *audioTableCell;
@property (nonatomic, retain) PlayerViewController *playerViewController;
@property (nonatomic, retain) NewsViewController *newsViewController;
@property (nonatomic, retain) VideoViewController *videoViewController;
@property (nonatomic, retain) PortalFeeds *portalFeeds;
@property (nonatomic, retain) PortalArticle *portalArticle;

- (IBAction)showAbout;
- (IBAction)showNewsList;
- (IBAction)showVideoList;
- (IBAction)refreshList;

- (void)setupView;
- (void)setBackgroundImage;
- (void)showPlayer;


@end
