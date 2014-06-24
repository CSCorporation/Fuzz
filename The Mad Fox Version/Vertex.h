//
//  Vertex.h
//  Graph
//
//  Created by Aleksandar Angelov on 11/8/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Edge;

@interface Vertex : NSObject <NSCopying>
{
    int _depth;
    NSMutableArray *_adjacencyList;
}
-(id)initWithIndex:(NSString*)index_;
@property(nonatomic,assign) NSString* keyIndex;

@property(nonatomic,assign) bool visited;
@property(nonatomic,assign) bool isChicken;
@property(nonatomic,assign) bool isFox;
@property(nonatomic,assign) bool isFakeChicken;
@property(nonatomic,assign) bool hintStuck;

@property(nonatomic,assign) int depth;
@property(nonatomic,assign) int distance;
@property(nonatomic,assign) int finalDistance;
@property(nonatomic,assign) int noOfAdjacentChickens;
@property(nonatomic,assign) int hintNoFreezedTurns;

@property(nonatomic,retain) NSMutableArray* adjacencyList;

@property(nonatomic,retain) Vertex *parent;

-(void)visit:(Vertex*)origin;
-(bool)containsNeighbourVertex:(Vertex*)neighbourVertex;
@end
