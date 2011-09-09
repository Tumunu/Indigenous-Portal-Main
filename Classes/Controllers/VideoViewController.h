//
//  VideoViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"

@class HtmlViewController;
@class AudioViewController;
@class MainViewController;

@interface VideoViewController : UIViewController <AboutViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    UIImageView * background;
    NSString * cellString;
    UITableView * videoTable;
    UITableViewCell * videoTableCell;
    UIImageView * videoIcon;
    
    HtmlViewController * hvc;
    AudioViewController * avc;
    MainViewController * mvc;
    
    int what;
}

@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) NSString * cellString;
@property (nonatomic, retain) IBOutlet UITableView * videoTable;
@property (nonatomic, retain) IBOutlet UITableViewCell * videoTableCell;
@property (nonatomic, retain) IBOutlet UIImageView * videoIcon;
@property (nonatomic, retain) HtmlViewController * hvc;
@property (nonatomic, retain) AudioViewController * avc;
@property (nonatomic, retain) MainViewController * mvc;
@property (nonatomic) int what;

- (IBAction)showAbout;
- (IBAction)showNewsList;
- (IBAction)showAudioList;
- (IBAction)refreshList;

- (void)setupView;
- (void)setBackgroundImage;
- (void)viewOnlineContent;
- (void)switchView;


@end
