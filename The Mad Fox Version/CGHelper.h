//
//  CGHelper.h
//  dotsTemplate
//
//  Created by Viktor Todorov on 3/14/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface CGHelper : NSObject <GKGameCenterControllerDelegate>
{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (nonatomic, strong) NSArray* leaderboards;
@property (nonatomic, strong) NSMutableDictionary *achievementsDictionary;

+ (CGHelper*)defaultHelper;
- (void)authenticateLocalUserOnViewController:(UIViewController*)viewController
setCallbackObject:(id)obj
withPauseSelector:(SEL)selector;

- (void)reportScore:(int64_t)score forLeaderboardID:(NSString*)identifier;
- (void)showLeaderboardOnViewController:(UIViewController*)viewController;

- (void)reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent;
- (GKAchievement*)getAchievementForIdentifier: (NSString*) identifier;
- (void)resetAchievements;
- (void)completeMultipleAchievements:(NSArray*)achievements;
- (void)registerListener:(id<GKLocalPlayerListener>)listener;

@end