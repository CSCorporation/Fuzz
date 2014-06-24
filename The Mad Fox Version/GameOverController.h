//
//  GameOverController.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/15/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameOverView.h"

@interface GameOverController : CCNodeColor <SummaryDelegate> {
    GameOverView *summaryView;
     NSMutableDictionary *_data;
}
+(CCScene*) scene;
-(void)switchToAchievements;
@end
