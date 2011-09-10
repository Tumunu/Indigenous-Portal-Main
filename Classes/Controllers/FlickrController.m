//
//  FlickrController.m
//  iPortal
//
//  Created by Cleave Pokotea on 10/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import "FlickrController.h"

NSString *const FlickrAPIKey = @"000000000000";

@implementation FlickrController

@synthesize delegate;


- (void)searchFlickr
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=indigenous+people&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey];
    NSURL *url = [NSURL URLWithString:urlString];

    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
    [request release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    LOG(@"CALLING:%@", jsonString);  
    
	NSDictionary *results = [jsonString JSONValue];
    NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    NSMutableArray *flickrImageArray = [[NSMutableArray alloc]initWithCapacity:4];
    
	for (NSDictionary *photo in photos)
    {
        FlickrImage *flickrImage = [[FlickrImage alloc] init];
        
		NSString *title = [photo objectForKey:@"title"];
        if(title.length > 0)
        {
            [flickrImage setTitle:title];
        }
        else
        { 
            [flickrImage setTitle:@"Untitled"];
        }
        
		photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_l.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
		[flickrImage setImageURL:[NSURL URLWithString:photoURLString]]; 
        [flickrImageArray addObject:flickrImage];
	}
    
	[jsonString release];  
    [self.delegate flickrImages:flickrImageArray];
}


@end
