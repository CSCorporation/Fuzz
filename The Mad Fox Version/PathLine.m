//
//  PathLine.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/16/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "PathLine.h"

@implementation PathLine
@synthesize startPoint,endPoint;
-(id)initWithPoints:(CGPoint)startPointArg endPoint:(CGPoint)endPointArg{
    if(self=[super init]){
        self.startPoint = startPointArg;
        self.endPoint = endPointArg;
    }
    return self;
}
@end
