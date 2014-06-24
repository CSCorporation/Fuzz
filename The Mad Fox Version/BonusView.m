//
//  BonusView.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/16/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "BonusView.h"
#import "Constants.h"
#import "UserDefaultsUtils.h"
#import <VungleSDK/VungleSDK.h>
#import "AlertViewHelper.h"
@implementation BonusView
@synthesize delegate = _delegate;
-(id)initWithDelegate:(id<BonusDelegate>)delegateArg{
    if(self = [super init]){
        
        [self setDelegate:delegateArg];
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        
        //Get dimensions and node and pass it to the controller for the alertView;
        [_delegate getDimensions:self xPosition_:viewSize.width / 2 yPosition_:viewSize.height / 2];
        
        [self checkTime];
        
        CCSprite* background = [CCSprite spriteWithImageNamed:BonusBackground];
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        
        _title = [CCLabelTTF labelWithString:@"Bonuses" fontName:fontInTheGame fontSize:40];
        _title.position = ccp(viewSize.width / 2, viewSize.height / 2+(IS_IPAD?350:130));
        [self addChild:_title];
        
        _back = [CCButton buttonWithTitle:BackButtonTitle fontName:fontInTheGame fontSize:BackButtonFontSize];
        [_back setTarget:self selector:@selector(back)];
        _back.position = ccp(viewSize.width / 2, viewSize.height / 6 - (IS_IPAD?70:0));
        [self addChild:_back];
        
        _facebook = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:facebookBonus]];
        [_facebook setTarget:self selector:@selector(facebook)];
        _facebook.position = ccp(viewSize.width / 1.3, viewSize.height / 1.5);
        [self addChild:_facebook];
        
        _twitter = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:twitterBonus]];
        [_twitter setTarget:self selector:@selector(twitter)];
        _twitter.position = ccp(viewSize.width / 4.3, viewSize.height / 1.5);
        [self addChild:_twitter];
        
        _rate = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:rateUsBonus]];
        [_rate setTarget:self selector:@selector(rate)];
        _rate.position = ccp(viewSize.width / 1.5, viewSize.height / 2.5);
        [self addChild:_rate];
        
        _like = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:likeUsBonus]];
        [_like setTarget:self selector:@selector(like)];
        _like.position = ccp(viewSize.width / 3.0, viewSize.height / 2.5);
        [self addChild:_like];
        
        _video = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:likeUsBonus]];
        [_video setTarget:self selector:@selector(runVideo)];
        _video.position = ccp(viewSize.width / 2, viewSize.height / 1.5);
        [self addChild:_video];

        CCLabelTTF* twitterLabel = [CCLabelTTF labelWithString:@"Share to get 150 Bubbles\nreset every 5 days" fontName:fontInTheGame fontSize:20];
        twitterLabel.fontColor = [CCColor whiteColor];
        twitterLabel.position = ccp(_twitter.boundingBox.size.width / 2, _twitter.boundingBox.size.height / 6 - 50);
        [twitterLabel setHorizontalAlignment:CCTextAlignmentCenter];
        [_twitter addChild:twitterLabel];
        
        CCLabelTTF* facebookLabel = [CCLabelTTF labelWithString:@"Share to get 150 Bubbles\nreset every 5 days" fontName:fontInTheGame fontSize:20];
        facebookLabel.fontColor = [CCColor whiteColor];
        facebookLabel.position = ccp(_facebook.boundingBox.size.width / 2, _facebook.boundingBox.size.height / 6 - 50);
        [facebookLabel setHorizontalAlignment:CCTextAlignmentCenter];
        [_facebook addChild:facebookLabel];
        
        CCLabelTTF* faceLikeLabel = [CCLabelTTF labelWithString:@"Like Us to get 100 Bubbles" fontName:fontInTheGame fontSize:20];
        faceLikeLabel.fontColor = [CCColor whiteColor];
        faceLikeLabel.position = ccp(_like.boundingBox.size.width / 2, _like.boundingBox.size.height / 6 - 50);
        [faceLikeLabel setHorizontalAlignment:CCTextAlignmentCenter];
        [_like addChild:faceLikeLabel];
        
        CCLabelTTF* rateLabel = [CCLabelTTF labelWithString:@"Rate to get 100 Bubbles" fontName:fontInTheGame fontSize:20];
        rateLabel.fontColor = [CCColor whiteColor];
        rateLabel.position = ccp(_rate.boundingBox.size.width / 2, _rate.boundingBox.size.height / 6 - 50);
        [rateLabel setHorizontalAlignment:CCTextAlignmentCenter];
        [_rate addChild:rateLabel];
        
        CCLabelTTF* videoLabel = [CCLabelTTF labelWithString:@"Watch Video to get\n 100 Bubbles reset every\n 1 hour" fontName:fontInTheGame fontSize:20];
        videoLabel.fontColor = [CCColor whiteColor];
        videoLabel.position = ccp(_video.boundingBox.size.width / 2, _video.boundingBox.size.height / 6 - 60);
        [videoLabel setHorizontalAlignment:CCTextAlignmentCenter];
        [_video addChild:videoLabel];
        
        
        NSLog(@"Reload: %i",getVideoTime);
        NSLog(@"Reload: %li",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"videoLeft"]);
        long a = getVideoTime - (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"videoLeft"];
        NSString* temp = [NSString stringWithFormat:@"Active After: %li mins", a];
        CCLabelTTF* videoLeft = [CCLabelTTF labelWithString:temp fontName:fontInTheGame fontSize:17];
        videoLeft.fontColor = [CCColor whiteColor];
        videoLeft.position = ccp(_video.boundingBox.size.width / 2, _video.boundingBox.size.height / 1.3 + 30);
        [videoLeft setHorizontalAlignment:CCTextAlignmentCenter];
        
        UserDefaultsUtils* ud = [UserDefaultsUtils sharedInstance];
        BOOL isBonus5Passed = [ud getBonus:5];
        if(isBonus5Passed == YES) {
            [_video addChild:videoLeft];
        }
        
        
        
        long a2 = timeToReloadBonuses - (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"shareLeft"];
        NSString* temp2 = [NSString stringWithFormat:@"Active After: %li mins", a2];
        CCLabelTTF* shareLeft = [CCLabelTTF labelWithString:temp2 fontName:fontInTheGame fontSize:17];
        shareLeft.fontColor = [CCColor whiteColor];
        shareLeft.position = ccp(_facebook.boundingBox.size.width / 2, _facebook.boundingBox.size.height / 1.3 + 30);
        [shareLeft setHorizontalAlignment:CCTextAlignmentCenter];
        
        BOOL isBonus3Passed = [ud getBonus:3];
        if(isBonus3Passed == YES) {
            [_facebook addChild:shareLeft];
        }
        
        CCLabelTTF* twLeft = [CCLabelTTF labelWithString:temp2 fontName:fontInTheGame fontSize:17];
        twLeft.fontColor = [CCColor whiteColor];
        twLeft.position = ccp(_twitter.boundingBox.size.width / 2, _twitter.boundingBox.size.height / 1.3 + 30);
        [twLeft setHorizontalAlignment:CCTextAlignmentCenter];
    
        BOOL isBonus1Passed = [ud getBonus:1];
        if(isBonus1Passed == YES) {
            [_twitter addChild:twLeft];
        }
        
        [self checkBonuses];

    }
    return self;
}

