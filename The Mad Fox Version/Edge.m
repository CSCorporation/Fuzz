//
//  Edge.m
//  Graph
//
//  Created by Aleksandar Angelov on 11/8/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "Edge.h"

@implementation Edge
@synthesize sourceVertex=_sourceVertex,targetVertex=_targetVertex,mirrorEdge,simRemove;
-(id)initWithVertices:(Vertex *)sourceVertexArg targetVertex:(Vertex *)targetVertexArg{
    if(self = [super init]){
        self.sourceVertex = sourceVertexArg;
        self.targetVertex = targetVertexArg;
        self.simRemove = false;
    }
    return self;
}
@end
