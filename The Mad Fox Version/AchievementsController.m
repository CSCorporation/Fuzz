//
//  AchievementsController.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/19/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "AchievementsController.h"
#import "MenuController.h"
#import "Constants.h"

@implementation AchievementsController
+(CCScene*) scene {
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	AchievementsController *layer = [AchievementsController node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    // return the scene
	return scene;
}
-(id)init{
    if(self = [super init]){
        
        _view= [[AchievementsView alloc]initWithDelegate:self];
        [self addChild:_view];
        
    }
    return self;
}
-(void)back {
    NSLog(@"Menu");
    [[CCDirector sharedDirector] replaceScene:[MenuController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
}
-(void)shareAchievement1 {
    NSLog(@"Share 1");
    _shareMessage = achiev_share_1;
    [self postShare];
}
-(void)shareAchievement2 {
    NSLog(@"Share 2");
    _shareMessage = achiev_share_2;
    [self postShare];
}-(void)shareAchievement3 {
    NSLog(@"Share 3");
    _shareMessage = achiev_share_3;
    [self postShare];
}
-(void)shareAchievement4 {
    NSLog(@"Share 4");
    _shareMessage = achiev_share_4;
    [self postShare];
} 
-(void)shareAchievement5 {
    NSLog(@"Share 5");
    _shareMessage = achiev_share_5;
    [self postShare];
}
-(void)shareAchievement6 {
    NSLog(@"Share 6");
    _shareMessage = achiev_share_6;
    [self postShare];
}
-(void)shareAchievement7 {
    NSLog(@"Share 7");
    _shareMessage = achiev_share_7;
    [self postShare];
}
-(void)postShare {
    
    NSArray* achievementToShare = @[_shareMessage];
    UIActivityViewController *viewController = [[UIActivityViewController alloc]initWithActivityItems:achievementToShare applicationActivities:nil];
    viewController.excludedActivityTypes = @[];
    [[CCDirector sharedDirector]presentViewController:viewController animated:YES completion:nil];
    
}
@end
