//
//  iPhoneStreamingPlayerViewController.h
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

#import <UIKit/UIKit.h>

@class AudioStreamer;
@class AudioViewController;

@interface PlayerViewController : UIViewController
{
	IBOutlet UITextField *textField;
	IBOutlet UIButton *button;
	AudioStreamer *streamer;
    
    IBOutlet UIButton *btn;
    UIButton * shareBtn;
    AudioViewController * avc;
    UIImageView *background;
}

@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) UIButton * shareBtn;
@property (nonatomic, retain) AudioViewController * avc;

- (IBAction)buttonPressed:(id)sender;
- (IBAction)done;
- (IBAction)mail;

- (void)setupController;
- (void)setBackgroundImage;

@end

