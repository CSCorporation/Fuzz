//
//  WeaponFactory.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/7/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Weapon;
@interface WeaponFactory : NSObject
+(Weapon*)getWeapon:(NSString*)weaponName stockNumber:(int)stockNumber;
@end
