//
//  Graph.m
//  Graph
//
//  Created by Aleksandar Angelov on 11/8/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "Graph.h"
#import "Vertex.h"
#import "Edge.h"
#import "Queue.h"
#import "PathLine.h"
#import "cocos2d.h"
#import "PointUtils.h"
#import "Chicken.h"
#import "SortedVertexList.h"
#import "HintWeapon.h"
#import "MapPoint.h"
@implementation Graph
@synthesize verticesDictionary=_verticesDictionary,edges=_edges,foxVerticesList=_foxVerticesList,chickenVerticesList=_chickenVerticesList,hintList=_hintList;
-(id)initGraphWithMapPointsList:(NSMutableArray *)mapPointsList{
    if(self = [super init]){
        self.edges = [NSMutableArray array];
        self.foxVerticesList = [NSMutableArray array];
        self.chickenVerticesList = [NSMutableArray array];
        NSMutableDictionary *tempVerticesList = [[NSMutableDictionary alloc]init];
        for (int i=0; i<[mapPointsList count]; i++) {
            MapPoint *mapPoint = [mapPointsList objectAtIndex:i];
            NSString *mapPointIndex = [mapPoint index];
            Vertex *vertex = [[Vertex alloc] initWithIndex:mapPointIndex];
            if ([mapPoint chicken]) {
                [vertex setIsChicken:true];
                [_chickenVerticesList addObject:vertex];
            }
            else if([mapPoint fox]){
                [vertex setIsFox:true];
                [_foxVerticesList addObject:vertex];
            }
            [tempVerticesList setObject:vertex forKey:[vertex keyIndex]];
        }
        self.verticesDictionary = tempVerticesList;
        tempVerticesList = nil;
        
        for(int i=0;i<[mapPointsList count];i++){
            MapPoint *mapPoint = [mapPointsList objectAtIndex:i];
            Vertex *sourceVertex = [_verticesDictionary objectForKey:[mapPoint index]];
            NSArray *neighboursList = [mapPoint neighboursList];
            for (NSString *neighbourIndex in neighboursList) {
                
                Vertex *targetVertex = [_verticesDictionary objectForKey:neighbourIndex];
                
                if ([sourceVertex containsNeighbourVertex:targetVertex] && [targetVertex containsNeighbourVertex:sourceVertex]) {
                    continue;
                }
                [self addEdge:sourceVertex destinationVertex:targetVertex];
            }
        }
    }
    return self;
}
-(void) addEdge:(Vertex *)sourceVertex destinationVertex:(Vertex *)targetVertex{
    if(![_verticesDictionary objectForKey:[sourceVertex keyIndex]])
        @throw ([NSException exceptionWithName:@"VertexNotFoundException" reason:@"Vertex not in graph" userInfo:nil]);
    Edge *edge1 = [[Edge alloc] initWithVertices:sourceVertex targetVertex:targetVertex];
    Edge *edge2 = [[Edge alloc] initWithVertices:targetVertex targetVertex:sourceVertex];
    [edge1 setMirrorEdge:edge2];
    [edge2 setMirrorEdge:edge1];
    [[sourceVertex adjacencyList] addObject:edge1];
    [[targetVertex adjacencyList] addObject:edge2];
    if(![_edges containsObject:edge1])
        [_edges addObject:edge1];
    if([sourceVertex noOfAdjacentChickens] >= 1)
        [sourceVertex setNoOfAdjacentChickens:[sourceVertex noOfAdjacentChickens]-1];
    if([targetVertex noOfAdjacentChickens] >= 1)
        [targetVertex setNoOfAdjacentChickens:[targetVertex noOfAdjacentChickens]-1];
    edge1 = nil;
    edge2 = nil;
}
-(void) addEdge:(Vertex *)sourceVertex destinationVertex:(Vertex *)targetVertex edge:(Edge *)edge{
    if(![_verticesDictionary objectForKey:[sourceVertex keyIndex]])
        @throw ([NSException exceptionWithName:@"VertexNotFoundException" reason:@"Vertex not in graph" userInfo:nil]);
    [[sourceVertex adjacencyList] addObject:edge];
    [[targetVertex adjacencyList] addObject:edge];
    
}
-(void) addVertex:(Vertex *)vertex{
    [_verticesDictionary setObject:vertex forKey:[vertex keyIndex]];
}
-(bool)removeVertex:(Vertex *)vertex{
    if(![_verticesDictionary objectForKey:[vertex keyIndex]])
        return false;
    [_verticesDictionary removeObjectForKey:[vertex keyIndex]];
    return true;
}
-(bool)containsEdge:(Vertex *)sourceVertex destinationVertex:(Vertex *)targetVertex{
    for(Edge *edge in [sourceVertex adjacencyList]){
        if([[edge targetVertex] isEqual:targetVertex])
            return true;
    }
    return false;
}
-(Vertex *)getEdgeSource:(Edge *)edge{
    return [edge sourceVertex];
}
-(Vertex *)getEdgeTarget:(Edge *)edge{
    return [edge targetVertex];
}
-(int)getEdgeIndexInList:(Edge *)edgeArg{
    for(int i=0;i<[_edges count];i++){
        Edge *edge = [_edges objectAtIndex:i];
        if([edge isEqual:edgeArg])
            return i;
    }
    return -1;
}
-(int)removeEdge:(Edge *)edge{
    Vertex *sourceVertex = [edge sourceVertex];
    Vertex *targetVertex = [edge targetVertex];
    if(![_verticesDictionary objectForKey:[sourceVertex keyIndex]] || ![_verticesDictionary objectForKey:[targetVertex keyIndex]])
        return -1;
    Edge *mirrorEdge = [edge mirrorEdge];
    [[targetVertex adjacencyList] removeObject:mirrorEdge];
    [[sourceVertex adjacencyList] removeObject:edge];
    int index = (int)[_edges indexOfObject:edge];
    [_edges removeObject:edge];
    return index;
}
-(void)removeEdgeWithIndex:(int)edgeIndex{
    Edge *edge = [_edges objectAtIndex:edgeIndex];
    [self removeEdge:edge];
}
-(Edge *)removeEdge:(Vertex *)sourceVertex destinationVertex:(Vertex *)targetVertex{
    return nil;
}
-(Edge*)getEdge:(Vertex *)sourceVertex destinationVertex:(Vertex *)targetVertex{
    for (Edge *edge in [sourceVertex adjacencyList]) {
        if([[edge targetVertex] keyIndex] == [targetVertex keyIndex])
            return edge;
    }
    return nil;
}
-(int)numberOfVertices{
    return (int)[_verticesDictionary count];
}
-(void)dfs:(Vertex *)startVertex{
    startVertex.visited = true;
    for(Edge *edge in [startVertex adjacencyList]){
        Vertex *temp = [edge targetVertex];
        if(![temp visited])
            [self dfs:temp];
    }
}
-(void)bfs:(Vertex *)startVertex{
    NSArray *verticesList = [_verticesDictionary allValues];
    for (Vertex *vertex in verticesList) {
        [vertex setVisited:false];
        [vertex setDepth:0];
    }
    [startVertex visit:nil];
    [startVertex setVisited:true];
    Queue *queue = [[Queue alloc]init];
    [queue enqueue:startVertex];
    while ([queue size] != 0) {
        Vertex *sourceVertex = [queue dequeue];
        for (Edge *edge in [sourceVertex adjacencyList]) {
            Vertex *targetVertex = [edge targetVertex];
            if(![targetVertex visited]){
                [targetVertex visit:sourceVertex];
                [targetVertex setVisited:true];
                
                [queue enqueue:targetVertex];
            }
        }
    }
    queue = nil;
}
-(NSMutableArray*)pathPoints{
    if([_verticesDictionary count]==0)
        @throw ([NSException exceptionWithName:@"NotUsedVerticesException" reason:@"No vertices used!" userInfo:nil]);
    NSMutableArray *points = [[NSMutableArray alloc]init];
    for (Edge *edge in _edges) {
        Vertex *sourceVertex = [edge sourceVertex];
        Vertex *targetVertex = [edge targetVertex];
        CGPoint startPoint = [[PointUtils sharedInstance]positionForKey:[sourceVertex keyIndex]];
        CGPoint endPoint = [[PointUtils sharedInstance]positionForKey:[targetVertex keyIndex]];
        PathLine *pathLine = [[PathLine alloc]initWithPoints:startPoint endPoint:endPoint];
        [points addObject:pathLine];
        pathLine = nil;
        
    }
    return points;
}
@end