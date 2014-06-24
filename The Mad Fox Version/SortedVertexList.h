//
//  SortedNodeList.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/22/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Vertex;
@interface SortedVertexList : NSObject
{
    NSMutableArray *_verticesList;
}
-(void)addVertex:(Vertex*)vertex;
-(void)removeVertex:(Vertex*)vertex;
-(Vertex*)getFirstChild;
-(void)removeAll;
-(void)printArray;
-(bool)contains:(Vertex*)vertex;
-(int)count;
@property(nonatomic,retain)NSMutableArray *verticesList;
@end
