//
//  Edge.h
//  Graph
//
//  Created by Aleksandar Angelov on 11/8/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Vertex;
@interface Edge : NSObject
{
    Vertex *_sourceVertex;
    Vertex *_targetVertex;
}
-(id)initWithVertices:(Vertex*)sourceVertexArg targetVertex:(Vertex*)targetVertexArg;
@property (nonatomic,retain) Vertex *sourceVertex;
@property (nonatomic,retain) Vertex *targetVertex;
@property (nonatomic,assign) Edge *mirrorEdge;
@property (nonatomic,assign) bool simRemove;
@property (nonatomic,assign) int weight;
@end
