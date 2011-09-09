//
//  AboutViewController.m
//  iPortal
//
//  Created by Cleave Pokotea on 9/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//

#import "AboutViewController.h"
#import "iPortalAppDelegate.h"


@implementation AboutViewController

@synthesize delegate;
@synthesize background;
@synthesize webView;
@synthesize doneBtn;
@synthesize shareBtn;

- (void)dealloc 
{
    if(webView) 
    {
        [webView release];
    }
    
    if(doneBtn) 
    {
        [doneBtn release];
    }    
    
    [super dealloc];
}

- (void)viewDidLoad 
{
    LOG_CML;
    
    [super viewDidLoad];
    
    self.webView.scalesPageToFit = NO;
    
	[self setupController];
}

- (IBAction)done 
{
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [iPortalAppDelegate playEffect:kEffectPage];
	[self.delegate aboutViewControllerDidFinish:self];	
}

- (IBAction)mail {}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{}


- (void)setupController
{
#if __IPHONE_3_0
    // UIViewController slips up under status bar. We need to reset it to where it should be placed
    self.view.frame = [[UIScreen mainScreen] applicationFrame];
#endif
    
    [self loadAbout];    
    
    // Done button
    UIFont *displayFont = [UIFont fontWithName:@"Helvetica" size:14];
    doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 85.0f, 50.0f)];
#if __IPHONE_3_0
    doneBtn.titleLabel.font = displayFont;
#else
    doneBtn.font = displayFont;
#endif
    [doneBtn setBackgroundImage:[[UIImage imageNamed:@"share-163dpi.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [doneBtn setCenter:CGPointMake(50.0f, 54.0f)];
    [doneBtn setTitle:@" Done" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
    [doneBtn setEnabled:YES];
}

-(void)loadAbout 
{
    LOG_CML;
    
    NSString *helpPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"Help"];
    NSURL *helpURL = [NSURL fileURLWithPath:helpPath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:helpURL]];
}

-(void)loadNetworkError
{
    LOG_CML;
    
    NSString *helpPath = [[NSBundle mainBundle] pathForResource:@"network" ofType:@"html" inDirectory:@"Help"];
    NSURL *helpURL = [NSURL fileURLWithPath:helpPath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:helpURL]];
}


@end
