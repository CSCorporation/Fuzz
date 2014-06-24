//
//  Graph.h
//  Graph
//
//  Created by Aleksandar Angelov on 11/8/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Vertex,Edge,PathLine;
@protocol GraphADT <NSObject>
-(void) addEdge:(Vertex*)sourceVertex destinationVertex:(Vertex*)targetVertex;
-(void) addEdge:(Vertex*)sourceVertex destinationVertex:(Vertex*)targetVertex edge:(Edge*)edge;
-(void) addVertex:(Vertex*)vertex;
-(bool) containsEdge:(Vertex*)sourceVertex destinationVertex:(Vertex*)targetVertex;
-(Vertex*)getEdgeSource:(Edge*)edge;
-(Vertex*)getEdgeTarget:(Edge*)edge;
-(Edge*)getEdge:(Vertex*)sourceVertex destinationVertex:(Vertex*)targetVertex;
-(int)getEdgeIndexInList:(Edge*)edgeArg;
-(int)removeEdge:(Edge*)edge;
-(void)removeEdgeWithIndex:(int)edgeIndex;
-(Edge*)removeEdge:(Vertex*)sourceVertex destinationVertex:(Vertex*)targetVertex;
-(bool)removeVertex:(Vertex*)vertex;
-(int)numberOfVertices;
-(void)dfs:(Vertex*)startVertex;
-(void)bfs:(Vertex* )startVertex;
@end
@interface Graph : NSObject <GraphADT>
{
    NSMutableDictionary *_verticesDictionary;
    NSMutableArray *_edges;
    NSMutableArray *_foxVerticesList;
    NSMutableArray *_chickenVerticesList;
    NSMutableArray *_usedEdges;
    NSMutableArray *_hintList;
}
@property (nonatomic,retain) NSMutableDictionary *verticesDictionary;
@property (nonatomic,retain) NSMutableArray *edges;
@property (nonatomic,retain) NSMutableArray *hintList;
@property (nonatomic,retain) NSMutableArray *foxVerticesList;
@property (nonatomic,retain) NSMutableArray *chickenVerticesList;
-initGraphWithMapPointsList:(NSMutableArray*)mapPointsList;
-(NSMutableArray*)pathPoints;
@end
