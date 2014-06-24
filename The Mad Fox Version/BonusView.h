//
//  BonusView.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/16/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@protocol BonusDelegate
-(void)shareOnFacebook;
-(void)shareOnTwitter;
-(void)rateTheGame;
-(void)likeUsOnFacebook;
-(void)back;
-(void)showVideo;
-(void)getDimensions: (CCNode*)node_ xPosition_:(int)xPosition_ yPosition_:(int)yPosition_;
@end
@interface BonusView : CCNode {
    id<BonusDelegate> _delegate;
    
    CCLabelTTF *_title;
    CCButton *_back;
    CCButton *_facebook;
    CCButton *_twitter;
    CCButton *_rate;
    CCButton *_like;
    CCButton *_video;
}
-(id)initWithDelegate:(id<BonusDelegate>) delegateArg;
@property (nonatomic,retain) id<BonusDelegate> delegate;
-(void)checkBonuses;
@end
