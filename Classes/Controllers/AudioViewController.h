//
//  AudioViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"
#import "Feeds.h"

@class PlayerViewController;
@class MainViewController;
@class VideoViewController;

@interface AudioViewController : UIViewController <AboutViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> 
{
    UIImageView * background;
    UITableView * audioTable;
    UITableViewCell * audioTableCell;
    
    PlayerViewController * ipvc;
    MainViewController * mvc;
    VideoViewController * vvc;
    
    Feeds *feed;
}

@property (nonatomic, retain) UIImageView * background;
@property (nonatomic, retain) IBOutlet UITableView * audioTable;
@property (nonatomic, retain) IBOutlet UITableViewCell * audioTableCell;
@property (nonatomic, retain) PlayerViewController * ipvc;
@property (nonatomic, retain) MainViewController * mvc;
@property (nonatomic, retain) VideoViewController * vvc;

- (IBAction)showAbout;
- (IBAction)showNewsList;
- (IBAction)showVideoList;
- (IBAction)refreshList;

- (void)setupView;
- (void)setBackgroundImage;
- (void)showPlayer;
- (void)switchView:(int)whatView;

@end
