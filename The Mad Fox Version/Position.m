//
//  Position.m
//  The Mad Fox Version
//
//  Created by Aleksandar Angelov on 5/27/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "Position.h"

@implementation Position
@synthesize x,y;
-(id)initWithCordX:(int)x_ cordY:(int)y_{
    if (self = [super init]) {
        self.x = x_;
        self.y = y_;
    }
    return self;
}
@end
