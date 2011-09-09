//
//  CustomAlertView.m
//  iPortal
//
//  Created by Cleave Pokotea on 17/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import "CustomAlertViewController.h"


@implementation CustomAlertViewController

@synthesize webView;
@synthesize background;

- (void)dealloc {
    if(webView) {
        [webView release];
    }
    
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [self setupView];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    LOG_CML;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    LOG_CML;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    LOG_CML;
    
   
	// load error, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	// report the error inside the webview
    if (error != NULL && [error code] != -999) {
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle: [error localizedDescription]
                                   message: [error localizedFailureReason]
                                   delegate:nil
                                   cancelButtonTitle:@"OK" 
                                   otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }
}

- (IBAction)closeAlert {
    LOG_CML;
    
    [self.view removeFromSuperview];
    //[[UIApplication sharedApplication] terminate]; // terminate app properly
}

- (void)setupView {
    
    [self setBackgroundImage];
    [self loadNetworkError];
}

- (void)setBackgroundImage {
	LOG_CML;
    
	UIImageView *customBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"alert-background.png"]];
	self.background = customBackground;
	[customBackground release];
	
	[self.view addSubview:background];
	LOG(@"Added background subview %@ to %@", background, self.view);
	[self.view sendSubviewToBack:background];
}
    
-(void)loadNetworkError {
    LOG_CML;
    
    NSString *helpPath = [[NSBundle mainBundle] pathForResource:@"network" ofType:@"html" inDirectory:@"Help"];
    NSURL *helpURL = [NSURL fileURLWithPath:helpPath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:helpURL]];
}


@end
