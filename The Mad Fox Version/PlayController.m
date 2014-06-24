//
//  PlayController.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "PlayController.h"
#import "MenuController.h"
#import "LevelController.h"
#import "GameOverController.h"
#import "Constants.h"
#import "ShopController.h"


@implementation PlayController
@synthesize playView = _playView;
+ (CCScene *)sceneWithLevelNumber:(int)levelNumber
{
    CCScene *scene = [CCScene node];
	PlayController *layer = [PlayController nodeWithGameLevel:levelNumber];
	[scene addChild: layer];
	return scene;
}
+(id)nodeWithGameLevel:(int)levelNumber{
    return  [[self alloc] initWithLevel:levelNumber];
}
-(id)initWithLevel:(int)level{
    if(self = [super init]){
        
        NSString *xmlFilename = [NSString stringWithFormat:@"level_%d",level];
        temp_level = level;
        _level = [[Level alloc] initWithFilename:xmlFilename];
        _view = [[PlayView alloc]initWithDelegate:self level:_level];
        [_level setObserverDelegate:_view];
        [self addChild:_view];
    }
    return self;
}

-(void)goBack {
    [[PointUtils sharedInstance] removeAllPositions];
    [[CCDirector sharedDirector] replaceScene:[LevelController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionDown duration:SceneTransitionTime]];

}

-(void)removePath:(PathLine *)pathline{
    
    [_level removePathEdge:pathline];
}
-(void)hintAction{
    //NSLog(@"Hint pressed");
    //[_level generateHints];
}
-(void)changeWeapon:(int)index{
    [_level changeWeapon:index];
}
-(void)specialWeaponAction:(CGPoint)point{
    [_level specialWeaponAction:point];
}

-(void)testViewDelegate{
    
    [_level moveFoxes];
    
}
-(void)GameOver {
    CCLOG(@"Menu Controller Loaded");
    [[PointUtils sharedInstance] removeAllPositions];
    [[CCDirector sharedDirector] replaceScene:[GameOverController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
}
-(void)openShop {
    [[CCDirector sharedDirector] replaceScene:[ShopController scene]
                               withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:SceneTransitionTime]];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"playview"];

}
-(void)quitGame {
    [[CCDirector sharedDirector] replaceScene:[MenuController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
}
@end
