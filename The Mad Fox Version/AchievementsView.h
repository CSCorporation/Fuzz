//
//  LeaderboardView.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/19/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@protocol AchievementsDelegate
-(void)back;
-(void)shareAchievement1;
-(void)shareAchievement2;
-(void)shareAchievement3;
-(void)shareAchievement4;
-(void)shareAchievement5;
-(void)shareAchievement6;
-(void)shareAchievement7;
@end
@interface AchievementsView : CCNode {
    id<AchievementsDelegate> _delegate;
    
    CCSprite *_card1;
    CCLabelTTF *_card1Label;
    CCButton* _card1_share_button;
    
    CCSprite *_card2;
    CCLabelTTF *_card2Label;
    CCButton* _card2_share_button;
    
    CCSprite *_card3;
    CCLabelTTF *_card3Label;
    CCButton* _card3_share_button;
    
    CCSprite *_card4;
    CCLabelTTF *_card4Label;
    CCButton* _card4_share_button;
    
    CCSprite *_card5;
    CCLabelTTF *_card5Label;
    CCButton* _card5_share_button;
    
    CCSprite *_card6;
    CCLabelTTF *_card6Label;
    CCButton* _card6_share_button;
    
    CCSprite *_card7;
    CCLabelTTF *_card7Label;
    CCButton* _card7_share_button;
    
    CCScrollView *_cardScroll;
}
-(id)initWithDelegate:(id<AchievementsDelegate>) delegateArg;
@property (nonatomic,retain) id<AchievementsDelegate> delegate;
@end
