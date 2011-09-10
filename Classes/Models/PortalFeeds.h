//
//  PortalFeeds.h
//  iPortal
//
//  Created by Cleave Pokotea on 9/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"


@protocol PortalFeedsDelegate <NSObject>
@required
-(void)feedItems:(NSArray *)items;

@end


@interface PortalFeeds : NSObject
{
    NSDate *feedDate;
    NSMutableArray *localNewsFeed;
    NSMutableArray *localVideoFeed;
    NSMutableArray *localAudioFeed;
    
    BOOL isDataSourceAvailable;
}


@property (nonatomic, retain) NSMutableArray *localNewsFeed;
@property (nonatomic, retain) NSMutableArray *localVideoFeed;
@property (nonatomic, retain) NSMutableArray *localAudioFeed;


- (BOOL)checkIfFeedArrayExists:(int)whatFeed;
- (void)grabArticles:(int)whatFeed url:(NSString *)portalAddress;
- (BOOL)checkIsDataSourceAvailable;
- (NSString *)springClean:(NSString *)sourceString;


@end
