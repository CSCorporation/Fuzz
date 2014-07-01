//
//  HelloWorldScene.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright Viktor Todorov 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "LevelView.h"
#import "MenuView.h"
#import "Constants.h"
#import "UserDefaultsUtils.h"
#import "AlertViewHelper.h"
#import "LineView.h"

@implementation LevelView
@synthesize delegate = _delegate;



// -----------------------------------------------------------------------

-(id)initWithDelegate:(id<LevelDelegate>) delegateArg {
    
    if(self = [super init]){
        [self setDelegate:delegateArg];
        
        CCSprite* background = [CCSprite spriteWithImageNamed:LevelBackground];
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Levels" fontName:fontInTheGame fontSize:40];
        title.position = ccp(viewSize.width / 2, viewSize.height / 2+(IS_IPAD?350:130));
        [self addChild:title];
        
        CCLabelTTF *starsCounter = [CCLabelTTF labelWithString:@"Stars:" fontName:fontInTheGame fontSize:40];
        starsCounter.position = ccp(viewSize.width / 2, viewSize.height / 2+(IS_IPAD?310:100));
        [self addChild:starsCounter];
        NSString* tempString = [NSString stringWithFormat:@"Stars: %li", [[UserDefaultsUtils sharedInstance]getStars]];
        starsCounter.string = tempString;
        
        CCButton *backButton = [CCButton buttonWithTitle:BackButtonTitle fontName:fontInTheGame fontSize:BackButtonFontSize];
        [backButton setTarget:self selector:@selector(goBack)];
        backButton.position = ccp(viewSize.width / 2, viewSize.height / 5);
        [self addChild:backButton];
        
        int xPosition = IS_IPAD?90:75;
        int yPosition = IS_IPAD?600:250;
        
        int xPositionRow2 = IS_IPAD?910:75;
        int xPositionRow3 = IS_IPAD?90:75;
        
        NSMutableArray* buttonArray = [NSMutableArray new];
        // Enable touch handling on scene node
        for (int i = 1; i <= 20; i++) {
            
            NSString *number = [NSString stringWithFormat:@"%i",i];
            CCButton *spinningButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:LevelButtonSprite] highlightedSpriteFrame:nil disabledSpriteFrame:nil];
            CCLabelTTF *spinningLabel = [CCLabelTTF labelWithString:number fontName:fontInTheGame fontSize:37];
            spinningLabel.position = ccp(spinningButton.contentSize.width / 2, spinningButton.contentSize.height / 2);
            [spinningButton addChild:spinningLabel];
            spinningLabel.visible = YES;
            [buttonArray addObject:spinningButton];
            
            int random = arc4random() % (IS_IPAD?50:25);
            NSLog(@"Random: %i",random);
            int randomSign = arc4random() % 2;
            
            if(i > 7 && i < 15) {
                if(randomSign == 0) {
                    spinningButton.position = ccp(xPositionRow2, yPosition - (IS_IPAD?180:70) + random);
                }
                else {
                    spinningButton.position = ccp(xPositionRow2, yPosition - (IS_IPAD?180:70) - random);
                }
                xPositionRow2 -= IS_IPAD?140:70;
                
            }
            else if(i > 14) {
                
                if(randomSign == 0) {
                    spinningButton.position = ccp(xPositionRow3, yPosition - (IS_IPAD?360:140) + random);
                }
                else {
                    spinningButton.position = ccp(xPositionRow3, yPosition - (IS_IPAD?360:140) - random);
                }
                xPositionRow3 += IS_IPAD?140:70;
                
            }
            else {
                
                if(randomSign == 0) {
                    spinningButton.position = ccp(xPosition, yPosition + random);
                }
                else {
                    spinningButton.position = ccp(xPosition, yPosition - random);
                }
                xPosition += IS_IPAD?140:70;
                
            }
            [spinningButton setScaleX:IS_IPAD?1.2:0.5];
            [spinningButton setScaleY:IS_IPAD?1.2:0.5];
            [spinningButton setBlock:^(id sender) {
    
/* 
                           ||
                           ||
 Set The Stars Limit HERE \\//
                           \/
 
*/
                if(i == 5) {
                    if([[UserDefaultsUtils sharedInstance]getStars] < 10) {
                        [[AlertViewHelper sharedInstance]showAlertView:@"You need at least 10 stars to\n play this level" title:@"Uupss" cancelButton:@"OK" otherButton:nil view:self positionX:viewSize.width / 2 positionY:viewSize.height/2 fontName:fontInTheGame fontSize:15 selector:nil zOrder:10];
                    }
                    else {
                        int levelNumber = [spinningLabel.string intValue];
                        [_delegate levelSelect:levelNumber];
                    }
                }
                else {
                    int levelNumber = [spinningLabel.string intValue];
                    [_delegate levelSelect:levelNumber];
                }
            }];
            
            //spinningButton.title = [NSString stringWithFormat:@"%i",i];
            
            [self addChild:spinningButton z:1];
            
            NSString* key = [NSString stringWithFormat:@"Dictionary-%i",i];
            if([[[[_delegate loadFromPlist] objectForKey:key] objectForKey:@"Stars"] intValue] == 1) {
                CCSprite* tempStar = [CCSprite spriteWithImageNamed:LevelStar];
                tempStar.position = ccp(spinningButton.contentSize.width / 2, spinningButton.contentSize.height / 1.5);
                [spinningButton addChild:tempStar];
                spinningLabel.visible = NO;
                
            }
            else if([[[[_delegate loadFromPlist] objectForKey:key] objectForKey:@"Stars"] intValue] == 2) {
                CCSprite* tempStar = [CCSprite spriteWithImageNamed:LevelStar];
                tempStar.position = ccp(spinningButton.contentSize.width / 2 + 20, spinningButton.contentSize.height / 2);
                [spinningButton addChild:tempStar];
                spinningLabel.visible = NO;
                
                
                CCSprite* tempStar2 = [CCSprite spriteWithImageNamed:LevelStar];
                tempStar2.position = ccp(spinningButton.contentSize.width / 2 - 20, spinningButton.contentSize.height / 2);
                [spinningButton addChild:tempStar2];
                
            }
            else if([[[[_delegate loadFromPlist] objectForKey:key] objectForKey:@"Stars"] intValue] == 3) {
                CCSprite* tempStar = [CCSprite spriteWithImageNamed:LevelStar];
                tempStar.position = ccp(spinningButton.contentSize.width / 2, spinningButton.contentSize.height / 1.5);
                [spinningButton addChild:tempStar];
                spinningLabel.visible = NO;
                
                
                CCSprite* tempStar2 = [CCSprite spriteWithImageNamed:LevelStar];
                tempStar2.position = ccp(spinningButton.contentSize.width / 2 - 20, spinningButton.contentSize.height / 2);
                [spinningButton addChild:tempStar2];
                
                
                CCSprite* tempStar3 = [CCSprite spriteWithImageNamed:LevelStar];
                tempStar3.position = ccp(spinningButton.contentSize.width / 2 + 20, spinningButton.contentSize.height / 2);
                [spinningButton addChild:tempStar3];
                
            }
            if(i == 20) {
                spinningButton.scale = 1.9;
                spinningButton.position = ccp(spinningButton.position.x+60, spinningButton.position.y - 39);
            }
            if(i > 1) {
                
                CCButton* tempButton = [buttonArray objectAtIndex:i-2];
                CCButton* currButton = [buttonArray objectAtIndex:i-1];
                CGPoint fromPoint = ccp(tempButton.position.x,tempButton.position.y);
                CGPoint toPoint = ccp(currButton.position.x, currButton.position.y);
                
                LineView *line = [[LineView alloc]initWithPoints:fromPoint endPoint:toPoint];
                [self addChild:line z:0];
                 CCSprite* locker;
                if([[[[_delegate loadFromPlist] objectForKey:key] objectForKey:@"Finish"] intValue] == 0) {
                    
               
                    
                    NSString* tempKey = [NSString stringWithFormat:@"Dictionary-%i",i-1];
                    if([[[[_delegate loadFromPlist] objectForKey:tempKey] objectForKey:@"Finish"] intValue] == 1) {
                        
                        spinningButton.opacity = 1.0;
                        spinningButton.enabled = YES;
                        locker.visible = NO;
                        
                        
                    }
                    else {
                        spinningButton.enabled = NO;
                        spinningButton.opacity = 1.0;
                        spinningLabel.visible = NO;
                        locker = [CCSprite spriteWithImageNamed:@"locker.png"];
                        locker.position = ccp(spinningButton.contentSize.width/2, spinningButton.contentSize.height / 1.8);
                        [spinningButton addChild:locker];
                    }
                    
                }
                else {
                    spinningButton.opacity = 1.0;
                    spinningButton.enabled = YES;
                    locker.visible = NO;
                }
            }
        }
    }
    return self;
}

-(void)resizeSprite:(CCSprite*)sprite toWidth:(float)width toHeight:(float)height {
    sprite.scaleX = width / sprite.contentSize.width;
    sprite.scaleY = height / sprite.contentSize.height;
}
-(void)goBack {
    [_delegate goBack];
}
@end
