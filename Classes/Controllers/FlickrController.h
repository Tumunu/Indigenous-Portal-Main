//
//  FlickrController.h
//  iPortal
//
//  Created by Cleave Pokotea on 10/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#import "FlickrImage.h"


#define FLICKR_KEY @"___________"

@protocol FlickrControllerDelegate <NSObject>

- (void)flickrImages:(NSMutableArray *)flickrArray;

@end


@interface FlickrController : NSObject
{
    id<FlickrControllerDelegate> delegate;
}

@property (nonatomic, retain) id<FlickrControllerDelegate> delegate;

- (void)searchFlickr;

@end
