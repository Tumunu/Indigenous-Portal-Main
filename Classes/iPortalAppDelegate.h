//
//  iPortalAppDelegate.h
//  iPortal
//
//  Created by Cleave Pokotea on 11/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchXML.h"

// Yes this could just be a plain enum
typedef enum 
{
    kEffectButton=0,
    kEffectPage,
	kNumEffects
} Effect;


@class MainViewController;
@class HtmlViewController;
@class NavViewController;
@class CustomAlertViewController;

@interface iPortalAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    UIView * blankView;
    UIViewController * bvc;
    
    MainViewController * mainViewController;
    HtmlViewController * htmlViewController;
    NavViewController * navViewController;
    CustomAlertViewController * cavc;
        
    BOOL applicationActive;
    BOOL isDataSourceAvailable;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UIView * blankView;
@property (nonatomic, retain) UIViewController * bvc;

@property (nonatomic, retain) MainViewController * mainViewController;
@property (nonatomic, retain) HtmlViewController * htmlViewController;
@property (nonatomic, retain) NavViewController * navViewController;
@property (nonatomic, retain) CustomAlertViewController * cavc;

@property (readonly) BOOL applicationActive;

- (void)setupApp;
- (void)setupViews;
- (void)setupSound;

- (BOOL)checkIsDataSourceAvailable;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;


/* 
 * Sound effect methods
 */
+ (void)setEffectsEnabled:(BOOL)enabled;
+ (void)playEffect:(Effect)effect;
+ (BOOL)isEffectsEnabled;


@end

