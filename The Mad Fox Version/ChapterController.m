//
//  ChapterController.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/19/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "ChapterController.h"
#import "MenuController.h"
#import "Constants.h"
#import "LevelController.h"

@implementation ChapterController
+(CCScene*) scene {
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ChapterController *layer = [ChapterController node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    // return the scene
	return scene;
}
-(id)init{
    if(self = [super init]){
        
        _view= [[ChapterView alloc]initWithDelegate:self];
        [self addChild:_view];
        
    }
    return self;
}
-(void)back {
    NSLog(@"Menu");
    [[CCDirector sharedDirector] replaceScene:[MenuController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
}
-(void)loadChapter {
    
    if (chapterNumber == 1) {
        NSLog(@"Chapter 1");
        NSLog(@"Levels");
        [[CCDirector sharedDirector] replaceScene:[LevelController scene]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:SceneTransitionTime]];
    }
    else if(chapterNumber == 2) {
        NSLog(@"Chapter 2");
    }
    else if(chapterNumber == 3) {
        NSLog(@"Chapter 3");
    }
    else {
        NSLog(@"Wrong Chapter Number");
    }
    
}
@end
