//
//  Weapon.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/22/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "Weapon.h"
#import "Graph.h"
@implementation Weapon
@synthesize stockNumber,graph;

-(id)initWithStockNumber:(int)stockNumberArg{
    if(self = [super init]){
        self.stockNumber = stockNumber;
    }
    return self;
}
-(int)cutEdge:(Edge *)edge{
    return 0;
}
-(bool)weaponAction:(Vertex *)vertex{
    return false;
}

@end
