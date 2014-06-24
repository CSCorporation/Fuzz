//
//  HintWeapon.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/2/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "HintWeapon.h"

@implementation HintWeapon
@synthesize weapon,cordX,cordY,edgeIndex;
-(id)initWithWeapon:(NSString *)weaponArg cordX:(int)cordXArg cordY:(int)cordYArg{
    if(self = [super init]){
        self.weapon = weaponArg;
        self.cordX = cordXArg;
        self.cordY = cordYArg;
        self.edgeIndex = -1;
    }
    return self;
}
-(id)initWithWeapon:(NSString *)weaponArg edgeIndex:(int)edgeIndexArg{
    if(self = [super init]){
        self.weapon = weaponArg;
        self.cordX = -1;
        self.cordY = -1;
        self.edgeIndex = edgeIndexArg;
    }
    return self;
}

@end
