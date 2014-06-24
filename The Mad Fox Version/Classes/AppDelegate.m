//
//  AppDelegate.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright Viktor Todorov 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "AppDelegate.h"
#import "MenuController.h"
#import "LevelView.h"
#import "PlayController.h"
#import "GameOverController.h"
#import "Constants.h"
#import "LevelController.h"

@implementation AppDelegate

// 
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    NSString* appID = @"5386c204f7e73c3114000007";
    VungleSDK* sdk = [VungleSDK sharedSDK];
    // start vungle publisher library
    [sdk startWithAppId:appID];
    isFirstRunPassed = YES;
    BOOL isRunMoreThanOnce = [[NSUserDefaults standardUserDefaults] boolForKey:@"isRunMoreThanOnce"];
    if(!isRunMoreThanOnce){
        // Show the alert view
        // Then set the first run flag
        isFirstRunPassed = NO;
        NSLog(@"First Run");
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isFirstTimeInShop"];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"showtutorial"];
        long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);

        [[NSUserDefaults standardUserDefaults]setInteger:currentTime forKey:@"dateTime"];

        
        long counter = 1;
        [[NSUserDefaults standardUserDefaults]setInteger:counter forKey:@"rateCounter"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isRunMoreThanOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        NSLog(@"Not First Run");
    }
	// This is the only app delegate method you need to implement when inheriting from CCAppDelegate.
	// This method is a good place to add one time setup code that only runs when your app is first launched.
	// Setup Cocos2D with reasonable defaults for everything.
	// There are a number of simple options you can change.
	// If you want more flexibility, you can configure Cocos2D yourself instead of calling setupCocos2dWithOptions:.
	[self setupCocos2dWithOptions:@{
		// Show the FPS and draw call label.
		CCSetupShowDebugStats: @(NO),
		
		// More examples of options you might want to fiddle with:
		// (See CCAppDelegate.h for more information)
		
		// Use a 16 bit color buffer: 
//		CCSetupPixelFormat: kEAGLColorFormatRGB565,
		// Use a simplified coordinate system that is shared across devices.
//		CCSetupScreenMode: CCScreenModeFixed,
		// Run in portrait mode.
//		CCSetupScreenOrientation: CCScreenOrientationPortrait,
		// Run at a reduced framerate.
//		CCSetupAnimationInterval: @(1.0/30.0),
		// Run the fixed timestep extra fast.
//		CCSetupFixedUpdateInterval: @(1.0/180.0),
		// Make iPad's act like they run at a 2x content scale. (iPad retina 4x)
//		CCSetupTabletScale2X: @(YES),
	}];
	return YES;
}

-(CCScene *)startScene
{
	// This method should return the very first scene to be run when your app starts.
	return [MenuController scene];
}
//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    NSDate *alertTime = [[NSDate date]
//                         dateByAddingTimeInterval:10];
//    UIApplication* app = [UIApplication sharedApplication];
//    UILocalNotification* notifyAlarm = [[UILocalNotification alloc]
//                                        init];
//    if (notifyAlarm)
//    {
//        notifyAlarm.fireDate = alertTime;
//        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
//        notifyAlarm.repeatInterval = 0;
//        notifyAlarm.soundName = @"maina.wav";
//        notifyAlarm.alertBody = @"Come back sunshine";
//        [app scheduleLocalNotification:notifyAlarm];
//    }
//}
@end
