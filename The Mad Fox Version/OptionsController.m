//
//  OptionsController.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "OptionsController.h"
#import "MenuController.h"
#import "Constants.h"

@implementation OptionsController
@synthesize optionsView = _optionsView;
+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
	OptionsController *layer = [OptionsController node];
	[scene addChild: layer];
    
	return scene;
}
-(id)init{
    if(self = [super init]){
        
        OptionsView *tempOptionsView = [[OptionsView alloc]initWithDelegate:self];
        [self setOptionsView:tempOptionsView];
        [self addChild:_optionsView];
        
    }
    return self;
}
-(void)musicConfiguration {
    CCLOG(@"Options Controller Loaded");
}
-(void)goBack {
    [[CCDirector sharedDirector] replaceScene:[MenuController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionDown duration:SceneTransitionTime]];
}
@end
