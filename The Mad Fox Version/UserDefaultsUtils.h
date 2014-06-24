//
//  UserDefaultsUtils.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/20/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UserDefaultsUtils : NSObject {
    
}

+ (UserDefaultsUtils*)sharedInstance;
-(void)setAchievementPassed: (BOOL)isPassed AchievementNumber:(int)number;
-(BOOL)getAchievement: (int)AchievementNumber;
-(void)setBonusApproved: (BOOL)isApproved BonusNumber:(int)number;
-(BOOL)getBonus:(int)BonusNumber;
-(void)addMoney:(long)money;
-(void)removeMoney:(long)money;
-(long)getMoney;
-(void)setSound: (BOOL)enableSound;
-(BOOL)getSound;
-(void)addStars:(long)stars;
-(long)getStars;
-(void)addHints: (long)numberOfHints_;
-(void)removeHints: (long)numberOfHints_;
-(long)getHints;
@end
