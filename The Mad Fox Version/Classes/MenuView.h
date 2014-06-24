//
//  IntroScene.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright Viktor Todorov 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@protocol MenuDelegate
-(void)goToChapters;
-(void)goToOptions;
-(void)goToShop;
-(void)goToBonus;
-(void)goToAchievements;
@end
@interface MenuView : CCNode {
    id<MenuDelegate> _delegate;
}
-(id)initWithDelegate:(id<MenuDelegate>) delegateArg;
@property (nonatomic,retain) id<MenuDelegate> delegate;

@end