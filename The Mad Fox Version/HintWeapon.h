//
//  HintWeapon.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/2/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, WeaponType){
    DEFAULT_WEAPON=0,
    CUT_ADJACENT_WEAPON=1,
    FAKE_CHICKEN_WEAPON=2,
    FREEZE_FOX_WEAPON=3
};

@interface HintWeapon : NSObject
@property (nonatomic,assign) int weaponType;
@property (nonatomic,retain) NSString *fromIndex;
@property (nonatomic,retain) NSString *toIndex;
@property (nonatomic,retain) NSString *targetIndex;

@end
