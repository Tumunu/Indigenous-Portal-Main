//
//  AboutViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 9/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//
#import <UIKit/UIKit.h>

//@class HelpView

@protocol AboutViewControllerDelegate;
@interface AboutViewController : UIViewController <UIWebViewDelegate> 
{
    IBOutlet UIWebView *webView;
	id <AboutViewControllerDelegate> delegate;
    UIImageView *background;
    UIButton * doneBtn;
    UIButton * shareBtn;
}

@property (nonatomic, assign) id <AboutViewControllerDelegate> delegate;
@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIButton * doneBtn;
@property (nonatomic, retain) UIButton * shareBtn;

- (IBAction)done;
- (IBAction)mail;

- (void)setupController;
- (void)loadAbout;
- (void)loadNetworkError;

@end


@protocol AboutViewControllerDelegate
- (void)aboutViewControllerDidFinish:(AboutViewController *)controller;
@end

