//
//  LevelController.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LevelView.h"

@interface LevelController : CCNodeColor <LevelDelegate> {
    NSMutableDictionary *_data;
}
@property(nonatomic,retain)LevelView *levelView;
+ (CCScene *)scene;

@end
