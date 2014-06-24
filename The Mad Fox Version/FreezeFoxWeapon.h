//
//  FreezeFoxWeapon.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/23/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "Weapon.h"

@interface FreezeFoxWeapon : Weapon {
    NSMutableDictionary *_foxesList;
}
@property(nonatomic,retain) NSMutableDictionary *foxesList;
@end
