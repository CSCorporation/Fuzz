//
//  IntroScene.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright Viktor Todorov 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "MenuView.h"
#import "LevelController.h"
#import "OptionsController.h"
#import "Constants.h"
#import "UserDefaultsUtils.h"
#import "AlertViewHelper.h"
#import "UserDefaultsUtils.h"
#import "cocos2d.h"
#import "CCSprite.h"
#import "CCAnimation.h"

@implementation MenuView
@synthesize delegate = _delegate;

-(id)initWithDelegate:(id<MenuDelegate>) delegateArg {
    
    if(self = [super init]){
        [self setDelegate:delegateArg];
        
#pragma mark Enable Touches
        self.contentSize = [[CCDirector sharedDirector] viewSize];
        [self setUserInteractionEnabled:YES];
        
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        
        [self checkTime];
        
        CCSprite* background = [CCSprite spriteWithImageNamed:MenuBackground];
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        
        [[UserDefaultsUtils sharedInstance]setAchievementPassed:YES AchievementNumber:1];
#pragma mark -
#pragma mark Background Animation
 /*       CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if (screenSize.height > 480.0f) {
  
                [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background0.plist"];
                [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background1.plist"];

            } else {
                
                [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background0.plist"];
            }
        } else {
            
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background0.plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background1.plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background2.plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background3.plist"];
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"background4.plist"];
        }
  
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for (int i=2; i < 90; i++) {
            if(i < 10) {
                NSLog(@"test frames000%d.jpeg",i);
                [walkAnimFrames addObject:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                  [NSString stringWithFormat:@"test frames000%d.jpeg",i]]];
            }
            else {
                
                [walkAnimFrames addObject:
                 [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                  [NSString stringWithFormat:@"test frames00%d.jpeg",i]]];

            }
        }
        CCAnimation *running = [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.1f];
        
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        CCSprite* bear = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"test frames0002.jpeg"]];
        bear.position = ccp(winSize.width/2, winSize.height/2);
        CCActionRepeatForever *walkAction = [CCActionRepeatForever actionWithAction:
                           [CCActionAnimate actionWithAnimation:running]];
        [bear runAction:walkAction];
        [self addChild:bear];*/
#pragma mark -

        CCButton *levels = [CCButton buttonWithTitle:PlayTitleName fontName:fontInTheGame fontSize:90];
        [levels setTarget:self selector:@selector(openLevels)];
        levels.position = ccp(viewSize.width / 5-100, viewSize.height / 2.2);
        levels.color = [CCColor blackColor];
        levels.rotation = 10;
        [self addChild:levels];
        
        CCButton *options = [CCButton buttonWithTitle:OptionsTitleName fontName:fontInTheGame fontSize:OptionsFontSize];
        [options setTarget:self selector:@selector(openOptions)];
        options.position = ccp(viewSize.width / 2, viewSize.height / 2.2);
        options.rotation = 20;
        options.color = [CCColor blackColor];
        [self addChild:options];
        
        CCButton *shop = [CCButton buttonWithTitle:ShopTitleName fontName:fontInTheGame fontSize:ShopFontSize];
        [shop setTarget:self selector:@selector(openShop)];
        shop.position = ccp(viewSize.width / 5, viewSize.height / 5);
        shop.rotation = -45;
        shop.color = [CCColor blackColor];
        [self addChild:shop];
        
        CCButton *bonus = [CCButton buttonWithTitle:BonusTitleName fontName:fontInTheGame fontSize:BonusFontSize];
        [bonus setTarget:self selector:@selector(openBonus)];
        bonus.position = ccp(viewSize.width / 2.6, viewSize.height / 1.5);
        bonus.rotation = 20;
        bonus.color = [CCColor blackColor];
        [self addChild:bonus];
        
        CCButton *achievements = [CCButton buttonWithTitle:AchievementsTitleName fontName:fontInTheGame fontSize:AchievementsFontSize];
        [achievements setTarget:self selector:@selector(openAchievements)];
        achievements.position = ccp(viewSize.width / 1.2+20, viewSize.height / 1.5+10);
        achievements.rotation = 50;
        achievements.color = [CCColor blackColor];
        [self addChild:achievements];
        
    }
	return self;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {

}
-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
//    NSArray* allTouches = [[event allTouches] allObjects];
//    CCNode *gameField = self;
//    if (allTouches.count == 2) {
//        
//        UIView *v = [[CCDirector sharedDirector] view];
//        UITouch *tOne = [allTouches objectAtIndex:0];
//        UITouch *tTwo = [allTouches objectAtIndex:1];
//        CGPoint firstTouch = [tOne locationInView:v];
//        CGPoint secondTouch = [tTwo locationInView:v];
//        CGPoint oldFirstTouch = [tOne previousLocationInView:v];
//        CGPoint oldSecondTouch = [tTwo previousLocationInView:v];
//        float oldPinchDistance = ccpDistance(oldFirstTouch, oldSecondTouch);
//        float newPinchDistance = ccpDistance(firstTouch, secondTouch);
//        
//        float distanceDelta = newPinchDistance - oldPinchDistance;
//        NSLog(@"%f", distanceDelta);
//        CGPoint pinchCenter = ccpMidpoint(firstTouch, secondTouch);
//        pinchCenter = [self convertToNodeSpace:pinchCenter];
//        
//        gameField.scale = gameField.scale + distanceDelta / 100;
//        NSLog(@"Scale: %f",self.scale);
//        if(self.scale > 1.6) {
//            gameField.scale = 1.6;
//        }
//        if (self.scale < 1) {
//            
//            self.scale = 1;
//        }
//    }
//    if(allTouches.count == 1) {
//        NSLog(@"MOving");
//    }
}
-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
}
- (void)openLevels {
    [_delegate goToChapters];
}
- (void)openOptions {
    [_delegate goToOptions];
}
-(void)openShop {
    [_delegate goToShop];
}
-(void)openBonus {
    [_delegate goToBonus];
}
-(void)openAchievements {
    [_delegate goToAchievements];
}
-(void)checkTime {
    
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    long timeSinceFirstRun = [[NSUserDefaults standardUserDefaults]integerForKey:@"dateTime"];
    long timeSinceFirstRun2 = [[NSUserDefaults standardUserDefaults]integerForKey:@"videoTime"];
    long minutesSinceInstalling = currentTime / 60  - timeSinceFirstRun / 60;
    long videoSinceLastHit = currentTime / 60  - timeSinceFirstRun2 / 60;
    [[NSUserDefaults standardUserDefaults]setInteger:videoSinceLastHit forKey:@"videoLeft"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:minutesSinceInstalling forKey:@"shareLeft"];
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
        
        [[AlertViewHelper sharedInstance]showAlertView:@"Share on Facebook and Twitter is\n active again. Share to receive\nBubbles" title:@"Share Bonus" cancelButton:@"Awesome" otherButton:nil view:self positionX:viewSize.width/2 positionY:viewSize.height/2 fontName:fontInTheGame fontSize:17 selector:nil zOrder:15];
        isAlertVisible = YES;
    }
    NSLog(@"Time Since Installing: %li", minutesSinceInstalling);
    if(videoSinceLastHit > getVideoTime) {
        long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
        [[NSUserDefaults standardUserDefaults]setInteger:currentTime forKey:@"videoTime"];
        [ud setBonusApproved:NO BonusNumber:5];
        
        if(isAlertVisible == NO) {
            [[AlertViewHelper sharedInstance]showAlertView:@"Video bonus is active. Watch to\nreceive bubbles!" title:@"Video Bonus" cancelButton:@"Okay" otherButton:nil view:self positionX:viewSize.width/2 positionY:viewSize.height/2 fontName:fontInTheGame fontSize:17 selector:nil zOrder:15];
        }
    }
}
@end
