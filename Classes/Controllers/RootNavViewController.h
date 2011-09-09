//
//  RootNavViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 14/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortalViews.h"

@class NewsViewController;
@class AudioViewController;
@class VideoViewController;

@interface RootNavViewController : UIViewController 
{
    UIImageView *backgroundImage;

    NewsViewController * newsViewController;
    AudioViewController * audioViewController;
    VideoViewController * videoViewController;
    
    int what;
}

@property (nonatomic, retain) UIImageView *backgroundImage;
@property (nonatomic, retain) NewsViewController * newsViewController;
@property (nonatomic, retain) AudioViewController * audioViewController;
@property (nonatomic, retain) VideoViewController * videoViewController;
@property (nonatomic) int what;

- (IBAction)showNewsList;
- (IBAction)showVideoList;
- (IBAction)showAudioList;

- (void)setBackgroundImage;
- (void)switchView;


@end
