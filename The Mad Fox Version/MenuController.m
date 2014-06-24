//
//  MenuController.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "MenuController.h"
#import "OptionsController.h"
#import "LevelController.h"
#import "ShopController.h"
#import "BonusController.h"
#import "AchievementsController.h"
#import "ChapterController.h"
#import "UserDefaultsUtils.h"
#import "Constants.h"

@implementation MenuController
@synthesize menuView = _menuView;
+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
	MenuController *layer = [MenuController node];
	[scene addChild: layer];
    
	return scene;
}
-(id)init{
    if(self = [super init]){
        
        MenuView *tempMenuView = [[MenuView alloc]initWithDelegate:self];
        [self setMenuView:tempMenuView];
        [self addChild:_menuView];
    }
    return self;
}
-(void)goToChapters {
    NSLog(@"Levels");
    [[CCDirector sharedDirector] replaceScene:[ChapterController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:SceneTransitionTime]];
}
-(void)goToOptions {
    NSLog(@"Options");
    [[CCDirector sharedDirector] replaceScene:[OptionsController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
}
-(void)goToShop {
    NSLog(@"Shop");
    [[CCDirector sharedDirector] replaceScene:[ShopController scene]
                               withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:SceneTransitionTime]];
}
-(void)goToBonus {
    NSLog(@"Bonus");
    [[CCDirector sharedDirector] replaceScene:[BonusController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionDown duration:SceneTransitionTime]];
}
-(void)goToAchievements {
    NSLog(@"Achievements");
    [[CCDirector sharedDirector] replaceScene:[AchievementsController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionDown duration:SceneTransitionTime]];

}
@end
