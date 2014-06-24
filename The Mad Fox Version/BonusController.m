//
//  BonusController.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/16/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "BonusController.h"
#import "MenuController.h"
#import "SocialHelper.h"
#import "Constants.h"
#import "AlertViewHelper.h"
#import "UserDefaultsUtils.h"
#import "Reachability.h"

@implementation BonusController
+(CCScene*) scene {
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BonusController *layer = [BonusController node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    // return the scene
	return scene;
}
-(id)init{
    if(self = [super init]){
        
        _view= [[BonusView alloc]initWithDelegate:self];
        [self addChild:_view];
        [[VungleSDK sharedSDK] setDelegate:self];
        
    }
    return self;
}
-(void)shareOnFacebook {
    NSLog(@"Share on facebook");
    [[SocialHelper sharedInstance]ShowFacebook:0 viewControoler:[CCDirector sharedDirector]];
}
-(void)shareOnTwitter {
    NSLog(@"Share on twitter");
    [[SocialHelper sharedInstance]ShowTwitter:0 viewControoler:[CCDirector sharedDirector]];
}
-(void)rateTheGame {
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        
        NSLog(@"There IS NO internet connection");
        [[AlertViewHelper sharedInstance]showAlertView:@"Uupps" title:@"I guess you don't have internet\nconnection please try again\nlater" cancelButton:@"Arrhhh" otherButton:nil view:_tempNode positionX:_xPosition positionY:_yPosition fontName:fontInTheGame fontSize:15 selector:nil zOrder:40];
        
    } else {
    
    NSLog(@"Rate the game");
    
    NSURL *url = [NSURL URLWithString:RATE_URL];
    [[UIApplication sharedApplication] openURL:url];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Thank You"
                              message:@"You successfully received 100 Bubbles"
                              delegate:self
                              cancelButtonTitle:@"Sweet"
                              otherButtonTitles:nil];
    [alertView show];
    [[UserDefaultsUtils sharedInstance]setBonusApproved:YES BonusNumber:4];
    [[CCDirector sharedDirector]replaceScene:[BonusController scene]];
    [[UserDefaultsUtils sharedInstance]addMoney:100];
        
    }
}
-(void)likeUsOnFacebook {
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        
        NSLog(@"There IS NO internet connection");
        [[AlertViewHelper sharedInstance]showAlertView:@"Uupps" title:@"I guess you don't have internet\nconnection please try again\nlater" cancelButton:@"Arrhhh" otherButton:nil view:_tempNode positionX:_xPosition positionY:_yPosition fontName:fontInTheGame fontSize:15 selector:nil zOrder:40];
        
    } else {
        
        NSLog(@"Like Us On Facebook");
        NSURL *url = [NSURL URLWithString:@"https://www.facebook.com/pages/Creative-Solutions/652128538177656"];
        [[UIApplication sharedApplication] openURL:url];
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Thank You"
                                  message:@"You successfully received 100 Bubbles"
                                  delegate:self
                                  cancelButtonTitle:@"Sweet"
                                  otherButtonTitles:nil];
        [alertView show];
        [[UserDefaultsUtils sharedInstance]setBonusApproved:YES BonusNumber:2];
        [[CCDirector sharedDirector]replaceScene:[BonusController scene]];
        [[UserDefaultsUtils sharedInstance]addMoney:100];
    }
}
-(void)back {
    NSLog(@"Menu");
    [[VungleSDK sharedSDK] setDelegate:nil];
    [[CCDirector sharedDirector] replaceScene:[MenuController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];

}
#pragma mark Load Video Ad
-(void)showVideo {
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        
        NSLog(@"There IS NO internet connection");
        [[AlertViewHelper sharedInstance]showAlertView:@"Uupps" title:@"I guess you don't have internet\nconnection please try again\nlater" cancelButton:@"Arrhhh" otherButton:nil view:_tempNode positionX:_xPosition positionY:_yPosition fontName:fontInTheGame fontSize:15 selector:nil zOrder:40];
        
    } else {
        
        VungleSDK* sdk = [VungleSDK sharedSDK];
        [sdk setIncentivizedAlertText:@"Done"];
        
        NSDictionary* options = @{@"orientations": @(UIInterfaceOrientationMaskLandscape),
                                  @"incentivized": @(YES),
                                  @"userInfo": @{@"user": @""},
                                  @"showClose": @(NO)};
        
        [sdk playAd:[CCDirector sharedDirector] withOptions:options];
    }
}
#pragma mark VUNGLE - VIDEO - ADS
/**
 * if implemented, this will get called when the SDK is about to show an ad. This point
 * might be a good time to pause your game, and turn off any sound you might be playing.
 */
- (void)vungleSDKwillShowAd {
}
/**
 * if implemented, this will get called when the SDK closes the ad view, but there might be
 * a product sheet that will be presented. This point might be a good place to resume your game
 * if there's no product sheet being presented. If the product sheet will be shown, we recommend
 * waiting for it to close before you resume, show a reward confirmation to the user, etc. The
 * viewInfo dictionary will contain the following keys:
 * - "completedView": NSNumber representing a BOOL whether or not the video can be considered a
 *                full view.
 * - "playTime": NSNumber representing the time in seconds that the user watched the video.
 * - "didDownlaod": NSNumber representing a BOOL whether or not the user clicked the download
 *                  button.
 */
- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary*)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet {
    NSLog(@"You successfuly received 2 Hints");
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    long timeSinceFirstRun2 = [[NSUserDefaults standardUserDefaults]integerForKey:@"videoTime"];
    long videoSinceLastHit = currentTime / 60  - timeSinceFirstRun2 / 60;
    [[NSUserDefaults standardUserDefaults]setInteger:videoSinceLastHit forKey:@"videoLeft"];

    long currentTimee = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    [[NSUserDefaults standardUserDefaults]setInteger:currentTimee forKey:@"videoTime"];
    
    [[UserDefaultsUtils sharedInstance] setBonusApproved:YES BonusNumber:5];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"videoAd"];
    [[AlertViewHelper sharedInstance]showAlertView:@"You successfuly added 100 Bubbles" title:@"Congrats" cancelButton:@"OK" otherButton:nil view:_tempNode positionX:_xPosition positionY:_yPosition fontName:fontInTheGame fontSize:19 selector:nil zOrder:40];
    [[UserDefaultsUtils sharedInstance]addMoney:100];
    

}
/**
 * if implemented, this will get called when the product sheet is about to be closed.
 */
- (void)vungleSDKwillCloseProductSheet:(id)productSheet {
    
}
-(void)getDimensions: (CCNode*)node_ xPosition_:(int)xPosition_ yPosition_:(int)yPosition_ {
    
    _tempNode = node_;
    _xPosition = xPosition_;
    _yPosition = yPosition_;
    
}
@end
