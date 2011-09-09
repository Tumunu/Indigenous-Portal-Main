//
//  NavViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MainViewController;
@class AudioViewController;
@class VideoViewController;

@interface NavViewController : UIViewController {

    UIImageView *background;
    
    MainViewController * mvc;
    AudioViewController * avc;
    VideoViewController * vvc;
    
    int what;
}

@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) MainViewController * mvc;
@property (nonatomic, retain) AudioViewController * avc;
@property (nonatomic, retain) VideoViewController * vvc;
@property (nonatomic) int what;

- (IBAction)showNewsList;
- (IBAction)showVideoList;
- (IBAction)showAudioList;

- (void)setBackgroundImage;
- (void)switchView;


@end
