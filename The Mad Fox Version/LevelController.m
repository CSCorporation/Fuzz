//
//  LevelController.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "LevelController.h"
#import "MenuController.h"
#import "PlayController.h"
#import "ChapterController.h"
#import "Constants.h"

@implementation LevelController
@synthesize levelView=_levelView;
+ (CCScene *)scene
{
    CCScene *scene = [CCScene node];
	LevelController *layer = [LevelController node];
	[scene addChild: layer];
    
	return scene;
}
-(id)init{
    if(self = [super init]){
        
        LevelView *tempLevelView = [[LevelView alloc]initWithDelegate:self];
        [self setLevelView:tempLevelView];
        [self addChild:_levelView];
        
    }
    NSLog(@"Test Brach");
    return self;
}
-(void)levelSelect:(int)levelNumber{
    CCLOG(@"Level Controller Loaded");
    CCLOG(@"LEVEL %i",levelNumber);
    shopLevel = levelNumber;
    [[CCDirector sharedDirector] replaceScene:[PlayController sceneWithLevelNumber:levelNumber]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
}
-(void)goBack {
    [[CCDirector sharedDirector] replaceScene:[ChapterController scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:SceneTransitionTime]];
    NSLog(@"Test");
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
-(NSMutableDictionary*)loadFromPlist {
    [self readTopScorePlist];
    return _data;
}
@end
