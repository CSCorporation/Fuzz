//
//  AchievementsController.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/19/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AchievementsView.h"

@interface AchievementsController : CCNodeColor <AchievementsDelegate> {
    AchievementsView* _view;
    NSString* _shareMessage;
    
}
+ (CCScene *)scene;
@end
