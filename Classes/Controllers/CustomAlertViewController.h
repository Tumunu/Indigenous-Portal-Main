//
//  CustomAlertView.h
//  iPortal
//
//  Created by Cleave Pokotea on 17/05/09.
//  Copyright 2009 Make Things Talk. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomAlertViewController : UIViewController <UIWebViewDelegate> {
    
    IBOutlet UIWebView * webView;
    UIImageView * background;
}

@property (nonatomic, retain) IBOutlet UIWebView * webView;
@property (nonatomic, retain) UIImageView * background;

- (IBAction)closeAlert;

- (void)setupView;
- (void)setBackgroundImage;
- (void)loadNetworkError;

@end
