//
//  FlickrImage.h
//  iPortal
//
//  Created by Cleave Pokotea on 10/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrImage : NSObject
{
    NSString *flickrURL;
    NSString *imageURL;
    NSString *title;
}

@property (nonatomic, retain) NSString *flickrURL;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *title;

@end
