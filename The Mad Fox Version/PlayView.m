//
//  PlayView.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "PlayView.h"
#import "Chicken.h"
#import "Fox.h"
#import "Weapon.h"
#import "DefaultWeapon.h"
#import "CutAdjacentWeapon.h"
#import "DummyChickenWeapon.h"
#import "FreezeFoxWeapon.h"
#import "PlayController.h"
#import "PointUtils.h"
#import "HintWeapon.h"
#import "Constants.h"
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCNode.h"
#import "CCAnimation.h"
#import "UserDefaultsUtils.h"
#import "AlertViewHelper.h"

#define kNearZeroValue 0.001f

@implementation PlayView
@synthesize delegate=_delegate,level=_level,foxSpritesDictionary=_foxSpritesDictionary,walkAnimFrames=_walkAnimFrames,eatAnimFrames=_eatAnimFrame,chickenSpritesDictionary=_chickenSpritesDictionary;

-(id)initWithDelegate:(id<PlayDelegate>) delegateArg level:(Level *)level{
    
    if(self = [super init]){
        
        [self setDelegate:delegateArg];
        [self setLevel:level];
        
        self.contentSize = [[CCDirector sharedDirector] viewSize];
        [self setUserInteractionEnabled:YES];
        
        _countNoTouch = 0;
        
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"isHelpShowed"] == NO) {
            if(isFirstRunPassed == YES) {
                [self schedule:@selector(noTouchesCounter) interval:1];
            }
        }
        
        _winSize = [[CCDirector sharedDirector] viewSize];
        
        _currentWeapon = [CCSprite spriteWithImageNamed:DefaultWeaponSprite];
        _currentWeapon.position = ccp(_winSize.width - 40, 35);
        [self addChild:_currentWeapon z:31];
        
        _points = [_level points];
        _spriteLines = [[NSMutableArray alloc]initWithCapacity:[_points count]];
        _spritePoints = [[NSMutableArray alloc]init];
        
        CCButton *quitButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"close-button.png"]];
        quitButton.position = ccp(30, _winSize.height - 30);
        [quitButton setTarget:self selector:@selector(quit)];
        [self addChild:quitButton z:31];
        
        _activateHint = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"hintSprit.png"]];
        _getMoreHints = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"shopSprite.png"]];
        _activateHint.position = ccp(40, 120);
        _getMoreHints.position = ccp(120, 40);
        [self addChild:_activateHint z:30];
        [self addChild:_getMoreHints z:30];
        _activateHint.scale = kNearZeroValue;
        _getMoreHints.scale = kNearZeroValue;
        
        _weaponContainer = [CCSprite spriteWithImageNamed:@"weaponContainerSprite.png"];
        _weaponContainer.position = ccp(_winSize.width - 100, 100);
        [self addChild:_weaponContainer z:29];
        _weaponContainer.opacity = 0;
        
        
        NSString* weaponCounter = [NSString stringWithFormat:@"%i",[[[_level weapons]objectAtIndex:1] stockNumber]];
        _weaponIdentifier = [CCLabelTTF labelWithString:weaponCounter fontName:fontInTheGame fontSize:45];
        _weaponIdentifier.position = ccp(_winSize.width - 200, 40);
        _weaponIdentifier.color = [CCColor blackColor];
        _weaponIdentifier.opacity = 0.0;
        [self addChild:_weaponIdentifier z:30];
        
        _weaponCountLabel = [CCSprite spriteWithImageNamed:@"weaponCountSprite.png"];
        _weaponCountLabel.position = ccp(_winSize.width - 140, 190);
        _weaponCountLabel.opacity = 0.0;
        _weaponCountLabel.rotation = 10;
        [self addChild:_weaponCountLabel z:30];
        
        _weaponLabel = [CCLabelTTF labelWithString:@"" fontName:fontInTheGame fontSize:18];
        [_weaponIdentifier addChild:_weaponLabel];
        
        
        NSString *hintCounter = [NSString stringWithFormat:@"Show Hint: %li hints left",[[UserDefaultsUtils sharedInstance]getHints]];
        CCLabelTTF *activateHintLabel = [CCLabelTTF labelWithString:hintCounter fontName:fontInTheGame fontSize:20];
        activateHintLabel.position = ccp(_activateHint.contentSize.width + 110, _activateHint.contentSize.height / 2);
        activateHintLabel.color = [CCColor blackColor];
        [_activateHint addChild:activateHintLabel];
        
        CCLabelTTF *shopLabel = [CCLabelTTF labelWithString:@"Get Hints" fontName:fontInTheGame fontSize:20];
        shopLabel.position = ccp(_getMoreHints.contentSize.width + 50, _getMoreHints.contentSize.height / 2);
        shopLabel.color = [CCColor blackColor];
        [_getMoreHints addChild:shopLabel];
        
        _numberOfHints = [[UserDefaultsUtils sharedInstance]getHints];
        
        //CCSprite* background = [CCSprite spriteWithImageNamed:PlayBackground];
        //background.anchorPoint = CGPointMake(0, 0);
        //[self addChild:background];
        
        CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor whiteColor]];
        [self addChild:background];
        
        [_delegate hintAction];

        _pathContainer = [CCSprite spriteWithImageNamed:PathContainerSprite];
        _pathContainer.position = ccp(_pathContainer.contentSize.width/2, _pathContainer.contentSize.height/2);
        [self addChild:_pathContainer];
        [self drawAllLines];

        _defaultWeaponButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:DefaultWeaponSprite] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:DefaultWeaponHighlightedSprite] disabledSpriteFrame:nil];
        _cutAdjacentWeaponButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:CutAdjacentWeaponSprite] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:CutAdjacentHighlightedWeaponSprite] disabledSpriteFrame:nil];
        _dummyButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:DummyChickenSprite] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:DummyChickenHighlightedSprite] disabledSpriteFrame:nil];
        _freezeButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:FreezeFoxSprite] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:FreezeFoxHighlightedSprite] disabledSpriteFrame:nil];
        _hintButton = [CCSprite spriteWithImageNamed:HintSprite];
        
        _defaultWeaponButton.position = ccp(_winSize.width - 30, 170);
        _cutAdjacentWeaponButton.position = ccp(_winSize.width - 100, 150);
        _dummyButton.position = ccp(_winSize.width - 150, 100);
        _freezeButton.position = ccp(_winSize.width - 170, 30);
        _hintButton.position = ccp(40, 40);
        
        [self addChild:_defaultWeaponButton z:30];
        [self addChild:_cutAdjacentWeaponButton z:30];
        [self addChild:_dummyButton z:30];
        [self addChild:_freezeButton z:30];
        
        _defaultWeaponButton.scale = kNearZeroValue;
        _cutAdjacentWeaponButton.scale = kNearZeroValue;
        _freezeButton.scale = kNearZeroValue;
        _dummyButton.scale = kNearZeroValue;
        
        //[_hintButton setTarget:self selector:@selector(hintButtonPressed)];
        
        [self addChild:_hintButton];
        
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"showtutorial"] == NO) {
            
            _help1Sprite = [CCSprite spriteWithImageNamed:@"help1.png"];
            _help1Sprite.position = ccp(_hintButton.position.x + 180, _hintButton.position.y+30 );
            [self addChild:_help1Sprite z:31 name:@"help1"];
                
            _help2Sprite = [CCSprite spriteWithImageNamed:@"help2.png"];
            _help2Sprite.position = ccp(_winSize.width - 220, _currentWeapon.position.y+30);
            [self addChild:_help2Sprite z:31 name:@"help2"];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"showtutorial"];
            
        }
            
        
        
        _noOfAdjacentCutsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[[_level weapons]objectAtIndex:1] stockNumber]] fontName:fontInTheGame fontSize:CutAdjacentWeaponCounterFontSize];
        _noOfAdjacentCutsLabel.position = ccp(CutAdjacentWeaponCounterX, CutAdjacentWeaponCounterY);
        _noOfDummyPlacementsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[[_level weapons]objectAtIndex:2] stockNumber]] fontName:fontInTheGame fontSize:DummyChickenCounterFontSize];
        _noOfDummyPlacementsLabel.position = ccp(DummyChickenCounterX, DummyChickenCounterY);
        _noOfFreezesLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[[[_level weapons]objectAtIndex:3] stockNumber]] fontName:fontInTheGame fontSize:FreezeFoxCounterFontSize];
        _noOfFreezesLabel.position = ccp(FreezeFoxCounterX, FreezeFoxCounterY);
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:FoxPlist];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:FoxSpriteSheet];
        
        [self addChild:spriteSheet];
        NSMutableArray *tempWalkAnimFrames = [NSMutableArray array];
        for (int i=1; i<=3; i++) {
            [tempWalkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:FoxFrames,i]]];
        }
        self.walkAnimFrames = tempWalkAnimFrames;
        self.foxSpritesDictionary = [NSMutableDictionary dictionary];
        NSArray *foxesList = [[_level foxesDictionary]allValues];
        for (Fox *fox in foxesList) {
            CCSprite *foxSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:FoxFirstFrame]];
            CGPoint foxPosition = [fox position];
            foxPosition.y = foxPosition.y + 15;
            foxSprite.position = foxPosition;
            [foxSprite setRotationalSkewY:fox.rotation];
            [foxSprite setScale:1];
            [self resizeSprite:foxSprite toWidth:IS_IPAD?100:60 toHeight:IS_IPAD?100:60];
            [_foxSpritesDictionary setObject:foxSprite forKey:[fox keyIndex]];
            [spriteSheet addChild:foxSprite];
        }
        [self animateTheChicken];
    }
	return self;
}
-(void)quit {
    NSLog(@"Quit");
    [[AlertViewHelper sharedInstance]showAlertView:@"Do you want to\nquit?" title:@"Warning" cancelButton:@"NO" otherButton:@"Quit" view:self positionX:_winSize.width/2 positionY:_winSize.height/2 fontName:fontInTheGame fontSize:20 selector:@selector(goBackToMenu) zOrder:31];
}
-(void)noTouchesCounter {

    _countNoTouch++;
    if(_countNoTouch == 14) {
        _needHelpLabel = [CCLabelTTF labelWithString:@" <- Hints can help you out" fontName:fontInTheGame fontSize:20];
        _needHelpLabel.position = ccp(_winSize.width / 2, _hintButton.position.y);
        _needHelpLabel.color = [CCColor blackColor];
        [self addChild:_needHelpLabel z:34 name:@"help"];
        
    }
}
-(void)goBackToMenu {
    [_delegate quitGame];
}
-(void)drawAllLines{
    for(int i=0;i<[_points count];i++){
        CGPoint startPoint = [[_points objectAtIndex:i] startPoint];
        CGPoint endPoint = [[_points objectAtIndex:i] endPoint];
        CCSprite *startPointImg = [CCSprite spriteWithImageNamed:StartPointSprite];
        CCSprite *endPointImg = [CCSprite spriteWithImageNamed:EndPointSprite];
        [self resizeSprite:startPointImg toWidth:23 toHeight:23];
        [self resizeSprite:endPointImg toWidth:23 toHeight:23];
        startPointImg.position = startPoint;
        endPointImg.position = endPoint;
        [_pathContainer addChild:startPointImg z:40];
        [_pathContainer addChild:endPointImg z:40];
        if(![self isPointUsed:startPoint]) {
            NSString *index = [[PointUtils sharedInstance]keyForPosition:startPoint];
            CCLabelTTF *lbl = [CCLabelTTF labelWithString:index fontName:@"Arial" fontSize:70];
            lbl.color = [CCColor purpleColor];
            lbl.position = startPoint;
//            [self addChild:lbl z:100];
            [_spritePoints addObject:startPointImg];
        }
        if(![self isPointUsed:endPoint]) {
            NSString *index = [[PointUtils sharedInstance]keyForPosition:endPoint];
            CCLabelTTF *lbl = [CCLabelTTF labelWithString:index fontName:@"Arial" fontSize:70];
            lbl.color = [CCColor purpleColor];
            lbl.position = endPoint;
//             [self addChild:lbl z:100];
            [_spritePoints addObject:endPointImg];
        }
        [self drawLine:startPoint pointB:endPoint];

    }
}
-(void)moveFoxes{
    if([_level freedom]) {
        int optimalNoOfTurns = [_level optimalNoOfTurns];
        int noOfTurns = [_level numberOfTurns];
        if(noOfTurns <= optimalNoOfTurns){
            stars = 3;
        }
        else if(noOfTurns <= optimalNoOfTurns+3){
            stars = 2;
        }
        else {
            stars = 1;
        }
        [self showGameOver];
    }
    NSArray *foxesList = [[_level foxesDictionary] allValues];
    for (int  i=0; i<[_foxSpritesDictionary count]; i++) {
        Fox *fox = foxesList[i];
        if([fox stuck])
            continue;
        CCSprite *foxSprite = [_foxSpritesDictionary objectForKey:[fox keyIndex]];
        if([foxSprite rotationalSkewY] != [fox rotation])
            [foxSprite setRotationalSkewY:[fox rotation]];
        if(foxSprite.position.x == fox.position.x && foxSprite.position.y == fox.position.y)
            continue;
        [self moveFox:foxSprite toPoint:ccp([fox position].x, [fox position].y+15) fox:fox];
    }
}
-(void)moveFox:(CCSprite*)sprite toPoint:(CGPoint)point fox:(Fox*)fox{
    [self setUserInteractionEnabled:NO];
    
    float spritePoint = sprite.position.x;
    float endPoint = point.x;
    float time = 0;
    if(sprite.position.x != endPoint && sprite.position.y != point.y){
        float w = fabsf(spritePoint - endPoint);
        float h = fabsf(sprite.position.y - point.y);
        time = fabsf(sqrtf((w*w)+(h*h))) / (_pathContainer.contentSize.width/3);
    }
    else
        time = fabsf((spritePoint - endPoint) + (sprite.position.y - point.y)) / (_pathContainer.contentSize.width / 3);
    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:time position:point];
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:_walkAnimFrames delay:0.05f];
    
    CCAction *walkAction = [CCActionRepeatForever actionWithAction:
                            [CCActionAnimate actionWithAnimation:walkAnim]];
    
    [sprite runAction:walkAction];
    
    
    CCActionCallBlock *actionMoveDone = [CCActionCallBlock actionWithBlock:^{
        [sprite stopAction:walkAction];
        NSArray *chickenList = [[_level chickenDictionary] allValues];
        NSMutableArray *chickenListKeys = [[NSMutableArray alloc]init];
        for (int i=0; i<[chickenList count]; i++) {
            [chickenListKeys addObject:[[chickenList objectAtIndex:i] keyIndex]];
        }
       // NSArray *chickenSpritesList = [_chickenSpritesDictionary allValues];
        NSArray *chickenSpritesKeysList = [_chickenSpritesDictionary allKeys];
        if ([chickenListKeys count] < [chickenSpritesKeysList count]) {
            for (int i=0; i<[chickenSpritesKeysList count]; i++) {
                NSString *keyIndex = [chickenSpritesKeysList objectAtIndex:i];
                if (![chickenListKeys containsObject:keyIndex]) {
                    CCSprite *dummyChickenSprite = [_chickenSpritesDictionary objectForKey:keyIndex];
                    [_pathContainer removeChild:dummyChickenSprite];
                    [_chickenSpritesDictionary removeObjectForKey:keyIndex];
                }
            }
        }
        for(int i=0;i<[chickenList count];i++){
            Chicken *chicken =[chickenList objectAtIndex:i];
            if([chicken position].x == [fox position].x && [chicken position].y == [fox position].y){
                    stars = 0;
                    [self showGameOver];
            }
        }
        [self setUserInteractionEnabled:YES];
    }];
    
    [sprite runAction:[CCActionSequence actions:actionMove,actionMoveDone, nil]];
}
-(void)drawLine:(CGPoint)start pointB:(CGPoint)end
{
    float dist = ccpDistance(start, end);
    CCSprite *line = [CCSprite spriteWithImageNamed:PathSprite];
    [line setAnchorPoint:ccp(0.0f, 0.5f)];
    [line setPosition:start];
    [line setScaleX:dist / line.boundingBox.size.width];
    CGPoint firstVector = ccpSub(end, start);
    CGFloat firstRotateAngle = -ccpToAngle(firstVector);
    CGFloat previousTouch = CC_RADIANS_TO_DEGREES(firstRotateAngle);
    [line setRotation:previousTouch];
    [_spriteLines addObject:line];
    [_pathContainer addChild:line];
    
}
-(void)resizeSprite:(CCSprite*)sprite toWidth:(float)width toHeight:(float)height {
    sprite.scaleX = width / sprite.contentSize.width;
    sprite.scaleY = height / sprite.contentSize.height;
}
- (void)back:(id)sender
{
    [_delegate goBack];
}
-(bool)isPointUsed:(CGPoint)point{
    for (CCSprite *pointSprite in _spritePoints) {
        CGPoint spritePoint = [pointSprite position];
        if(spritePoint.x == point.x && spritePoint.y == point.y)
            return true;
    }
    return false;
}
-(void)removePathFromModel:(int)index{
    CCSprite *tempSprite = [_spriteLines objectAtIndex:index];
    [_pathContainer removeChild:tempSprite];
    [_spriteLines removeObject:tempSprite];
    [self buttonPressed];
}
-(void)cutAdjacentPaths:(NSMutableArray *)indices{
    for (NSNumber *indexNumber in indices) {
        int index = [indexNumber intValue];
        CCSprite *tempSprite = [_spriteLines objectAtIndex:index];
        [_pathContainer removeChild:tempSprite];
        [_spriteLines removeObject:tempSprite];
        
    }
    CutAdjacentWeapon *cutWeapon = [[_level weapons]objectAtIndex:1];
    [_noOfAdjacentCutsLabel setString:[NSString stringWithFormat:@"%d",[cutWeapon stockNumber]]];
    [[cutWeapon adjacentIndices]removeAllObjects];
    if([cutWeapon stockNumber] == 0)
        [_cutAdjacentWeaponButton setEnabled:false];
    [self buttonPressed];
}
-(void)putDummyChicken{
    NSArray *chickenList = [[_level chickenDictionary] allValues];
    NSArray *chickenSpritesList = [_chickenSpritesDictionary allValues];
    Chicken *dummyChicken = nil;
    int stockNumber = [[_noOfDummyPlacementsLabel string] intValue];
    if([_chickenSpritesDictionary count] < [chickenList count] && stockNumber > 0){
        for (int i=0; i<[chickenList count];i++) {
            Chicken *chicken = [chickenList objectAtIndex:i];
            if ([chicken isDummyChicken]) {
                for (int j=0;j<[chickenSpritesList count]; j++) {
                    CCSprite *chickenSprite = [chickenSpritesList objectAtIndex:j];
                    if (chicken.position.x != chickenSprite.position.x && chicken.position.y != chickenSprite.position.y) {
                        dummyChicken = chicken;
                    }
                }
            }
        }
        CCSprite *dummyChickenSprite = [CCSprite spriteWithImageNamed:[dummyChicken filename]];
        [_chickenSpritesDictionary setObject:dummyChickenSprite forKey:[dummyChicken keyIndex]];
        dummyChickenSprite.position = dummyChicken.position;
        [_pathContainer addChild:dummyChickenSprite];
        DummyChickenWeapon *dummyWeapon = [[_level weapons]objectAtIndex:2];
        [_noOfDummyPlacementsLabel setString:[NSString stringWithFormat:@"%d",[dummyWeapon stockNumber]]];
        if([dummyWeapon stockNumber] == 0)
            [_dummyButton setEnabled:false];
        [self buttonPressed];
    }
}
-(void)freezeFox{
    NSLog(@"FREEZED");
    
    FreezeFoxWeapon *freezeWeapon = [[_level weapons]objectAtIndex:3];
    [_noOfFreezesLabel setString:[NSString stringWithFormat:@"%d",[freezeWeapon stockNumber]]];
    if([freezeWeapon stockNumber] == 0)
        [_freezeButton setEnabled:false];
    [self buttonPressed];
}
-(void)showHints:(NSMutableArray *)hintList{
    /*NSLog(@"Show hint");
    for (HintWeapon *sd in hintList) {
        if([[sd weapon] isEqualToString:DummyWeaponTitle]) {
            
            _hintSprite = [CCSprite spriteWithImageNamed:DummyChickenSprite];
            _hintSprite.position = [PointUtils getActualPoint:[sd cordX] pointy:[sd cordY]];
            [self resizeSprite:_hintSprite toWidth:20 toHeight:20];
            [self addChild:_hintSprite];

            [hintList removeObjectAtIndex:0];
            break;
        }
        else if([[sd weapon] isEqualToString:DefaultWeaponTitle]) {
            _hintSprite = [_spriteLines objectAtIndex:[sd edgeIndex]];
           
                if([hintList count] != 0) {
                [hintList removeObjectAtIndex:0];
            }
            break;
            
        }
        else if([[sd weapon] isEqualToString:CutAdjacentWeaponTitle]) {
            _hintSprite = [CCSprite spriteWithImageNamed:CutAdjacentWeaponSprite];
            _hintSprite.position = [PointUtils getActualPoint:[sd cordX] pointy:[sd cordY]];
            [self resizeSprite:_hintSprite toWidth:30 toHeight:30];
            [self addChild:_hintSprite];
          
           
            if([hintList count] != 0) {
                [hintList removeObjectAtIndex:0];
            }
            break;
            
            
        }
        else if([[sd weapon]isEqualToString:FreezeWeaponTitle]) {
            _hintSprite = [CCSprite spriteWithImageNamed:FreezeFoxSprite];
            _hintSprite.position = [PointUtils getActualPoint:[sd cordX] pointy:[sd cordY]];
            [self resizeSprite:_hintSprite toWidth:30 toHeight:30];
            [self addChild:_hintSprite];

            if([hintList count] != 0) {
                [hintList removeObjectAtIndex:0];
            }
            break;
        }
    }*/
}
-(void)hintButtonPressed{
    
    [_delegate hintAction];
}
-(void)selectDefaultWeapon{
    [_delegate changeWeapon:0];
    //[self moveTheSlide];
}
-(void)selectCutAdjacentWeapon{
    [_delegate changeWeapon:1];
   // [self moveTheSlide];
}
-(void)selectDummyWeapon{
    [_delegate changeWeapon:2];
    //[self moveTheSlide];
}
-(void)selectFreezeWeapon{
    [_delegate changeWeapon:3];
    //[self moveTheSlide];
}

