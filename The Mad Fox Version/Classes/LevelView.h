//
//  HelloWorldScene.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright Viktor Todorov 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using Cocos2D v3
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "Level.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@protocol LevelDelegate
-(void)levelSelect:(int)levelNumber;
-(void)goBack;
-(NSMutableDictionary*)loadFromPlist;
@end

@interface LevelView : CCNode {
    id<LevelDelegate> _delegate;
    Level* _level;
    NSMutableDictionary *_data;
    
}
-(id)initWithDelegate:(id<LevelDelegate>) delegateArg;
@property (nonatomic,retain) id<LevelDelegate> delegate;

@end