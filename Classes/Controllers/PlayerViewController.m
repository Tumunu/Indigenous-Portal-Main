//
//  iPhoneStreamingPlayerViewController.m
//  iPhoneStreamingPlayer
//
//  Created by Matt Gallagher on 28/10/08.
//  Copyright Matt Gallagher 2008. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "PlayerViewController.h"
#import "AudioStreamer.h"
#import <QuartzCore/CoreAnimation.h>
#import "iPortalAppDelegate.h"
#import "AudioViewController.h"

@implementation PlayerViewController

@synthesize avc;
@synthesize btn;
@synthesize shareBtn;
@synthesize background;

- (void)dealloc {
    if(avc) {
        [avc release];
    }
    if(btn) {
        [btn release];
    }
    if(shareBtn) {
        [shareBtn release];
    }    
    
    [super dealloc];
}

- (void)setButtonImage:(UIImage *)image
{
	[button.layer removeAllAnimations];
	[button
		setImage:image
		forState:0];
}

- (void)viewDidLoad
{
	UIImage *image = [UIImage imageNamed:@"playbutton.png"];
	[self setButtonImage:image];
    [self setBackgroundImage];
    [self setupController];
}

- (void)spinButton {
    
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	CGRect frame = [button frame];
	button.layer.anchorPoint = CGPointMake(0.5, 0.5);
	button.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
	[CATransaction commit];

	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
	[CATransaction setValue:[NSNumber numberWithFloat:2.0] forKey:kCATransactionAnimationDuration];

	CABasicAnimation *animation;
	animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
	animation.fromValue = [NSNumber numberWithFloat:0.0];
	animation.toValue = [NSNumber numberWithFloat:2 * M_PI];
	animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
	animation.delegate = self;
	[button.layer addAnimation:animation forKey:@"rotationAnimation"];

	[CATransaction commit];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)finished
{
	if (finished)
	{
		[self spinButton];
	}
}

- (IBAction)buttonPressed:(id)sender {
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    
	if (!streamer)
	{
		NSURL *url = [NSURL URLWithString:[iPortalAppDelegate get].cellURL];
		streamer = [[AudioStreamer alloc] initWithURL:url];
		[streamer
			addObserver:self
			forKeyPath:@"isPlaying"
			options:0
			context:nil];
		[streamer start];

		[self setButtonImage:[UIImage imageNamed:@"loadingbutton.png"]];

		[self spinButton];
	}
	else
	{
		[button.layer removeAllAnimations];
		[streamer stop];
	}
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
	change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqual:@"isPlaying"])
	{
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

		if ([(AudioStreamer *)object isPlaying])
		{
			[self
				performSelector:@selector(setButtonImage:)
				onThread:[NSThread mainThread]
				withObject:[UIImage imageNamed:@"stopbutton.png"]
				waitUntilDone:NO];
		}
		else
		{
			[streamer removeObserver:self forKeyPath:@"isPlaying"];
			[streamer release];
			streamer = nil;

			[self
				performSelector:@selector(setButtonImage:)
				onThread:[NSThread mainThread]
				withObject:[UIImage imageNamed:@"playbutton.png"]
				waitUntilDone:NO];
		}

		[pool release];
		return;
	}
	
	[super observeValueForKeyPath:keyPath ofObject:object change:change
		context:context];
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender
{
	[self buttonPressed:sender];
	return NO;
}
    
- (void)setupController {
    LOG_CML;

#if __IPHONE_3_0
    // UIViewController slips up under status bar. We need to reset it to where it should be placed
    self.view.frame = [[UIScreen mainScreen] applicationFrame];
#endif
    
    // Back to audio
    btn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 50.0f)];
    UIFont *displayFont = [UIFont fontWithName:@"Helvetica" size:14];
    
#if __IPHONE_3_0
    btn.titleLabel.font = displayFont;
#else
    btn.font = displayFont;
#endif
    
    [btn setBackgroundImage:[[UIImage imageNamed:@"back-163dpi.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [btn setCenter:CGPointMake(50.0f, 305.0f)];
    [btn setTitle:@"  Audio" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:48.0/255.0 green:50.0/255.0 blue:47.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn setEnabled:YES];
    
    // Share
    shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 85.0f, 50.0f)];

#if __IPHONE_3_0
    shareBtn.titleLabel.font = displayFont;
#else
    shareBtn.font = displayFont;
#endif
    [shareBtn setBackgroundImage:[[UIImage imageNamed:@"share-163dpi.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [shareBtn setCenter:CGPointMake(278.0f, 305.0f)];
    [shareBtn setTitle:@"Share" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(mail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    [shareBtn setEnabled:YES];
}
    
- (IBAction)done {
    LOG_CML;
    
    [iPortalAppDelegate playEffect:kEffectButton];
    [iPortalAppDelegate playEffect:kEffectPage];
    
    if (streamer) {
        [streamer stop];
    }
        
    AudioViewController *tavc = [[AudioViewController alloc] initWithNibName:@"AudioView" bundle:nil];
    self.avc = tavc;
    [tavc release];
    
    UIView *currentView = self.view;
    // get the the underlying UIWindow, or the view containing the current view view
    UIView *theWindow = [currentView superview];
    
    // remove the current view and replace with myView1
    [currentView removeFromSuperview];
    [theWindow addSubview:[avc view]];
    
    // set up an animation for the transition between the views
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.45];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [[theWindow layer] addAnimation:animation forKey:@"swap"];    
}

- (IBAction)mail {
    LOG_CML;
	
	NSString *subjString = @"Indigenous Portal | Something you might be interested in";
    NSString *msgString = [NSString stringWithFormat: @"Here's an item I thought you might be interested in\r\n\r\n %@", [iPortalAppDelegate get].cellURL];
    
	NSString *urlString = [NSString stringWithFormat: @"mailto:?subject=%@&body=%@", 
						   [subjString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
						   [msgString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
	LOG(@"subjString = %@", subjString);
	LOG(@"msgString = %@", msgString);
	LOG(@"urlString = %@", urlString);
    
	NSURL *mailURL = [NSURL URLWithString: urlString];
	[[UIApplication sharedApplication] openURL: mailURL];
}


- (void)setBackgroundImage {
	LOG_CML;
    
	UIImageView *customBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main-nav-163dpi.png"]];
	self.background = customBackground;
	[customBackground release];
	
	[self.view addSubview:background];
	LOG(@"Added background subview %@ to %@", background, self.view);
	[self.view sendSubviewToBack:background];
}

@end