-(void)buttonPressed{
    [_delegate testViewDelegate];
}

-(void)animateTheChicken {
    if([[_level chickenDictionary]count] == 0)
        return;
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:ChickenPlist];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:ChickenSpriteSheet];
    [self addChild:spriteSheet];
    NSMutableArray *tempChickAnimFrames = [NSMutableArray array];
    for (int i=1; i<=5; i++) {
        [tempChickAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:ChickenFrames,i]]];
        
    }
    self.eatAnimFrames = tempChickAnimFrames;
    self.chickenSpritesDictionary = [NSMutableDictionary dictionary];

    NSArray *chickenList = [[_level chickenDictionary] allValues];
    for (Chicken *chicken in chickenList) {
        CCSprite *chickenSprite = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:ChickenFirstFrame]];
        CGPoint chickenPosition = [chicken position];
        chickenPosition.y = chickenPosition.y +5;
        chickenSprite.position = chickenPosition;
        [chickenSprite setScale:1];
        [self resizeSprite:chickenSprite toWidth:IS_IPAD?100:60 toHeight:IS_IPAD?100:60];
        [_chickenSpritesDictionary setObject:chickenSprite forKey:[chicken keyIndex]];
        [spriteSheet addChild:chickenSprite];
    }
    [self schedule:@selector(runChickenActions) interval:6.0];
}
-(void)runChickenActions {
    NSArray *chickenSpritesList = [_chickenSpritesDictionary allValues];
    NSArray *chickenList = [[_level chickenDictionary] allValues];
    for (int  i=0; i<[chickenSpritesList count]; i++) {
        Chicken *chicken = [chickenList objectAtIndex:i];
        if([chicken isDummyChicken])
            continue;
        CCSprite *chickenSprite = [chickenSpritesList objectAtIndex:i];
        CCAnimation *walkAnim = [CCAnimation
                                 animationWithSpriteFrames:_eatAnimFrames delay:0.3f];
        CCAction *walkAction = [CCActionRepeat actionWithAction:
                                [CCActionAnimate actionWithAnimation:walkAnim] times:1];
        [chickenSprite runAction:walkAction];
    }
}
- (void)onEnter {
    [super onEnter];
    
    self.userInteractionEnabled = TRUE;
}
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint location = [self convertTouchToNodeSpace:touch];
    if([[_level currentWeapon] isKindOfClass:[DefaultWeapon class]]){
        
        for(int i = 0; i <[_spriteLines count];i++)
        {
            // NSLog(@"Array number: %d",_lineArray.count);
            CCSprite *spriteT = [_spriteLines objectAtIndex:i];
            
            CGRect bbox = CGRectMake(0, 0, spriteT.contentSize.width, spriteT.contentSize.height);
            CGPoint newTouchLocation = [spriteT convertToNodeSpace:location];
            
            if(CGRectContainsPoint(bbox, newTouchLocation))
            {
                //[_delegate removePath:[_points objectAtIndex:i]];
                //[[_points objectAtIndex:i] setColor:[UIColor redColor]];
                CCTexture* tex = [CCTexture textureWithFile:@"path_example2_2.png"];
                [[_spriteLines objectAtIndex:i] setTexture: tex];
                break;
            }
        }
    }
    else {
        for(CCSprite *pointSprite in _spritePoints){
            CGRect pointRect = [pointSprite boundingBox];
            
            if(CGRectContainsPoint(pointRect, location)){
                [_delegate specialWeaponAction:[pointSprite position]];
                break;
            }
        }
    }
    
    CGRect expandBox = CGRectMake(0, 0, _currentWeapon.contentSize.width, _currentWeapon.contentSize.height);
    CGPoint touchLocation = [_currentWeapon convertToNodeSpace:location];
    if(CGRectContainsPoint(expandBox, touchLocation))
    {
        
        if([self getChildByName:@"help2" recursively:NO]) {
            [self removeChild:_help2Sprite];
        }
        _currentWeapon.visible = NO;
        [self showWeapons];
    }
    
    CGRect hintBox = CGRectMake(0, 0, _hintButton.contentSize.width, _hintButton.contentSize.height);
    CGPoint touchLocation2 = [_hintButton convertToNodeSpace:location];
    if(CGRectContainsPoint(hintBox, touchLocation2))
    {
        if([self getChildByName:@"help1" recursively:NO]) {
            [self removeChild:_help1Sprite];
        }
        
        _hintButton.visible = NO;
        [self showHintOptions];
    }

}
-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
     CGPoint location = [self convertTouchToNodeSpace:touch];
    
    
    if([[_level currentWeapon] isKindOfClass:[DefaultWeapon class]]){
        
        for(int i = 0; i <[_spriteLines count];i++)
        {
            CCTexture* tex = [CCTexture textureWithFile:@"line.png"];
            [[_spriteLines objectAtIndex:i] setTexture: tex];
            // NSLog(@"Array number: %d",_lineArray.count);
            CCSprite *spriteT = [_spriteLines objectAtIndex:i];
            
            CGRect bbox = CGRectMake(0, 0, spriteT.contentSize.width, spriteT.contentSize.height);
            CGPoint newTouchLocation = [spriteT convertToNodeSpace:location];
            
            if(CGRectContainsPoint(bbox, newTouchLocation))
            {
                [_delegate removePath:[_points objectAtIndex:i]];
                break;
            }
        }
    }
    else {
        for(CCSprite *pointSprite in _spritePoints){
            CGRect pointRect = [pointSprite boundingBox];
            
            if(CGRectContainsPoint(pointRect, location)){
                [_delegate specialWeaponAction:[pointSprite position]];
                break;
            }
        }
    }
    
    _weaponLabel.opacity = 0.0;
    _currentWeapon.visible = YES;
    _hintButton.visible = YES;
    [self hideWeapons];
    [self hideHintOptions];
    _weaponCountLabel.opacity = 0.0;
    _weaponIdentifier.opacity = 0.0;
    
    CGRect defaultWeapon = CGRectMake(0, 0, _defaultWeaponButton.contentSize.width, _defaultWeaponButton.contentSize.height);
    CGPoint touchLocation = [_defaultWeaponButton convertToNodeSpace:location];
    if(CGRectContainsPoint(defaultWeapon, touchLocation))
    {
        NSLog(@"Select Default");
        [self selectDefaultWeapon];
        CCTexture* tex = [CCTexture textureWithFile:DefaultWeaponSprite];
        [_currentWeapon setTexture: tex];
    }
    
    CGRect cutAdjecent = CGRectMake(0, 0, _cutAdjacentWeaponButton.contentSize.width, _cutAdjacentWeaponButton.contentSize.height);
    CGPoint touchLocation2 = [_cutAdjacentWeaponButton convertToNodeSpace:location];
    if(CGRectContainsPoint(cutAdjecent, touchLocation2))
    {
        NSLog(@"Select Cut");
        [self selectCutAdjacentWeapon];
        CCTexture* tex = [CCTexture textureWithFile:CutAdjacentWeaponSprite];
        [_currentWeapon setTexture: tex];
    }

    CGRect freezeWeapon = CGRectMake(0, 0, _freezeButton.contentSize.width, _freezeButton.contentSize.height);
    CGPoint touchLocation3 = [_freezeButton convertToNodeSpace:location];
    if(CGRectContainsPoint(freezeWeapon, touchLocation3))
    {
        NSLog(@"Select Freez");
        [self selectFreezeWeapon];
        CCTexture* tex = [CCTexture textureWithFile:FreezeFoxSprite];
        [_currentWeapon setTexture: tex];
    }
    
    CGRect dummyWeapon = CGRectMake(0, 0, _dummyButton.contentSize.width, _dummyButton.contentSize.height);
    CGPoint touchLocation4 = [_dummyButton convertToNodeSpace:location];
    if(CGRectContainsPoint(dummyWeapon, touchLocation4))
    {
        NSLog(@"Select Dummy");
        [self selectDummyWeapon];
        CCTexture* tex = [CCTexture textureWithFile:DummyChickenSprite];
        [_currentWeapon setTexture: tex];
    }
    CGRect hintBox = CGRectMake(0, 0, _hintButton.contentSize.width, _hintButton.contentSize.height);
    CGPoint touchLocation5 = [_hintButton convertToNodeSpace:location];
    if(CGRectContainsPoint(hintBox, touchLocation5))
    {
        [self hideHintOptions];
    }
    CGRect hintBox2 = CGRectMake(0, 0, _activateHint.contentSize.width, _activateHint.contentSize.height);
    CGPoint touchLocation6 = [_activateHint convertToNodeSpace:location];
    if(CGRectContainsPoint(hintBox2, touchLocation6))
    {
        if([self getChildByName:@"help" recursively:YES]) {
            [self removeChild:_needHelpLabel];
            [self unschedule:@selector(noTouchesCounter)];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isHelpShowed"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }

        if([[UserDefaultsUtils sharedInstance]getHints] <= 0) {
            
            [[AlertViewHelper sharedInstance]showAlertView:@"You don't have hint points.\nPlease visit the shop to get more\nhints." title:@"Uups" cancelButton:@"OK" otherButton:nil view:self positionX:_winSize.width/2 positionY:_winSize.height/2 fontName:fontInTheGame fontSize:20 selector:nil zOrder:31];
            
        }
        else {
            [_delegate hintAction];
            [self hideHintOptions];
            NSLog(@"Hint is activated");
        }
    }
}
-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [self convertTouchToNodeSpace:touch];
    _weaponCountLabel.opacity = 0.0;
    _weaponIdentifier.opacity = 0.0;
    _weaponLabel.opacity = 0.0;
    
    CGRect cutAdjecent = CGRectMake(0, 0, _cutAdjacentWeaponButton.contentSize.width, _cutAdjacentWeaponButton.contentSize.height);
    CGPoint touchLocation2 = [_cutAdjacentWeaponButton convertToNodeSpace:location];
    if(CGRectContainsPoint(cutAdjecent, touchLocation2))
    {
        
        _weaponCountLabel.opacity = 0.8;
        _weaponCountLabel.position = ccp(_winSize.width - 140, 190);
        _weaponCountLabel.rotation = +10;
        _weaponIdentifier.opacity = 1.0;
        _weaponIdentifier.position = ccp(_winSize.width - 140, 195);
        
        _weaponLabel.position = ccp(-110, _weaponIdentifier.contentSize.height / 2);
        _weaponLabel.color = [CCColor blackColor];
        _weaponLabel.string = @"Remove a \nconnection\npoint";
        [_weaponLabel setHorizontalAlignment:CCTextAlignmentRight];
        _weaponLabel.opacity = 1.0;
        
        NSString* weaponCounter__ = [NSString stringWithFormat:@"%i",[[[_level weapons]objectAtIndex:1] stockNumber]];
        _weaponIdentifier.string = weaponCounter__;
        [self selectCutAdjacentWeapon];
        CCTexture* tex = [CCTexture textureWithFile:CutAdjacentWeaponSprite];
        [_currentWeapon setTexture: tex];
    }
    
    CGRect freezeWeapon = CGRectMake(0, 0, _freezeButton.contentSize.width, _freezeButton.contentSize.height);
    CGPoint touchLocation3 = [_freezeButton convertToNodeSpace:location];
    if(CGRectContainsPoint(freezeWeapon, touchLocation3))
    {
        
        _weaponCountLabel.opacity = 0.8;
        _weaponCountLabel.rotation = -20;
        _weaponCountLabel.position = ccp(_winSize.width - 220, 80);
        _weaponIdentifier.opacity = 1.0;
        _weaponIdentifier.position = ccp(_winSize.width - 225, 80);
        
        _weaponLabel.position = ccp(-80, _weaponIdentifier.contentSize.height / 2);
        _weaponLabel.color = [CCColor blackColor];
        _weaponLabel.string = @"Stun";
        _weaponLabel.opacity = 1.0;
        
        NSString* weaponCounter__ = [NSString stringWithFormat:@"%i",[[[_level weapons]objectAtIndex:3] stockNumber]];
        _weaponIdentifier.string = weaponCounter__;
        [self selectFreezeWeapon];
        CCTexture* tex = [CCTexture textureWithFile:FreezeFoxSprite];
        [_currentWeapon setTexture: tex];
    }
    
    CGRect dummyWeapon = CGRectMake(0, 0, _dummyButton.contentSize.width, _dummyButton.contentSize.height);
    CGPoint touchLocation4 = [_dummyButton convertToNodeSpace:location];
    if(CGRectContainsPoint(dummyWeapon, touchLocation4))
    {
        
        _weaponCountLabel.opacity = 0.8;
        _weaponCountLabel.rotation = -5;
        _weaponCountLabel.position = ccp(_winSize.width - 190, 140);
        _weaponIdentifier.opacity = 1.0;
        _weaponIdentifier.position = ccp(_winSize.width - 195, 145);
        
        _weaponLabel.position = ccp(-100, _weaponIdentifier.contentSize.height / 2);
        _weaponLabel.color = [CCColor blackColor];
        _weaponLabel.string = @"Fake Fluffy";
        _weaponLabel.opacity = 1.0;
        
        NSString* weaponCounter__ = [NSString stringWithFormat:@"%i",[[[_level weapons]objectAtIndex:2] stockNumber]];
        _weaponIdentifier.string = weaponCounter__;
        
        [self selectDummyWeapon];
        CCTexture* tex = [CCTexture textureWithFile:DummyChickenSprite];
        [_currentWeapon setTexture: tex];

    }
    
    CGRect defaultWeapon = CGRectMake(0, 0, _defaultWeaponButton.contentSize.width, _defaultWeaponButton.contentSize.height);
    CGPoint touchLocation = [_defaultWeaponButton convertToNodeSpace:location];
    if(CGRectContainsPoint(defaultWeapon, touchLocation))
    {
       
        [self selectDefaultWeapon];
        CCTexture* tex = [CCTexture textureWithFile:DefaultWeaponSprite];
        [_currentWeapon setTexture: tex];
    }
    

    
    CGRect hintBox3 = CGRectMake(0, 0, _getMoreHints.contentSize.width, _getMoreHints.contentSize.height);
    CGPoint touchLocation7 = [_getMoreHints convertToNodeSpace:location];
    if(CGRectContainsPoint(hintBox3, touchLocation7))
    {
        // _hintButton.visible = YES;
        [_delegate openShop];
        [self hideHintOptions];
        NSLog(@"Shop");
        return;
    }

}
-(void)showWeapons {
    
    _weaponContainer.scale = 1;
    _cutAdjacentWeaponButton.scale = 1;
    _freezeButton.scale = 1;
    _defaultWeaponButton.scale = 1;
    _dummyButton.scale = 1;
    _weaponContainer.opacity = 1;

    
}
-(void)hideWeapons {
    
    _weaponContainer.scale = kNearZeroValue;
    _cutAdjacentWeaponButton.scale = kNearZeroValue;
    _freezeButton.scale = kNearZeroValue;
    _defaultWeaponButton.scale = kNearZeroValue;
    _dummyButton.scale = kNearZeroValue;
    
    
}
-(void)showHintOptions {
    
    id scaleWeapon1 = [CCActionScaleTo actionWithDuration:0.1 scale:1];
    id scaleWeapon2 = [CCActionScaleTo actionWithDuration:0.1 scale:1];
    [_activateHint runAction:scaleWeapon1];
    [_getMoreHints runAction:scaleWeapon2];

}
-(void)hideHintOptions {
    
    _hintButton.visible = YES;
    id scaleWeapon1 = [CCActionScaleTo actionWithDuration:0.1 scale:kNearZeroValue];
    id scaleWeapon2 = [CCActionScaleTo actionWithDuration:0.1 scale:kNearZeroValue];
    [_activateHint runAction:scaleWeapon1];
    [_getMoreHints runAction:scaleWeapon2];

}
-(void)showGameOver {
    CCLOG(@"GameOver");
    [_delegate GameOver];
}
- (CGPoint)convertTouchToNodeSpace:(UITouch *)touch
{
	CGPoint point = [touch locationInView: [touch view]];
	point = [[CCDirector sharedDirector] convertToGL: point];
	return [self convertToNodeSpace:point];
}
@end
