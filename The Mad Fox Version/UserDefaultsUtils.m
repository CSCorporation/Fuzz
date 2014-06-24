//
//  UserDefaultsUtils.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/20/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "UserDefaultsUtils.h"



@implementation UserDefaultsUtils

+(UserDefaultsUtils*)sharedInstance
{
    static UserDefaultsUtils *_shared = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}
-(void)setAchievementPassed: (BOOL)isPassed AchievementNumber:(int)number {
    
    if(number == 1) {
        
        [[NSUserDefaults standardUserDefaults]setBool:isPassed forKey:@"Achievement1"];
        
    }
    else if(number == 2) {
        
        [[NSUserDefaults standardUserDefaults]setBool:isPassed forKey:@"Achievement2"];
        
    }
    else if(number == 3) {
       
        [[NSUserDefaults standardUserDefaults]setBool:isPassed forKey:@"Achievement3"];
        
    }
    else if(number == 4) {
        
        [[NSUserDefaults standardUserDefaults]setBool:isPassed forKey:@"Achievement4"];
        
    }
    else if(number == 5) {
        
        [[NSUserDefaults standardUserDefaults]setBool:isPassed forKey:@"Achievement5"];
        
    }
    else if(number == 6) {
        
        [[NSUserDefaults standardUserDefaults]setBool:isPassed forKey:@"Achievement6"];
       
    }
    else if(number == 7) {
        
        [[NSUserDefaults standardUserDefaults]setBool:isPassed forKey:@"Achievement7"];
        
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(BOOL)getAchievement: (int)AchievementNumber {
    
    NSString *temp = [NSString stringWithFormat:@"Achievement%i",AchievementNumber];
    return [[NSUserDefaults standardUserDefaults]boolForKey:temp];
    
}
-(void)setBonusApproved: (BOOL)isApproved BonusNumber:(int)number {
    if(number == 1) {
         [[NSUserDefaults standardUserDefaults]setBool:isApproved forKey:@"Bonus1"];
    }
    else if(number == 2) {
        [[NSUserDefaults standardUserDefaults]setBool:isApproved forKey:@"Bonus2"];
    }
    else if(number == 3) {
        [[NSUserDefaults standardUserDefaults]setBool:isApproved forKey:@"Bonus3"];
    }
    else if(number == 4) {
        [[NSUserDefaults standardUserDefaults]setBool:isApproved forKey:@"Bonus4"];
    }
    else if(number == 5) {
        [[NSUserDefaults standardUserDefaults]setBool:isApproved forKey:@"Bonus5"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(BOOL)getBonus:(int)BonusNumber {
    
    NSString *temp = [NSString stringWithFormat:@"Bonus%i",BonusNumber];
    return [[NSUserDefaults standardUserDefaults]boolForKey:temp];
    
}
-(void)addMoney:(long)money {
    
    long tempMoney = [self getMoney];
    tempMoney += money;
    [[NSUserDefaults standardUserDefaults]setInteger:tempMoney forKey:@"Money"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
-(void)removeMoney:(long)money {
    
    long tempMoney = [self getMoney];
    tempMoney -= money;
    [[NSUserDefaults standardUserDefaults]setInteger:tempMoney forKey:@"Money"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(long)getMoney {
    
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"Money"];
    
}
-(void)setSound: (BOOL)enableSound {
    [[NSUserDefaults standardUserDefaults]setBool:enableSound forKey:@"Sound"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(BOOL)getSound {
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"Sound"];
}
-(void)addStars:(long)stars{
    long tempStars = [self getStars];
    tempStars += stars;
    [[NSUserDefaults standardUserDefaults]setInteger:tempStars forKey:@"Stars"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(long)getStars {
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"Stars"];
}
-(void)addHints: (long)numberOfHints_ {
    long tempHints = [self getHints];
    tempHints += numberOfHints_;
    [[NSUserDefaults standardUserDefaults]setInteger:tempHints forKey:@"Hints"];
    [[NSUserDefaults standardUserDefaults]synchronize];

}
-(void)removeHints: (long)numberOfHints_ {
    long tempHints = [self getHints];
    tempHints -= numberOfHints_;
    [[NSUserDefaults standardUserDefaults]setInteger:tempHints forKey:@"Hints"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(long)getHints {
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"Hints"];
}
@end









