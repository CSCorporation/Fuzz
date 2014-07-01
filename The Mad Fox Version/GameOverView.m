//
//  GameOverView.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/15/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "GameOverView.h"
#import "Constants.h"
#import "UserDefaultsUtils.h"
#import "LineView.h"

@implementation GameOverView
@synthesize delegate = _delegate;
-(id)initWithDelegate:(id<SummaryDelegate>)delegateArg{
    if(self = [super init]){
        [self setDelegate:delegateArg];
        CGSize winSize = [[CCDirector sharedDirector] viewSize];
        
        //Check How many times the user was in game over and pop a rate us alertview
        
        NSLog(@"Enter in SummaryView");
        
        if (stars == 0) {
            CCSprite* background = [CCSprite spriteWithImageNamed:GameOverLose];
            background.anchorPoint = CGPointMake(0, 0);
            [self addChild:background z:-2];

        }
        else {
            CCSprite* background = [CCSprite spriteWithImageNamed:GameOverWin];
            background.anchorPoint = CGPointMake(0, 0);
            [self addChild:background z:-2];

        }
        
        CCButton *back = [CCButton buttonWithTitle:@"Menu" fontName:fontInTheGame fontSize:BackButtonFontSize];
        [back setTarget:self selector:@selector(menu)];
        back.position = ccp(winSize.width / 2, winSize.height / 6 - 50);
        [self addChild:back];
        
        CCSprite* backSpot = [CCSprite spriteWithImageNamed:@"splat1.png"];
        backSpot.position = ccp(back.contentSize.width / 2+10, back.contentSize.height / 2+ 10);
        backSpot.scale = 1;
        [back addChild:backSpot];
        
        _next = [CCButton buttonWithTitle:@"Next" fontName:fontInTheGame fontSize:BackButtonFontSize];
        [_next setTarget:self selector:@selector(nextLevel)];
        _next.position = ccp(winSize.width / 1.2, winSize.height / 5);
        [self addChild:_next z:2];
        
        CCSprite* nextSpot = [CCSprite spriteWithImageNamed:@"splat2.png"];
        nextSpot.position = ccp(_next.contentSize.width / 2, _next.contentSize.height / 2);
        nextSpot.scale = 1.2;
        [_next addChild:nextSpot];
        
        
        CCButton *levels = [CCButton buttonWithTitle:@"Again" fontName:fontInTheGame fontSize:BackButtonFontSize];
        [levels setTarget:self selector:@selector(goToLevels)];
        levels.position = ccp(winSize.width / 6, winSize.height / 5);
        [self addChild:levels];
        
        CCSprite* levelSpot = [CCSprite spriteWithImageNamed:@"splat3.png"];
        levelSpot.position = ccp(levels.contentSize.width / 2, levels.contentSize.height / 2);
        levelSpot.scale = 1.2;
        [levels addChild:levelSpot];
        
        CCSprite* woodenSign = [CCSprite spriteWithImageNamed:GameOverContainer];
        woodenSign.position = CGPointMake(winSize.width/2, winSize.height/2);
        [self addChild:woodenSign];
        
        [self setLevelSuccess:stars];
        
        CGPoint fromStars = ccp(_levelSpot.position.x, _levelSpot.position.y);
        CGPoint toSignContainer = ccp(woodenSign.position.x, woodenSign.position.y);
        LineView *a = [[LineView alloc]initWithPoints:fromStars endPoint:toSignContainer];
        [self addChild:a z:-1];
        
        CGPoint fromContainer = ccp(woodenSign.position.x, woodenSign.position.y);
        CGPoint toAgain = ccp(levels.position.x, levels.position.y);
        LineView *b = [[LineView alloc]initWithPoints:fromContainer endPoint:toAgain];
        [self addChild:b z:-1];
        
        CGPoint fromAgain = ccp(levels.position.x, levels.position.y);
        CGPoint toMenu = ccp(back.position.x, back.position.y);
        LineView *c = [[LineView alloc]initWithPoints:fromAgain endPoint:toMenu];
        [self addChild:c z:-1];
        
        CGPoint fromMenu = ccp(back.position.x, back.position.y);
        CGPoint toNext = ccp(_next.position.x, _next.position.y);
        LineView *d = [[LineView alloc]initWithPoints:fromMenu endPoint:toNext];
        [self addChild:d z:-1];
        
        LineView *e = [[LineView alloc] initWithPoints:fromContainer endPoint:toNext];
        [self addChild:e z:-1];
        
        LineView *f = [[LineView alloc]initWithPoints:fromContainer endPoint:toMenu];
        [self addChild:f z:-1];
        
        LineView *g = [[LineView alloc]initWithPoints:fromAgain endPoint:ccp(levels.position.x - 100, _levelSpot.position.y)];
        [self addChild:g z:-1];
        
        LineView *h = [[LineView alloc]initWithPoints:ccp(levels.position.x-100, _levelSpot.position.y) endPoint:fromStars];
        [self addChild:h z:-1];
        
        CCSprite* ball1 = [CCSprite spriteWithImageNamed:@"ball.png"];
        ball1.position = ccp(levels.position.x - 100, _levelSpot.position.y);
        [self addChild:ball1 z:0];
        
        LineView *i = [[LineView alloc]initWithPoints:toNext endPoint:ccp(_next.position.x + 100, _levelSpot.position.y)];
        [self addChild:i z:-1];
        
        LineView *j = [[LineView alloc]initWithPoints:ccp(_next.position.x+100, _levelSpot.position.y) endPoint:fromStars];
        [self addChild:j z:-1];
        
        CCSprite* ball2 = [CCSprite spriteWithImageNamed:@"ball.png"];
        ball2.position = ccp(_next.position.x + 100, _levelSpot.position.y);
        [self addChild:ball2 z:0];
        
        CCSprite* ball3 = [CCSprite spriteWithImageNamed:@"ball.png"];
        ball3.position = fromStars;
        [self addChild:ball3 z:-1];
        
        CCSprite* ball4 = [CCSprite spriteWithImageNamed:@"ball.png"];
        ball4.position = toNext;
        [self addChild:ball4 z:-1];
        
        
    }
    return self;
}
-(CCAction*) pulseAction {
    id scaleDown = [CCActionScaleTo actionWithDuration:.4 scale:0.5];
    id scaleUp = [CCActionScaleTo actionWithDuration:.2 scale:1.5];
    id scaleBack = [CCActionScaleTo actionWithDuration:.2 scale:1.0];
    id combination = [CCActionSequence actions:scaleDown, scaleUp, scaleBack, nil];
    id repeat = [CCActionRepeat actionWithAction:combination times:1];
    return repeat;
}
-(void)setLevelSuccess:(int)numberOfStars {
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    
    if([_level freedom]) {
        numberOfStars = 0;
    }
    
    star1 = [CCSprite spriteWithImageNamed:GameOverStarsSprite];
    star2 = [CCSprite spriteWithImageNamed:GameOverStarsSprite];
    star3 = [CCSprite spriteWithImageNamed:GameOverStarsSprite];
    
    _levelSpot = [CCSprite spriteWithImageNamed:@"splat11.png"];
    _levelSpot.position = ccp(winSize.width / 2+5 , winSize.height / 1.2);
    _levelSpot.scale = 1.4;
    [self addChild:_levelSpot z:1];
    
    star2.opacity = 0;
    star1.opacity = 0;
    
 
    
    CCLabelTTF *levelMeterLabel = [CCLabelTTF labelWithString:@"Failed" fontName:fontInTheGame fontSize:50];
    [levelMeterLabel setColor:[CCColor whiteColor]];
    levelMeterLabel.position =CGPointMake(winSize.width/2.0, winSize.height/2.0);
    [self addChild:levelMeterLabel z:2];
    [levelMeterLabel setVisible:NO];
    
    star1.position = CGPointMake(winSize.width/2.0+(IS_IPAD?70:50), winSize.height/1.2);
    star2.position = CGPointMake(winSize.width/2.0, winSize.height/1.2);
    star3.position = CGPointMake(winSize.width/2.0-(IS_IPAD?70:50), winSize.height/1.2);
    
    if(numberOfStars == 1) {
        CCActionScaleTo* scale = [CCActionScaleTo actionWithDuration:0.2 scale:0.3];
        
        
        levelMeterLabel.scale = 1.8;
        [levelMeterLabel setVisible:YES];
        
        id acBlock = [CCActionCallBlock actionWithBlock:^{
            
            id acBlock2 = [CCActionCallBlock actionWithBlock:^{
                [self showGetHints];
            }];
            id scalea = [CCActionScaleTo actionWithDuration:0.2 scale:1];
            
            [levelMeterLabel runAction:[CCActionSequence actions:scalea, acBlock2,nil]];
            
        }];
        [star3 runAction:[CCActionSequence actions:scale,acBlock, nil]];


        [star1 setVisible:NO];
        [star2 setVisible:NO];
        [star3 setVisible:YES];
        [levelMeterLabel setString:@"Good"];
        
        NSString* key = [NSString stringWithFormat:@"Dictionary-%i",temp_level];
        NSLog(@"NOMER: %i",[[[_data objectForKey:key] objectForKey:@"Stars"] intValue]);
        if([[[[_delegate loadFromPlist] objectForKey:key] objectForKey:@"Stars"] intValue] < 2) {
            
            
            NSString* key2 = [NSString stringWithFormat:@"Dictionary-%i",temp_level];
            if([[[[_delegate loadFromPlist] objectForKey:key2] objectForKey:@"Finish"] intValue] == 0) {
                [[UserDefaultsUtils sharedInstance]addStars:1];
            }
             [_delegate saveToPlist:numberOfStars levelNumber:temp_level isFinished:YES];
        }
    }
    else if(numberOfStars == 2) {
        
        CCActionScaleTo* scale = [CCActionScaleTo actionWithDuration:0.4 scale:0.3];
        CCActionCallBlock* block = [CCActionCallBlock actionWithBlock:^{
            
            
            star2.opacity = 1;
            CCActionCallBlock* block2 = [CCActionCallBlock actionWithBlock:^{
                levelMeterLabel.scale = 1.8;
                [levelMeterLabel setVisible:YES];
                id scale = [CCActionScaleTo actionWithDuration:0.4 scale:1];
                [levelMeterLabel runAction:scale];
            }];
            
            CCActionScaleTo* scale2 = [CCActionScaleTo actionWithDuration:0.4 scale:0.3];
            [star2 runAction:[CCActionSequence actions:scale2,block2, nil]];
            
        }];
        
        [star3 runAction:[CCActionSequence actions:scale,block, nil]];

        
        [star1 setVisible:NO];
        [star2 setVisible:YES];
        [star3 setVisible:YES];
        [levelMeterLabel setString:@"Great"];
        
        NSString* key = [NSString stringWithFormat:@"Dictionary-%i",temp_level];
        if([[[[_delegate loadFromPlist] objectForKey:key] objectForKey:@"Stars"] intValue] < 3) {
            
           
            NSString* key2 = [NSString stringWithFormat:@"Dictionary-%i",temp_level];
            if([[[[_delegate loadFromPlist] objectForKey:key2] objectForKey:@"Finish"] intValue] == 0) {
                [[UserDefaultsUtils sharedInstance]addStars:2];
            }
            else {
                if([[[[_delegate loadFromPlist] objectForKey:key2] objectForKey:@"Stars"] intValue] == 1) {
                     [[UserDefaultsUtils sharedInstance]addStars:1];
                }
            }
             [_delegate saveToPlist:numberOfStars levelNumber:temp_level isFinished:YES];

        }
    }
    else if(numberOfStars == 3) {
        
        CCActionScaleTo* scale = [CCActionScaleTo actionWithDuration:0.4 scale:0.3];
        
        CCActionCallBlock* block = [CCActionCallBlock actionWithBlock:^{
            
            
            star2.opacity = 1;
            CCActionCallBlock* block2 = [CCActionCallBlock actionWithBlock:^{
                
                
                CCActionCallBlock* block3 = [CCActionCallBlock actionWithBlock:^{
                    
                    levelMeterLabel.scale = 1.8;
                    [levelMeterLabel setVisible:YES];
                    id scale = [CCActionScaleTo actionWithDuration:0.4 scale:1];
                    [levelMeterLabel runAction:scale];
                    
                    
                }];
                star1.opacity = 1;
                CCActionScaleTo* scale3 = [CCActionScaleTo actionWithDuration:0.4 scale:0.3];
                [star1 runAction:[CCActionSequence actions:scale3,block3, nil]];
                
            }];
            
            CCActionScaleTo* scale2 = [CCActionScaleTo actionWithDuration:0.4 scale:0.3];
            [star2 runAction:[CCActionSequence actions:scale2,block2, nil]];
            
        }];
        
        [star3 runAction:[CCActionSequence actions:scale,block, nil]];

        [levelMeterLabel setString:@"Awesome"];
        
        
        NSString* key2 = [NSString stringWithFormat:@"Dictionary-%i",temp_level];
        if([[[[_delegate loadFromPlist] objectForKey:key2] objectForKey:@"Finish"] intValue] == 0) {
            [[UserDefaultsUtils sharedInstance]addStars:3];
        }
        else {
            if([[[[_delegate loadFromPlist] objectForKey:key2] objectForKey:@"Stars"] intValue] == 1) {
                [[UserDefaultsUtils sharedInstance]addStars:2];
            }
            else if([[[[_delegate loadFromPlist] objectForKey:key2] objectForKey:@"Stars"] intValue] == 2) {
                [[UserDefaultsUtils sharedInstance]addStars:1];
            }
        }
        [_delegate saveToPlist:numberOfStars levelNumber:temp_level isFinished:YES];
        [_delegate checkAchievements:self xPosition:winSize.width / 2 yPosition:winSize.height / 2 zOrder:10];

    }
    else {
        [_next setVisible:NO];
        NSLog(@"REPEAT THE LEVEL TO GET STARS");
        [star1 setVisible:NO];
        [star2 setVisible:NO];
        [star3 setVisible:NO];
        [levelMeterLabel setString:@"Failed"];
        levelMeterLabel.scale = 1.0;
        [levelMeterLabel setVisible:YES];
        _levelSpot.visible = NO;
        [self showGetHints];
        
    }
    [self addChild:star1 z:2];
    [self addChild:star2 z:2];
    [self addChild:star3 z:2];
}
-(void)goToShop {
    [_delegate goToShop];
}
-(void) showGetHints{
    
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    CCButton* getHints = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"stain2.png"]];
    getHints.position = ccp(winSize.width / 6, winSize.height / 2);
    [self addChild:getHints];
    getHints.scale = 1.2;
    [getHints setTarget:self selector:@selector(goToShop)];
    
    id scaleX2 = [CCActionScaleTo actionWithDuration:0.7 scale:1.3];
    id scaleBack = [CCActionScaleTo actionWithDuration:0.7 scale:1.0];
    
    CCLabelTTF* getHintsLabel = [CCLabelTTF labelWithString:@"Get\nHints" fontName:fontInTheGame fontSize:30];
    getHintsLabel.position = ccp(getHints.contentSize.width / 2-10, getHints.contentSize.height / 2);
    [getHintsLabel setHorizontalAlignment:CCTextAlignmentCenter];
    [getHints addChild:getHintsLabel];
    [getHintsLabel runAction:[CCActionRepeatForever actionWithAction:[CCActionSequence actions:scaleX2,scaleBack,nil]]];

}
-(void)repeat {
    [_delegate repeatLevel];
}
-(void)menu {
    [_delegate goHome];
}
-(void)goToLevels {
    [_delegate goToLevels];
}
-(void)nextLevel {
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    [_delegate nextLevel:self xPosition:winSize.width / 2 yPosition:winSize.height / 2 zOrder:10];
}
-(void)switchToAchievements {
    [_delegate switchToAchievements];
}
-(void)rateTheGame {
    [_delegate rateTheGame];
}
@end
