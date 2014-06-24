//
//  Vertex.m
//  Graph
//
//  Created by Aleksandar Angelov on 11/8/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "Vertex.h"
#import "Edge.h"
@implementation Vertex
@synthesize visited,depth=_depth,adjacencyList=_adjacencyList,parent,keyIndex,isChicken,distance,finalDistance,isFox,noOfAdjacentChickens,isFakeChicken,hintNoFreezedTurns,hintStuck;
-(id)initWithIndex:(NSString*)index_{
    if(self = [super init]){
        self.keyIndex = index_;
        self.visited = false;
        self.isChicken = false;
        self.isFox = false;
        self.isFakeChicken = false;
        self.noOfAdjacentChickens = 0;
        self.distance = 0;
        self.finalDistance = 0;
        self.hintNoFreezedTurns = 0;
        self.hintStuck = false;
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        self.adjacencyList = tempArray;
        
    }
    return self;
}
-(void)visit:(Vertex *)origin{
    NSLog(@"Value : %@ ,,, ",keyIndex);
    [self setParent:origin];
    if(origin == nil){
        _depth = 0;
    }
    else{
        _depth += origin.depth + 1;
    }
}
-(bool)containsNeighbourVertex:(Vertex *)neighbourVertex{
    NSArray *adjacencyList = [self adjacencyList];
    if ([self adjacencyList].count == 0) {
        return false;
    }
    for (int i=0; i<[adjacencyList count]; i++) {
        if ([adjacencyList[i] targetVertex] == neighbourVertex) {
            return true;
        }
    }
    return false;
}
-(id)copyWithZone:(NSZone *)zone{
    Vertex *vertexCopy = [[Vertex allocWithZone: zone] initWithIndex:self.keyIndex];
    [vertexCopy setVisited:[self visited]];
    [vertexCopy setDepth:[self depth]];
    [vertexCopy setIsChicken:[self isChicken]];
    [vertexCopy setIsFox:[self isFox]];
    [vertexCopy setDistance:[self distance]];
    [vertexCopy setFinalDistance:[self finalDistance]];
    [vertexCopy setParent:[self parent]];
    [vertexCopy setAdjacencyList:[self adjacencyList]];
    [vertexCopy setNoOfAdjacentChickens:[self noOfAdjacentChickens]];
    return vertexCopy;
}

@end
