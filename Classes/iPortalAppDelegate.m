//
//  iPortalAppDelegate.m
//  iPortal
//
//  Created by Cleave Pokotea on 11/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//
#import <SystemConfiguration/SystemConfiguration.h>
#import "iPortalAppDelegate.h"
#import "MainViewController.h"
#import "HtmlViewController.h"
#import "NavViewController.h"
#import "CustomAlertViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SoundEngine.h"


#define kListenerDistance 1.0  // Used for creating a realistic sound field
/* 
 * Static members related to sound effects and background music 
 */
static BOOL fxEnabled = YES;			// Sound effects are enabled
static UInt32 sounds[kNumEffects];		// References to the loaded sound effects


@implementation iPortalAppDelegate

@synthesize window;
@synthesize blankView;
@synthesize bvc;

@synthesize mainViewController;
@synthesize htmlViewController;
@synthesize navViewController;
@synthesize cavc;

@synthesize applicationActive;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
    // TODO: Move to a root view controller
    [self setupApp];
}

- (void)applicationWillTerminate:(UIApplication *)application 
{}

- (void)applicationWillResignActive:(UIApplication *)application 
{
	applicationActive = FALSE;
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{    
	applicationActive = TRUE;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc 
{
    [mainViewController release];
    [htmlViewController release];
    
    // Old Symbian C++ habit
    if(cavc) 
    {
        [cavc release];
    }
    if(blankView) 
    {
        [blankView release];
    }
    
	[window release];
	[super dealloc];
}

#pragma mark -
#pragma mark iPortal

- (void)setupApp 
{
    LOG_CML;
    
    [self setupSound];
    [self setupViews];
}

- (void)setupViews 
{
    LOG_CML;

    UIViewController * tbvc = [[UIViewController alloc] init];
    self.bvc = tbvc;
    [tbvc release];
    
    blankView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    bvc.view = blankView;
    blankView.backgroundColor = [UIColor clearColor];
    [window addSubview:blankView];
    
    NavViewController * nvc = [[NavViewController alloc] initWithNibName:@"NavView" bundle:nil];
    self.navViewController = nvc;
    [nvc release];
    
    self.navViewController.view.frame = [UIScreen mainScreen].applicationFrame;
    [self.bvc presentModalViewController:self.navViewController animated:YES];
    
    if(![self checkIsDataSourceAvailable]) 
    {
        CustomAlertViewController * tcavc = [[CustomAlertViewController alloc] initWithNibName:@"CustomAlertView" bundle:nil];
        self.cavc = tcavc;
        [tcavc release];
        
        // Use “bounds” instead of “applicationFrame” — the latter will introduce 
        // a 20 pixel empty status bar (unless you want that..)
        self.cavc.view.frame = [UIScreen mainScreen].applicationFrame;
        self.cavc.view.alpha = 0.0;
        [window addSubview:[cavc view]];
        
        // Don't yell at me about not using NULL.  They're the same, it's just convention 
        // to use one for pointers and the other one for everything else.
        [UIView beginAnimations:nil context:nil];    
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.33];  //.25 looks nice as well.
        self.cavc.view.alpha = 1.0;
        [UIView commitAnimations];
    }

    [window makeKeyAndVisible];
    applicationActive = TRUE;
}

- (void)setupSound 
{
    LOG_CML;
    
    NSBundle* bundle = [NSBundle mainBundle];
    
    /*
	 * Initialize the audio engine
	 *
	 * Pilfered from the Apple Crash Landing example
	 */
	SoundEngine_Initialize(44100);									// Set the bitrate
	SoundEngine_SetListenerPosition(0.0, 0.0, kListenerDistance);	// Set the listener position
    SoundEngine_LoadEffect([[bundle pathForResource:@"button" ofType:@"caf"] UTF8String], &sounds[kEffectButton]);   
    SoundEngine_LoadEffect([[bundle pathForResource:@"instructions_trans" ofType:@"caf"] UTF8String], &sounds[kEffectPage]);   
}

- (BOOL)checkIsDataSourceAvailable 
{
    LOG_CML;
    
    static BOOL checkNetwork = YES;
    if (checkNetwork) 
    {
        
        checkNetwork = NO;
        
        Boolean success;    
        const char *host_name = "tumunu.com";
        
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        SCNetworkReachabilityFlags flags;
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        isDataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
        CFRelease(reachability);
    }
    
    return isDataSourceAvailable;
}

- (NSString *)springClean:(NSString *)sourceString 
{
    char charCode[28];
    int i;
    for(i=0x00;i<=0x08;i++) 
    {
        charCode[i]=i;
    }
    
    charCode[9]=0x0B;
    for(i=0x0E;i<=0x1F;i++) 
    {
        charCode[i]=i;
    }
    
    NSScanner *sourceScanner = [NSScanner scannerWithString:sourceString];
    NSMutableString *cleanedString = [[[NSMutableString alloc] init] autorelease];
    
    // create an array of chars for all control characters between 0×00 and 0×1F, apart from \t, \n, \f and \r (which are at code points 0×09, 0×0A, 0×0C and 0×0D respectively)
    
    // convert this array into an NSCharacterSet
    NSString *controlCharString = [NSString stringWithCString:charCode length:28];
    NSCharacterSet *controlCharSet = [NSCharacterSet characterSetWithCharactersInString:controlCharString];
    
    // request that the scanner ignores these characters
    [sourceScanner setCharactersToBeSkipped:controlCharSet];
    
    // run through the string to remove control characters
    while ([sourceScanner isAtEnd] == NO) 
    {
        NSString *outString;
        if ([sourceScanner scanUpToCharactersFromSet:controlCharSet intoString:&outString])
        {
            [cleanedString appendString:outString];
        }
    }
    
    return cleanedString;
}

/*
 * The methods are all related to music and sound effects.  If you aren't going
 * to use any, you can safely remove these
 */
+ (void)setEffectsEnabled:(BOOL)enabled 
{
	fxEnabled = enabled;
}

+ (BOOL)isEffectsEnabled 
{
	return fxEnabled;
}

+ (void)playEffect:(Effect)effect
{
	if(!fxEnabled) return;
	SoundEngine_StartEffect(sounds[effect]);
}


@end

