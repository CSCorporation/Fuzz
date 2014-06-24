//
//  SortedNodeList.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/22/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "SortedVertexList.h"
#import "Vertex.h"
@implementation SortedVertexList
@synthesize verticesList=_verticesList;
-(id)init{
    if(self=[super init]){
        self.verticesList = [NSMutableArray array];
    }
    return self;
}
-(void)addVertex:(Vertex *)vertex{
    [_verticesList addObject:vertex];
    [_verticesList sortUsingComparator:^NSComparisonResult(Vertex *vertexA, Vertex *vertexB) {
        int vertexADist = [vertexA distance];
        int vertexBDist = [vertexB distance];
        if(vertexADist > vertexBDist)
            return 1;
        else if(vertexBDist > vertexADist)
            return -1;
        else
            return 0;
        
    }];
}
-(void)removeVertex:(Vertex *)vertex{
    [_verticesList removeObject:vertex];
}
-(Vertex*)getFirstChild{
    return [_verticesList objectAtIndex:0];
}
-(int)count{
    return (int)[_verticesList count];
}
-(bool)contains:(Vertex *)vertex{
    return [_verticesList isEqual:vertex];
}
-(void)printArray{
    NSString *print = @"";
    for (Vertex *vertex in _verticesList) {
        int distance = [vertex distance];
        print = [print stringByAppendingString:[NSString stringWithFormat:@"%d ",distance]];
    }
    NSLog(@"%@",print);
}
-(void)removeAll{
    [_verticesList removeAllObjects];
}
@end
