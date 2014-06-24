//
//  MoveUtilities.m
//  The Mad Fox Version
//
//  Created by Aleksandar Angelov on 5/28/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "MoveUtilis.h"
#import "Graph.h"
#import "Edge.h"
#import "Vertex.h"
#import "Chicken.h"
#import "SortedVertexList.h"
#import "PointUtils.h"
#import "Level.h"
#import "Fox.h"
@implementation MoveUtils

-(id)initWithGraph:(Graph*)graph_ levelInfo:(Level *)level_{
    if (self = [super init]) {
        _verticesDictionary = [graph_ verticesDictionary];
        _edges = [graph_ edges];
        _chickenDictionary = [level_ chickenDictionary];
        _foxesDictionary = [level_ foxesDictionary];
        _foxVerticesList = [graph_ foxVerticesList];
        _chickenVerticesList = [graph_ chickenVerticesList];
    }
    return self;
}
#pragma mark Fox Movement
-(void)findBestFoxPaths{
    
    NSMutableArray *foxesNextMovesList = [[NSMutableArray alloc]init];
    for (int i=0; i<[_foxVerticesList count];i++){
        Vertex *foxVertex = [_foxVerticesList objectAtIndex:i];
        Fox *fox = [_foxesDictionary objectForKey:foxVertex.keyIndex];
        if([fox noOfTurnsFreezed] == 0) {
            NSArray *foxNextMoves = [self shortestVertexPaths:foxVertex];
            if (foxNextMoves != nil) {
                if ([fox stuck]) {
                    [fox setStuck:false];
                }
                [foxesNextMovesList addObject:foxNextMoves];
                foxNextMoves = nil;
            }
            else {
                [fox setStuck:true];
            }
        }
        else {
            [fox setNoOfTurnsFreezed:[fox noOfTurnsFreezed]-1];
        }
        
    }
    NSMutableArray *combinationsList = [[NSMutableArray alloc]init];
    NSMutableArray *bestCombinationList = [[NSMutableArray alloc]init];
    NSArray *bestMovesList = nil;
    if ([foxesNextMovesList count]>0) {
        if ([foxesNextMovesList count]>1) {
            bestMovesList = [self bestMovesCombination:0 possibleMovesSet:foxesNextMovesList combinationsList:combinationsList bestMovesList:bestCombinationList];
        }
        else {
            bestMovesList = [NSArray arrayWithObject:[[foxesNextMovesList objectAtIndex:0] objectAtIndex:0]];
        }
    }
    combinationsList = nil;
    bestCombinationList = nil;
    for (int i=0; i<[bestMovesList count]; i++) {
        Vertex *foxVertex = [[bestMovesList objectAtIndex:i] parent];
        Vertex *nextFoxVertex = [_verticesDictionary objectForKey:[[bestMovesList objectAtIndex:i] keyIndex]];
        Fox *fox = [_foxesDictionary objectForKey:[foxVertex keyIndex]];
        if ([fox stuck]) {
            continue;
        }
        [foxVertex setIsFox:false];
        [nextFoxVertex setIsFox:true];
        CGPoint nextFoxPosition = [[PointUtils sharedInstance] positionForKey:[nextFoxVertex keyIndex]];
        CGPoint currentFoxPosition = [fox position];
        float rotation;
        if(currentFoxPosition.x < nextFoxPosition.x)
            rotation = 0;
        else
            rotation = 180;
        [fox setRotation:rotation];
        [fox setPosition:nextFoxPosition];
        int index = (int)[_foxVerticesList indexOfObject:foxVertex];
        [_foxVerticesList replaceObjectAtIndex:index withObject:nextFoxVertex];
        [_foxesDictionary removeObjectForKey:[foxVertex keyIndex]];
        [_foxesDictionary setObject:fox forKey:[nextFoxVertex keyIndex]];
        
    }
}
-(NSArray*)bestMovesCombination:(int)index possibleMovesSet:(NSArray*)possibleMovesSet combinationsList:(NSMutableArray*)combinationsList bestMovesList:(NSMutableArray*)bestMovesList {
    
    if (index == [possibleMovesSet count]) {
        return combinationsList;
    }
    
    for (int i=0;i<[(NSArray*)possibleMovesSet[index] count];i++) {
        Vertex *vertex = [possibleMovesSet[index] objectAtIndex:i];
        [combinationsList addObject:vertex];
        
        NSArray *currentCombinationList = [self bestMovesCombination:index+1 possibleMovesSet:possibleMovesSet combinationsList:combinationsList bestMovesList:bestMovesList];
        int currentDistanceBestWeight = [[[self totalWeightOfCombination:bestMovesList] objectForKey:@"totalWeight"] intValue];
        NSDictionary *weightDictionary = [self totalWeightOfCombination:currentCombinationList];
        int distanceWeight = [[weightDictionary objectForKey:@"totalWeight"] intValue];
        if ((currentDistanceBestWeight == 0 || currentDistanceBestWeight > distanceWeight) && [currentCombinationList count] == [possibleMovesSet count]) {
            bestMovesList = [currentCombinationList mutableCopy];
            NSArray *weightList = [weightDictionary objectForKey:@"weightList"];
            for (int i=0; i<[weightList count]; i++) {
                int distanceWeight = [[weightList objectAtIndex:i] intValue];
                Vertex *vertex = [_verticesDictionary objectForKey:[[[bestMovesList objectAtIndex:i] parent] keyIndex]];
                Fox *fox = [_foxesDictionary objectForKey:[vertex keyIndex]];
                if (distanceWeight == 999) {
                    if (![fox stuck]) {
                        [fox setStuck:true];
                    }
                }
                else {
                    if ([fox stuck]) {
                        [fox setStuck:false];
                    }
                }
            }
            
            
        }
      
        [combinationsList removeLastObject];
        
    }
    return bestMovesList;
}
-(NSDictionary*)totalWeightOfCombination:(NSArray*)combinationList{
    if ([combinationList count]==0) {
        return 0;
    }
    NSMutableDictionary *weightDictionary = [[NSMutableDictionary alloc]init];
    int totalDistanceWeight = 0;
    NSMutableArray *weightList = [[NSMutableArray alloc]init];
    NSMutableArray *usedVertices = [[NSMutableArray alloc]initWithCapacity:combinationList.count];
    for (int i=0; i<[combinationList count];i++) {
        Vertex *vertex = [combinationList objectAtIndex:i];
        int distanceWeight = 0;
        if (![usedVertices containsObject:[vertex keyIndex]]) {
            [usedVertices addObject:[vertex keyIndex]];
            distanceWeight = [vertex finalDistance];
        }
        else {
            distanceWeight = 999;
        }
        [weightList addObject:[NSNumber numberWithInt:distanceWeight]];
        totalDistanceWeight += distanceWeight;
    }
    [weightDictionary setObject:[NSNumber numberWithInt:totalDistanceWeight] forKey:@"totalWeight"];
    [weightDictionary setObject:weightList forKey:@"weightList"];
    return weightDictionary;
}
-(NSArray*)shortestVertexPaths:(Vertex *)sourceVertex{
    if(sourceVertex == nil)
        return nil;
    
    [self estimateEdgeValues];
    NSArray *vertexAdjacentsList = [sourceVertex adjacencyList];
    if ([vertexAdjacentsList count] == 0) {
        return nil;
    }
    NSArray *chickensList = [_chickenDictionary allValues];
    NSMutableArray *possibleMovesList = [[NSMutableArray alloc]initWithCapacity:[vertexAdjacentsList count]];
    for (int i=0; i<[vertexAdjacentsList count]; i++) {
        Edge *adjacentEdge = [vertexAdjacentsList objectAtIndex:i];
        Vertex *adjacentVertex = [adjacentEdge targetVertex];
        SortedVertexList *sortedChickenDistanceList = [[SortedVertexList alloc]init];
        for(int j=0;j<[chickensList count];j++){
            NSArray *verticesList = [_verticesDictionary allValues];
            for (Vertex *vertex in verticesList) {
                [vertex setVisited:false];
                [vertex setDistance:999];
                [vertex setParent:nil];
            }
            if ([adjacentVertex isFox]) {
                Vertex *adjacentCopyVertex = [adjacentVertex copy];
                [adjacentCopyVertex setParent:sourceVertex];
                [adjacentCopyVertex setFinalDistance:[adjacentCopyVertex distance]];
                [sortedChickenDistanceList addVertex:adjacentCopyVertex];
                adjacentCopyVertex = nil;
                continue;
            }
            [adjacentVertex setDistance:[adjacentEdge weight]];
            [sourceVertex setVisited:true];
            NSString *keyIndex = [[PointUtils sharedInstance]keyForPosition:[(Chicken*)[chickensList objectAtIndex:j] position]];
            Vertex *targetVertex = [_verticesDictionary objectForKey:keyIndex];
            SortedVertexList *sortedList = [[SortedVertexList alloc]init];
            [sourceVertex setDistance:0];
            [sortedList addVertex:adjacentVertex];
            while([sortedList count] > 0){
                Vertex *sdVertex = [sortedList getFirstChild];
                if([sdVertex isEqual:targetVertex]){
                    break;
                    
                }
                [sortedList removeVertex:sdVertex];
                [sdVertex setVisited:true];
                for (Edge *edge in [sdVertex adjacencyList]) {
                    Vertex *neighbour = [edge targetVertex];
                    int distance = [sdVertex distance] + [edge weight];
                    if(distance < [neighbour distance] && ![neighbour visited] && (![neighbour isFox])){
                        if((![neighbour isChicken]&&![neighbour isFakeChicken]) || [neighbour isEqual:targetVertex]){
                            [neighbour setDistance:distance];
                            [neighbour setParent:sdVertex];
                            [sortedList addVertex:neighbour];
                        }
                    }
                }
            }
            sortedList = nil;
            Vertex *adjacentCopyVertex = [adjacentVertex copy];
            [adjacentCopyVertex setParent:sourceVertex];
            [adjacentCopyVertex setDistance:[targetVertex distance]];
            [adjacentCopyVertex setFinalDistance:[targetVertex distance]];
            [sortedChickenDistanceList addVertex:adjacentCopyVertex];
            adjacentCopyVertex = nil;
        }
        [possibleMovesList addObject:[sortedChickenDistanceList getFirstChild]];
        sortedChickenDistanceList = nil;
    }
    if([possibleMovesList count] > 1){
        [possibleMovesList sortUsingComparator:^NSComparisonResult(Vertex *vertexA,Vertex *vertexB){
            int vertexADist = [vertexA finalDistance];
            int vertexBDist = [vertexB finalDistance];
            if(vertexADist > vertexBDist)
                return 1;
            else if(vertexBDist > vertexADist)
                return -1;
            else
                return 0;
        }];
    }
    Vertex *targetVertex = [possibleMovesList objectAtIndex:0];
    if([targetVertex finalDistance] == 999){
        possibleMovesList = nil;
        return nil;
    }
    return possibleMovesList;
}
#pragma mark Helper Methods
-(void)estimateAdjacentChickens{
    NSArray *verticesList = [_verticesDictionary allValues];
    for (Vertex *vertex in verticesList) {
        [vertex setNoOfAdjacentChickens:0];
        for(Edge *edge in [vertex adjacencyList]){
            if(![edge simRemove]){
                if([[edge targetVertex] isChicken] || [[edge targetVertex] isFakeChicken])
                    [vertex setNoOfAdjacentChickens:[vertex noOfAdjacentChickens]+1];
            }
        }
    }
}
-(void)estimateEdgeValues{
    [self estimateAdjacentChickens];
    for (Edge *edge in _edges) {
        Vertex *targetVertex = [edge targetVertex];
        Vertex *sourceVertex = [edge sourceVertex];
        int sourceAdjCount = (int)[[targetVertex adjacencyList]count];
        int targetAdjCount = (int)[[sourceVertex adjacencyList]count];
        for (Edge *e in [targetVertex adjacencyList]) {
            if([e simRemove])
                sourceAdjCount--;
        }
        for (Edge *e in [sourceVertex adjacencyList]) {
            if([e simRemove])
                targetAdjCount--;
        }
        int weight = 20;
        int mirrowWeight = 20;
        if(sourceAdjCount > 2)
            weight -= sourceAdjCount;
        if(targetAdjCount > 2)
            mirrowWeight -= targetAdjCount;
        if([targetVertex isChicken] || [sourceVertex isChicken]){
            weight = 1;
            mirrowWeight = 1;
        }
        else if ([targetVertex isFakeChicken] || [sourceVertex isFakeChicken]){
            weight = 2;
            mirrowWeight = 2;
        }
        else if([targetVertex noOfAdjacentChickens] > 1 || [sourceVertex noOfAdjacentChickens] > 1){
            weight = 3;
            mirrowWeight = 3;
        }
        [edge setWeight:weight];
        [[edge mirrorEdge] setWeight:mirrowWeight];
    }
}
@end
