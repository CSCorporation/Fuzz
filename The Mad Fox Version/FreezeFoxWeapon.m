//
//  FreezeFoxWeapon.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/23/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "FreezeFoxWeapon.h"
#import "Vertex.h"
#import "Fox.h"
#import "PointUtils.h"
@implementation FreezeFoxWeapon
@synthesize foxesList=_foxesList;
-(id)initWithStockNumber:(int)stockNumberArg{
    if(self = [super initWithStockNumber:stockNumberArg]){
        [self setStockNumber:stockNumberArg];
    }
    return self;
}

-(bool)weaponAction:(Vertex *)vertex{
    if(![vertex isFox] || [self stockNumber] == 0)
        return false;
    Fox *fox = [_foxesList objectForKey:[vertex keyIndex]];
    if([fox noOfTurnsFreezed] > 0)
        return false;
    if(fox == nil)
        @throw [NSException exceptionWithName:@"FoxNullException" reason:@"Fox cannot be null!" userInfo:nil];
    [fox setNoOfTurnsFreezed:2];
    [fox setCurrentlyFrozen:true];
    [self setStockNumber:[self stockNumber]-1];
    return true;
}
@end
