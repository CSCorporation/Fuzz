//
//  CutAdjacentWeapon.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/22/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "CutAdjacentWeapon.h"
#import "Graph.h"
#import "Vertex.h"
#import "Edge.h"
@implementation CutAdjacentWeapon
@synthesize adjacentIndices=_adjacentIndices;
-(id)initWithStockNumber:(int)stockNumberArg{
    if(self = [super initWithStockNumber:stockNumberArg]){
        NSMutableArray *tempAdjacentIndices = [[NSMutableArray alloc]init];
        [self setAdjacentIndices:tempAdjacentIndices];
        
        [self setStockNumber:stockNumberArg];
    }
    return self;
}
-(bool)weaponAction:(Vertex *)vertex{
    if([self graph] == nil)
        @throw [NSException exceptionWithName:@"GraphException" reason:@"Graph not initialized!" userInfo:nil];
    if([vertex isChicken] || [vertex isFakeChicken] || [vertex isFox] || [self stockNumber] == 0)
        return false;
    
    if([vertex adjacencyList] == 0)
        return false;
    Graph *graph = [self graph];
    NSMutableArray *vertexAdjacentCopy = [[vertex adjacencyList]copyWithZone:nil];
    for (Edge __strong *edge in vertexAdjacentCopy) {
        if(![[graph edges] containsObject:edge])
            edge = [edge mirrorEdge];
        int index = [graph removeEdge:edge];
        [_adjacentIndices addObject:[NSNumber numberWithInt:index]];
    }
    
    [self setStockNumber:[self stockNumber]-1];
    return true;
    
}

@end
