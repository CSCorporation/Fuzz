//
//  ChapterController.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/19/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ChapterView.h"

@interface ChapterController : CCNodeColor <ChapterDelegate> {
    ChapterView* _view;
}
+ (CCScene *)scene;
@end
