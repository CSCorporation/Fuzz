//
//  GameOverController.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/15/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "GameOverController.h"
#import "MenuController.h"
#import "UserDefaultsUtils.h"
#import "Level.h"
#import "LevelController.h"
#import "PlayController.h"
#import "Constants.h"
#import "AlertViewHelper.h"
#import "AchievementsController.h"
#import "Constants.h"
#import "ShopController.h"

@implementation GameOverController
+(CCScene*) scene {
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOverController *layer = [GameOverController node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    // return the scene
	return scene;
}
-(id)init{
    if(self = [super init]){
        summaryView= [[GameOverView alloc]initWithDelegate:self];
        [self addChild:summaryView];
        [self readTopScorePlist];
    }
    return self;
}
-(void)goHome {
    NSLog(@"Controller home");
    NSLog(@"Menu");
    [[CCDirector sharedDirector] replaceScene:[MenuController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
    
}
-(void)repeatLevel {
    NSLog(@"Controller repeat");
    
}
-(void)checkAchievements: (CCNode*)node xPosition:(int)xPosition yPosition:(int)yPosition zOrder:(int)zOrder {
    [self readTopScorePlist];
    int counter = 0;
    for (int i = 1; i <= 21; i++) {
        NSString* key = [NSString stringWithFormat:@"Dictionary-%i",i];
        if([[[_data objectForKey:key] objectForKey:@"Stars"] intValue] == 3) {
            counter++;
        }
    }
/*
                           ||
                           ||
Set The Achievements HERE \\//
                           \/
     
*/
    if(counter == 1) {
        if([[UserDefaultsUtils sharedInstance]getAchievement:1] == NO) {
            [[UserDefaultsUtils sharedInstance] setAchievementPassed:YES AchievementNumber:1];
            
            [[AlertViewHelper sharedInstance]showAlertView:@"You achieve Begginer Level" title:@"Congrats" cancelButton:@"Sweet" otherButton:@"Check" view:node positionX:xPosition positionY:yPosition fontName:fontInTheGame fontSize:15 selector:@selector(switchToAchievements) zOrder:15];
        }
    }
    if(counter == 2) {
        if([[UserDefaultsUtils sharedInstance]getAchievement:2] == NO) {
            [[UserDefaultsUtils sharedInstance] setAchievementPassed:YES AchievementNumber:2];
            
            [[AlertViewHelper sharedInstance]showAlertView:@"You achieve Novice Level" title:@"Congrats" cancelButton:@"Sweet" otherButton:@"Check" view:node positionX:xPosition positionY:yPosition fontName:fontInTheGame fontSize:15 selector:@selector(switchToAchievements) zOrder:15];
        }
    }
    if(counter == 3) {
        if([[UserDefaultsUtils sharedInstance]getAchievement:3] == NO) {
        [[UserDefaultsUtils sharedInstance] setAchievementPassed:YES AchievementNumber:3];
            
        [[AlertViewHelper sharedInstance]showAlertView:@"You achieve INTERMEDIATE Level" title:@"Congrats" cancelButton:@"Sweet" otherButton:@"Check" view:node positionX:xPosition positionY:yPosition fontName:fontInTheGame fontSize:15 selector:@selector(switchToAchievements) zOrder:15];
        }
    }
    if(counter == 4) {
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"Rate"] == NO) {
            [[AlertViewHelper sharedInstance]showAlertView:@"We hope you like our game. If you\nhave a moment please rate the game\nin the app store" title:@"MadFox" cancelButton:@"Hide Forever" otherButton:@"Rate" view:node positionX:xPosition positionY:yPosition fontName:fontInTheGame fontSize:15 selector:@selector(rateTheGame) zOrder:zOrder];
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Rate"];
        }
    }
}
-(void)switchToAchievements {
    [[AlertViewHelper sharedInstance]cancelAction];
    [[CCDirector sharedDirector] replaceScene:[AchievementsController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
}
-(void)readTopScorePlist
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database.plist"]; //3
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"plist"]; //5
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    _data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSLog(@"Dictionary %@",_data);
}
-(void)saveToPlist: (int)stars levelNumber:(int)levelNumber isFinished:(BOOL)isFinished {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database.plist"]; //3
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"plist"]; //5
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path ];
    NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
    NSNumber *boolNumber = [NSNumber numberWithBool:isFinished];
    NSString* levelKey = [NSString stringWithFormat:@"Dictionary-%i",levelNumber];
    
    [temp setObject:[NSString stringWithFormat:@"%i",stars] forKey:@"Stars"];
    [temp setObject:[NSString stringWithFormat:@"%i",levelNumber] forKey:@"Level"];
    [temp setObject:boolNumber forKey:@"Finish"];
    [data setObject:temp forKey:levelKey];
    [data writeToFile:path atomically:YES];
    
}
-(NSMutableDictionary*)loadFromPlist {
    [self readTopScorePlist];
    return _data;
}
-(void)nextLevel: (CCNode*)node xPosition:(int)xPosition yPosition:(int)yPosition zOrder:(int)zOrder {
    NSLog(@"Next Level");
   
    if(temp_level+1 == 5) {
        if([[UserDefaultsUtils sharedInstance]getStars] < 10) {
            
            [[AlertViewHelper sharedInstance]showAlertView:@"You need at least 10 stars to\n play this level" title:@"Uupss" cancelButton:@"OK" otherButton:nil view:node positionX:xPosition positionY:yPosition fontName:fontInTheGame fontSize:15 selector:nil zOrder:10];
        }
        else {
            [[CCDirector sharedDirector] replaceScene:[PlayController sceneWithLevelNumber:(temp_level+1)]
                                       withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
        }
    }
    else {
        [[CCDirector sharedDirector] replaceScene:[PlayController sceneWithLevelNumber:(temp_level+1)]
                                   withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
    }
}
-(void)goToLevels {
    NSLog(@"Go To Levels");
    [[CCDirector sharedDirector] replaceScene:[PlayController sceneWithLevelNumber:temp_level]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
}

-(void)rateTheGame {
    [[AlertViewHelper sharedInstance]cancelAction];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
                                                @"itms-apps://itunes.apple.com/app/bubble-math/id874794787?mt=8&uo=4"]];
}
-(void)goToShop {
    [[CCDirector sharedDirector] replaceScene:[ShopController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
}
@end
