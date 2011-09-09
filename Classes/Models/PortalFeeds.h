//
//  PortalFeeds.h
//  iPortal
//
//  Created by Cleave Pokotea on 9/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PortalFeeds : NSObject
{
    NSMutableArray *localNewsFeed;
    NSMutableArray *localVideoFeed;
    NSMutableArray *localAudioFeed;
}

@property (nonatomic, retain) NSMutableArray *localNewsFeed;
@property (nonatomic, retain) NSMutableArray *localVideoFeed;
@property (nonatomic, retain) NSMutableArray *localAudioFeed;

- (void)checkFeed:(int)whatFeed;
- (void) grabFeed:(int)whatFeed url:(NSString *)portalAddress;
- (BOOL)checkIsDataSourceAvailable;
- (NSString *)springClean:(NSString *)sourceString;


@end
