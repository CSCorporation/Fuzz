//
//  PlayController.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayView.h"
#import "Level.h"

@interface PlayController : CCNodeColor <PlayDelegate> {
    Level* _level;
    PlayView* _view;
}
@property(nonatomic,retain)PlayView *playView;
+ (CCScene *)sceneWithLevelNumber:(int)levelNumber;
-(id)initWithLevel:(int)level;
@end
