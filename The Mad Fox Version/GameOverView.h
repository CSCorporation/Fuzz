//
//  GameOverView.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/15/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Level.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"

@protocol SummaryDelegate
-(void)goHome;
-(void)repeatLevel;
-(void)checkAchievements: (CCNode*)node xPosition:(int)xPosition yPosition:(int)yPosition zOrder:(int)zOrder;
-(void)saveToPlist: (int)stars levelNumber:(int)levelNumber isFinished:(BOOL)isFinished;
-(void)nextLevel: (CCNode*)node xPosition:(int)xPosition yPosition:(int)yPosition zOrder:(int)zOrder;
-(void)goToLevels;
-(void)switchToAchievements;
-(NSMutableDictionary*)loadFromPlist;
-(void)rateTheGame;
-(void)goToShop;
@end
@interface GameOverView : CCNode {
     id<SummaryDelegate> _delegate;
    Level *_level;
    CCSprite *star1;
    CCSprite *star2;
    CCSprite *star3;
    int _levelStars;
    NSMutableDictionary *_data;
    CCButton *_next;
    CCSprite* _levelSpot;
}
-(id)initWithDelegate:(id<SummaryDelegate>) delegateArg;
@property (nonatomic,retain) id<SummaryDelegate> delegate;
@end
