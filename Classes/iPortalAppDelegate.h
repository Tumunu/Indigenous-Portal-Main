//
//  iPortalAppDelegate.h
//  iPortal
//
//  Created by Cleave Pokotea on 11/05/09.
//  Copyright Tumunu 2009 - 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchXML.h"
#import "PortalFeeds.h"

// Yes this could just be a plain enum
typedef enum 
{
    kEffectButton=0,
    kEffectPage,
	kNumEffects
} Effect;

@class RootNavViewController;

@interface iPortalAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
    UIView *blankBaseView;
    UIViewController *blankBaseViewController;
    
    RootNavViewController *rootNavViewController;
    PortalFeeds *feeds;
        
    BOOL applicationActive;
    BOOL isDataSourceAvailable;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UIView *blankBaseView;
@property (nonatomic, retain) UIViewController *blankBaseViewController;
@property (nonatomic, retain) RootNavViewController *rootNavViewController;
@property (nonatomic, retain) PortalFeeds *feeds;
@property (readonly) BOOL applicationActive;

-(void)setupApp;
-(void)setupViews;
-(void)setupSound;

/* 
 * Sound effect methods
 */
+ (void)setEffectsEnabled:(BOOL)enabled;
+ (void)playEffect:(Effect)effect;
+ (BOOL)isEffectsEnabled;


@end

