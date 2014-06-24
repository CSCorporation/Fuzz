//
//  Chicken.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/21/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "Chicken.h"

@implementation Chicken
@synthesize filename,position,keyIndex,isDummyChicken;
-(id)initWithImageFilename:(NSString *)filenameArg atPoint:(CGPoint)positionArg keyIndex:(NSString *)keyIndexArg{
    if(self =[super init]){
        self.filename = filenameArg;
        self.position = positionArg;
        self.keyIndex = keyIndexArg;
        self.isDummyChicken = false;
    }
    return self;
}

@end
