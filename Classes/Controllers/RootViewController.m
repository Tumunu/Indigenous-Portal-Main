//
//  RootViewController.m
//  iPortal
//
//  Created by Cleave Pokotea on 10/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize rootNavViewController;
@synthesize feeds;
@synthesize flickrData;
@synthesize backgroundImagesArray;
@synthesize coverImageView;


- (void)dealloc
{
    [feeds release];
    [flickrData release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    feeds = [[PortalFeeds alloc] init];
    [self initSplashCover];
    
    RootNavViewController *tempRootNavViewController = [[RootNavViewController alloc] initWithFeed:feeds];
    self.rootNavViewController = tempRootNavViewController;
    [tempRootNavViewController release];
    
    [self.view insertSubview:[rootNavViewController view] atIndex:1];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)initSplashCover
{    
    flickrData = [[FlickrController alloc] init];
    [flickrData searchFlickr];
}

- (void)flickrImages:(NSMutableArray *)flickrArray
{
    self.backgroundImagesArray = flickrArray;
    
    int arrayCount = [self.backgroundImagesArray count];
    if (arrayCount > 0)
    {
        int minIndex = 0;
        int randomImageIndex = ((arc4random()%(arrayCount-minIndex+1))+minIndex)-1;
        FlickrImage *flickrImage = [self.backgroundImagesArray objectAtIndex:randomImageIndex];
        
        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[flickrImage imageURL]]];
        UIImage *backgroundImage = [UIImage imageWithData:imageData];
        [imageData release];
        
        UIImageView *tempUIImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [tempUIImageView setBackgroundColor:[UIColor clearColor]];
        [tempUIImageView setImage:backgroundImage];     
        self.coverImageView = tempUIImageView;
        [self.view insertSubview:self.coverImageView atIndex:0];
        [tempUIImageView release];       
    }
    
    [flickrData release];
}

@end
