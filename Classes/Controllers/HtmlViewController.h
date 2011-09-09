//
//  WebViewController.h
//  iPortal
//
//  Created by Cleave Pokotea on 12/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class VideoViewController;
@class CustomAlertViewController;

@interface HtmlViewController : UIViewController <UIWebViewDelegate> {
    
    UIImageView * background;
    MainViewController * mvc;
    VideoViewController * vvc;
    CustomAlertViewController * cavc;
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *btn;
    UIButton * shareBtn;
    BOOL shouldYouLoadIndicator;
}

@property (nonatomic, retain) UIImageView *background;
@property (nonatomic, retain) MainViewController * mvc;
@property (nonatomic, retain) VideoViewController * vvc;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) UIButton * shareBtn;
@property (nonatomic, retain) CustomAlertViewController * cavc;

- (IBAction)done;
- (IBAction)mail;

- (void)setupView;
- (void)loadHtml;
- (void)setShouldYouLoadIndicator:(BOOL)what;
- (void)setBackgroundImage;

@end

