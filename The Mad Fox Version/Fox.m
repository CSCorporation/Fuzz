//
//  Fox.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/11/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "Fox.h"
#import "Level.h"
@implementation Fox
@synthesize keyIndex,position,fileName,level=_level,positions,stuck,noOfTurnsFreezed,rotation,currentlyFrozen;
-(id)initWithImage:(NSString *)fileNameArg atPoint:(CGPoint)beginPoint withRotation:(float)rotationArg keyIndex:(NSString *)keyIndexArg{
    if(self =[super init]){
        [self setKeyIndex:keyIndexArg];
        [self setFileName:fileNameArg];
        [self setPosition:beginPoint];
        [self setRotation:rotationArg];
        [self setStuck:false];
        [self setNoOfTurnsFreezed:0];
        [self setCurrentlyFrozen:false];
    }
    return self;
}
@end
