//
//  MainViewController.h
//  indi006
//
//  Created by Cleave Pokotea on 9/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutViewController.h"

@class HtmlViewController;
@class AudioViewController;
@class VideoViewController;

@interface MainViewController : UIViewController <AboutViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    UIImageView * background;
    NSString * cellString;
    UITableView * myTable;
    UITableViewCell * oddCell;
    
    HtmlViewController * hvc;
    AudioViewController * avc;
    VideoViewController * vvc;
    
    int what;
}

@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) NSString * cellString;
@property (nonatomic, retain) IBOutlet UITableView * myTable;
@property (nonatomic, retain) IBOutlet UITableViewCell * oddCell;
@property (nonatomic, retain) HtmlViewController * hvc;
@property (nonatomic, retain) AudioViewController * avc;
@property (nonatomic, retain) VideoViewController * vvc;
@property (nonatomic) int what;

- (IBAction)showAbout;
- (IBAction)showVideoList;
- (IBAction)showAudioList;
- (IBAction)refreshList;

- (void)setupView;
- (void)setBackgroundImage;
- (void)viewOnlineContent;
- (void)switchView;


@end
