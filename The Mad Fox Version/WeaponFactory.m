//
//  WeaponFactory.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/7/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "WeaponFactory.h"
#import "FreezeFoxWeapon.h"
#import "DummyChickenWeapon.h"
#import "CutAdjacentWeapon.h"
#import "DefaultWeapon.h"
#import "Weapon.h"
@implementation WeaponFactory
+(Weapon*)getWeapon:(NSString *)weaponName stockNumber:(int)stockNumber{
    if([weaponName isEqualToString:@"FreezeWeapon"])
        return [[FreezeFoxWeapon alloc]initWithStockNumber:stockNumber];
    else if([weaponName isEqualToString:@"DummyChickenWeapon"])
        return [[DummyChickenWeapon alloc]initWithStockNumber:stockNumber];
    else if([weaponName isEqualToString:@"CutAdjacentsWeapon"])
        return [[CutAdjacentWeapon alloc]initWithStockNumber:stockNumber];
    else
        return [[DefaultWeapon alloc]initWithStockNumber:stockNumber];
        
}
@end
