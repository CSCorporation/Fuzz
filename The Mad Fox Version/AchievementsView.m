//
//  LeaderboardView.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/19/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "AchievementsView.h"
#import "Constants.h"
#import "UserDefaultsUtils.h"

@implementation AchievementsView
@synthesize delegate = _delegate;
-(id)initWithDelegate:(id<AchievementsDelegate>)delegateArg{
    if(self = [super init]){
        
        [self setDelegate:delegateArg];
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        self.contentSize = [[CCDirector sharedDirector] viewSize];
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        
        CCSprite* background = [CCSprite spriteWithImageNamed:BonusBackground];
        background.anchorPoint = CGPointMake(0, 0);
        //[self addChild:background];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Achievements" fontName:fontInTheGame fontSize:40];
        title.position = ccp(viewSize.width / 2, viewSize.height / 2+(IS_IPAD?350:130));
        [self addChild:title];
        
        CCButton *back = [CCButton buttonWithTitle:BackButtonTitle fontName:fontInTheGame fontSize:BackButtonFontSize];
        [back setTarget:self selector:@selector(back)];
        back.position = ccp(viewSize.width / 2, viewSize.height / 6 - 20);
        [self addChild:back];
        
        CCNode *cards = [CCNode node];
        cards.contentSize = CGSizeMake(viewSize.width * 3, viewSize.height);
        
        _card1 = [CCSprite spriteWithImageNamed:achiev_image_1];
        _card1.position = ccp(viewSize.width * 0.5, viewSize.height / 2);
        _card1Label = [CCLabelTTF labelWithString:achiev_label_1 fontName:fontInTheGame fontSize:achievements_fontSize];
        _card1Label.position = ccp(viewSize.width * 0.5, viewSize.height / 2+60);
        _card1_share_button = [CCButton buttonWithTitle:achiev_share_label fontName:fontInTheGame fontSize:achievements_fontSize];
        _card1_share_button.position = ccp(viewSize.width * 0.5, viewSize.height / 2-60);
        [_card1_share_button setTarget:self selector:@selector(shareAchievement1)];
        
        _card2 = [CCSprite spriteWithImageNamed:achiev_image_2];
        _card2.position = ccp(viewSize.width * 0.8, viewSize.height / 2);
        _card2Label = [CCLabelTTF labelWithString:achiev_label_2 fontName:fontInTheGame fontSize:achievements_fontSize];
        _card2Label.position = ccp(viewSize.width * 0.8, viewSize.height / 2+60);
        _card2_share_button = [CCButton buttonWithTitle:achiev_share_label fontName:fontInTheGame fontSize:achievements_fontSize];
        _card2_share_button.position = ccp(viewSize.width * 0.8, viewSize.height / 2-60);
        [_card2_share_button setTarget:self selector:@selector(shareAchievement2)];
        
        _card3 = [CCSprite spriteWithImageNamed:achiev_image_3];
        _card3.position = ccp(viewSize.width * 1.1, viewSize.height / 2);
        _card3Label = [CCLabelTTF labelWithString:achiev_label_3 fontName:fontInTheGame fontSize:achievements_fontSize];
        _card3Label.position = ccp(viewSize.width * 1.1, viewSize.height / 2+60);
        _card3_share_button = [CCButton buttonWithTitle:achiev_share_label fontName:fontInTheGame fontSize:achievements_fontSize];
        _card3_share_button.position = ccp(viewSize.width * 1.1, viewSize.height / 2-60);
        [_card3_share_button setTarget:self selector:@selector(shareAchievement3)];
        
        _card4 = [CCSprite spriteWithImageNamed:achiev_image_4];
        _card4.position = ccp(viewSize.width * 1.4, viewSize.height / 2);
        _card4Label = [CCLabelTTF labelWithString:achiev_label_4 fontName:fontInTheGame fontSize:achievements_fontSize];
        _card4Label.position = ccp(viewSize.width * 1.4, viewSize.height / 2+60);
        _card4_share_button = [CCButton buttonWithTitle:achiev_share_label fontName:fontInTheGame fontSize:achievements_fontSize];
        _card4_share_button.position = ccp(viewSize.width * 1.4, viewSize.height / 2-60);
        [_card4_share_button setTarget:self selector:@selector(shareAchievement4)];
        
        _card5 = [CCSprite spriteWithImageNamed:achiev_image_5];
        _card5.position = ccp(viewSize.width * 1.7, viewSize.height / 2);
        _card5Label = [CCLabelTTF labelWithString:achiev_label_5 fontName:fontInTheGame fontSize:achievements_fontSize];
        _card5Label.position = ccp(viewSize.width * 1.7, viewSize.height / 2+60);
        _card5_share_button = [CCButton buttonWithTitle:achiev_share_label fontName:fontInTheGame fontSize:achievements_fontSize];
        _card5_share_button.position = ccp(viewSize.width * 1.7, viewSize.height / 2-60);
        [_card5_share_button setTarget:self selector:@selector(shareAchievement5)];
        
        _card6 = [CCSprite spriteWithImageNamed:achiev_image_6];
        _card6.position = ccp(viewSize.width * 2.0, viewSize.height / 2);
        _card6Label = [CCLabelTTF labelWithString:achiev_label_6 fontName:fontInTheGame fontSize:achievements_fontSize];
        _card6Label.position = ccp(viewSize.width * 2.0, viewSize.height / 2+60);
        _card6_share_button = [CCButton buttonWithTitle:achiev_share_label fontName:fontInTheGame fontSize:achievements_fontSize];
        _card6_share_button.position = ccp(viewSize.width * 2.0, viewSize.height / 2-60);
        [_card6_share_button setTarget:self selector:@selector(shareAchievement6)];
        
        _card7 = [CCSprite spriteWithImageNamed:achiev_image_7];
        _card7.position = ccp(viewSize.width * 2.3, viewSize.height / 2);
        _card7Label = [CCLabelTTF labelWithString:achiev_label_7 fontName:fontInTheGame fontSize:achievements_fontSize];
        _card7Label.position = ccp(viewSize.width * 2.3, viewSize.height / 2+60);
        _card7_share_button = [CCButton buttonWithTitle:achiev_share_label fontName:fontInTheGame fontSize:achievements_fontSize];
        _card7_share_button.position = ccp(viewSize.width * 2.3, viewSize.height / 2-60);
        [_card7_share_button setTarget:self selector:@selector(shareAchievement7)];
        
        [self checkAchievements];
        
        [cards addChild:_card1];
        [cards addChild:_card1Label];
        [cards addChild:_card1_share_button];
        [cards addChild:_card2];
        [cards addChild:_card2Label];
        [cards addChild:_card2_share_button];
        [cards addChild:_card3];
        [cards addChild:_card3Label];
        [cards addChild:_card3_share_button];
        [cards addChild:_card4];
        [cards addChild:_card4Label];
        [cards addChild:_card4_share_button];
        [cards addChild:_card5];
        [cards addChild:_card5Label];
        [cards addChild:_card5_share_button];
        [cards addChild:_card6];
        [cards addChild:_card6Label];
        [cards addChild:_card6_share_button];
        [cards addChild:_card7];
        [cards addChild:_card7Label];
        [cards addChild:_card7_share_button];
        
        _cardScroll = [[CCScrollView alloc] initWithContentNode:cards];
        [_cardScroll setAnchorPoint:ccp(0.0f, 0.0f)];
        [_cardScroll setPosition:ccp(0, 0)];
        [_cardScroll setPagingEnabled:NO];
        [_cardScroll setVerticalScrollEnabled:NO];
        [self addChild:_cardScroll z:1 name:@"Card Scroll"];
    }
    return self;
}
-(void)back {
    [_delegate back];
}
-(void)checkAchievements {
    
    UserDefaultsUtils* ud = [UserDefaultsUtils sharedInstance];
    
    BOOL is_achiev_1_passed = [ud getAchievement:1];
    BOOL is_achiev_2_passed = [ud getAchievement:2];;
    BOOL is_achiev_3_passed = [ud getAchievement:3];;
    BOOL is_achiev_4_passed = [ud getAchievement:4];;
    BOOL is_achiev_5_passed = [ud getAchievement:5];;
    BOOL is_achiev_6_passed = [ud getAchievement:6];;
    BOOL is_achiev_7_passed = [ud getAchievement:7];;
    
    if(!is_achiev_1_passed) {
        _card1.opacity = 0.4;
        _card1_share_button.visible = NO;
    }
    if(!is_achiev_2_passed) {
        _card2.opacity = 0.4;
        _card2_share_button.visible = NO;
    }
    if(!is_achiev_3_passed) {
        _card3.opacity = 0.4;
        _card3_share_button.visible = NO;
    }
    if(!is_achiev_4_passed) {
        _card4.opacity = 0.4;
        _card4_share_button.visible = NO;
    }
    if(!is_achiev_5_passed) {
        _card5.opacity = 0.4;
        _card5_share_button.visible = NO;
    }
    if(!is_achiev_6_passed) {
        _card6.opacity = 0.4;
        _card6_share_button.visible = NO;
    }
    if(!is_achiev_7_passed) {
        _card7.opacity = 0.4;
        _card7_share_button.visible = NO;
    }
    
}
-(void)shareAchievement1 {
    [_delegate shareAchievement1];
}
-(void)shareAchievement2 {
    [_delegate shareAchievement2];
}
-(void)shareAchievement3 {
    [_delegate shareAchievement3];
}
-(void)shareAchievement4 {
    [_delegate shareAchievement4];
}
-(void)shareAchievement5 {
    [_delegate shareAchievement5];
}
-(void)shareAchievement6 {
    [_delegate shareAchievement6];
}
-(void)shareAchievement7 {
    [_delegate shareAchievement7];
}

@end
