//
//  PortalViews.h
//  iPortal
//
//  Created by Cleave Pokotea on 9/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>

enum ViewType
{
    kNews=0,
    kAudio,
    kVideo,
	kNumViewTypes
};

@class NewsViewController;
@class VideoViewController;
@class AudioViewController;

@interface PortalViews : NSObject
{
    NewsViewController *newsViewController;    
    VideoViewController *videoViewController;    
    AudioViewController *audioViewController;
}

@property (nonatomic, retain)NewsViewController *newsViewController;
@property (nonatomic, retain)VideoViewController *videoViewController;
@property (nonatomic, retain)AudioViewController *audioViewController;


- (void)switchView:(int)whatView;
- (void)switchView:(int)whatView withFeed:(NSMutableArray *)feed;

@end
