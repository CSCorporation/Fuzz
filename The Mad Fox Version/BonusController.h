//
//  BonusController.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/16/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BonusView.h"
#import <VungleSDK/VungleSDK.h>

@interface BonusController : CCNodeColor <BonusDelegate, VungleSDKDelegate> {
    BonusView* _view;
    CCNode *_tempNode;
    int _xPosition;
    int _yPosition;
}
+ (CCScene *)scene;
@end
