//
//  CutAdjacentWeapon.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/22/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weapon.h"
@interface CutAdjacentWeapon : Weapon
{
    NSMutableArray *_adjacentIndices;
}
@property(nonatomic,retain) NSMutableArray *adjacentIndices;
@end
