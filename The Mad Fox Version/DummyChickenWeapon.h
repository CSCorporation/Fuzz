//
//  DummyChickenWeapon.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/22/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weapon.h"
@class Level;
@interface DummyChickenWeapon : Weapon{
    Level *_level;
}
@property (nonatomic,retain) Level *level;
@end
