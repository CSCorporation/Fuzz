//
//  PlayView.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "Level.h"

@protocol PlayDelegate
-(void)testViewDelegate;
-(void)hintAction;
-(void)removePath:(PathLine*)pathline;
-(void)specialWeaponAction:(CGPoint)point;
-(void)changeWeapon:(int)index;
-(void)goBack;
-(void)GameOver;
-(void)openShop;
-(void)quitGame;
@end

@interface PlayView : CCNode <ModelDelegate> {
    id<PlayDelegate> _delegate;
    
    NSMutableArray *_points;
    NSMutableArray *_spriteLines;
    NSMutableArray *_spritePoints;
    NSMutableArray *_walkAnimFrames;
    NSMutableArray *_eatAnimFrames;
    
    NSMutableDictionary *_foxSpritesDictionary;
    NSMutableDictionary *_chickenSpritesDictionary;
    
    CCSprite *_pathContainer;
    CCSprite *_weaponContainer;
    CCSprite *_arrowImage;
    CCSprite *_hintSprite;
    CCSprite* _weaponButton;
    CCSprite* _currentWeapon; //shows the current weapon
    CCSprite* _hintButton; // Hint box button
    CCSprite* _weaponCountLabel;
    CCSprite* _help1Sprite; //First run shows the help sprite for hints
    CCSprite* _help2Sprite; //First run shows the help sprite for weapons
    CCSprite* _help3Sprite; //First run shows the help srpite for cuttin lines
    
    Level *_level;
    
    CCLabelTTF* _noOfAdjacentCutsLabel;
    CCLabelTTF* _noOfDummyPlacementsLabel;
    CCLabelTTF* _noOfFreezesLabel;
    CCLabelTTF* _weaponLabel; // shows a label with weapon name
    CCLabelTTF* _weaponIdentifier;
    CCLabelTTF* _needHelpLabel;
    
    CCButton *_defaultWeaponButton;
    CCButton *_cutAdjacentWeaponButton;
    CCButton *_dummyButton;
    CCButton *_freezeButton;
    CCButton *_activateHint; //Use hint
    CCButton *_getMoreHints; //Go to shop

    bool _isVisible;
    CGSize _winSize;
    int _countNoTouch;
    long _numberOfHints;
    

    
    
    
    

    
}
-(id)initWithDelegate:(id<PlayDelegate>) delegateArg level:(Level*)level;
@property (nonatomic,retain) id<PlayDelegate> delegate;
@property (nonatomic,retain) Level* level;
@property (nonatomic,retain) NSMutableDictionary *foxSpritesDictionary;
@property (nonatomic,retain) NSMutableDictionary *chickenSpritesDictionary;
@property (nonatomic,retain) NSMutableArray *walkAnimFrames;
@property (nonatomic,retain) NSMutableArray *eatAnimFrames;
//-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
@end