-(void)facebook {
    [_delegate shareOnFacebook];
}
-(void)twitter {
    [_delegate shareOnTwitter];
}
-(void)back {
    [_delegate back];
}
-(void)like {
    [_delegate likeUsOnFacebook];
}
-(void)rate {
    [_delegate rateTheGame];
}
-(void)runVideo {
    [_delegate showVideo];
}
-(void)checkBonuses {
    
    UserDefaultsUtils* ud = [UserDefaultsUtils sharedInstance];
    
    BOOL isBonus1Passed = [ud getBonus:1];
    BOOL isBonus2Passed = [ud getBonus:2];
    BOOL isBonus3Passed = [ud getBonus:3];
    BOOL isBonus4Passed = [ud getBonus:4];
    BOOL isBonus5Passed = [ud getBonus:5];
    
    if(isBonus1Passed) {
        _twitter.opacity = 0.4;
        _twitter.enabled = NO;
    }
    if(isBonus2Passed) {
        _like.opacity = 0.4;
        _like.enabled = NO;
    }
    if(isBonus3Passed) {
        _facebook.opacity = 0.4;
        _facebook.enabled = NO;
    }
    if(isBonus4Passed) {
        _rate.opacity = 0.4;
        _rate.enabled = NO;
    }
    if(isBonus5Passed) {
        _video.opacity = 0.4;
        _video.enabled = NO;
    }
}
-(void)checkTime {
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    long timeSinceFirstRun = [[NSUserDefaults standardUserDefaults]integerForKey:@"dateTime"];
    long timeSinceFirstRun2 = [[NSUserDefaults standardUserDefaults]integerForKey:@"videoTime"];
    long minutesSinceInstalling = currentTime / 60  - timeSinceFirstRun / 60;
    long videoSinceLastHit = currentTime / 60  - timeSinceFirstRun2 / 60;
    UserDefaultsUtils* ud = [UserDefaultsUtils sharedInstance];
    BOOL isAlertVisible = NO;
    
    //Check minutes since install and reset the bonuses after 5 days
    if(minutesSinceInstalling > timeToReloadBonuses) {
        
        long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
        [[NSUserDefaults standardUserDefaults]setInteger:currentTime forKey:@"dateTime"];
        
        [ud setBonusApproved:NO BonusNumber:1];
        [ud setBonusApproved:NO BonusNumber:2];//remove from here
        [ud setBonusApproved:NO BonusNumber:3];
        [ud setBonusApproved:NO BonusNumber:4];//remove from here
        
        [[AlertViewHelper sharedInstance]showAlertView:@"Your bonuses have been reset\n you can share the game again\nand receive hints points!" title:@"Share Bonus" cancelButton:@"Awesome" otherButton:nil view:self positionX:viewSize.width/2 positionY:viewSize.height/2 fontName:fontInTheGame fontSize:17 selector:nil zOrder:15];
        isAlertVisible = YES;
    }
    NSLog(@"Time Since Installing: %li", minutesSinceInstalling);
    if(videoSinceLastHit > getVideoTime) {
        long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
        [[NSUserDefaults standardUserDefaults]setInteger:currentTime forKey:@"videoTime"];
        [ud setBonusApproved:NO BonusNumber:5];
        
        if(isAlertVisible == NO) {
            [[AlertViewHelper sharedInstance]showAlertView:@"You can watch video\nand receive hint points!" title:@"Video Bonus" cancelButton:@"Okay" otherButton:nil view:self positionX:viewSize.width/2 positionY:viewSize.height/2 fontName:fontInTheGame fontSize:17 selector:nil zOrder:15];
        }
    }
}
@end
