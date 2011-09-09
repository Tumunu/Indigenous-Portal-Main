//
//  iPortalAppDelegate.m
//  iPortal
//
//  Created by Cleave Pokotea on 11/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SoundEngine.h"
#import "iPortalAppDelegate.h"
#import "RootNavViewController.h"


#define kListenerDistance 1.0  // Used for creating a realistic sound field
/* 
 * Static members related to sound effects and background music 
 */
static BOOL fxEnabled = YES;			// Sound effects are enabled
static UInt32 sounds[kNumEffects];		// References to the loaded sound effects


@implementation iPortalAppDelegate


@synthesize window;
@synthesize blankBaseView;
@synthesize blankBaseViewController;
@synthesize rootNavViewController;
@synthesize applicationActive;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
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
    // Old Symbian C++ habit
    if(blankBaseView) 
    {
        [blankBaseView release];
    }
    
	[window release];
	[super dealloc];
}

#pragma mark -
#pragma mark iPortal

- (void)setupApp 
{
    LOG_CML;
    
    [self setupViews];
    [self setupSound];
}

- (void)setupViews 
{
    LOG_CML;
    
    UIViewController *tempUIViewController = [[UIViewController alloc] init];
    self.blankBaseViewController = tempUIViewController;
    [tempUIViewController release];
    
    blankBaseView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    blankBaseViewController.view = blankBaseView;
    blankBaseView.backgroundColor = [UIColor clearColor];
    [window addSubview:blankBaseView];
    
    // The "seed" to impregnate
    feeds = [[PortalFeeds alloc] init];
    
    RootNavViewController *tempRootNavViewController = [[RootNavViewController alloc] initWithFeed:feeds];
    self.rootNavViewController = tempRootNavViewController;
    [tempRootNavViewController release];
    
    self.rootNavViewController.view.frame = [UIScreen mainScreen].applicationFrame;
    [self.blankBaseViewController presentModalViewController:self.rootNavViewController animated:YES];
    
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

