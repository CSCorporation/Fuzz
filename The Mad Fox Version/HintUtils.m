//
//  HintUtils.m
//  The Mad Fox Version
//
//  Created by Aleksandar Angelov on 6/2/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "HintUtils.h"
#import "Graph.h"
#import "Edge.h"
#import "Vertex.h"
#import "Chicken.h"
#import "SortedVertexList.h"
#import "PointUtils.h"
#import "Level.h"
#import "Fox.h"
#import "HintWeapon.h"
@implementation HintUtils
@synthesize hintList=_hintList;
-(id)initWithGraph:(Graph*)graph_ levelInfo:(Level *)level_{
    if (self = [super init]) {
        _verticesDictionary = [graph_ verticesDictionary];
        _edges = [graph_ edges];
        _chickensVerticesList = [[graph_ chickenVerticesList] mutableCopy];
        _foxVerticesList = [[graph_ foxVerticesList] mutableCopy];
        _currentHintSteps = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)findLevelHints{
    if([_chickensVerticesList count] == 0 || [_foxVerticesList count] == 0)
        return;
    [self estimateEdgeValues];
    NSMutableArray *_hintFoxVerticesList = [_foxVerticesList mutableCopy];
    NSMutableArray *edgeListCopy = [_edges mutableCopy];
    NSArray *verticesList = [_verticesDictionary allValues];
    _freezeFoxesList = [_foxVerticesList mutableCopy];
    [edgeListCopy sortUsingComparator:^NSComparisonResult(Edge *edgeA, Edge *edgeB) {
        int edgeAWeight = [edgeA weight];
        int edgeBWeight = [edgeB weight];
        if (edgeAWeight < edgeBWeight){
            return 1;
        }
        else if(edgeBWeight < edgeAWeight){
            return -1;
        }
        else{
            return 0;
        }
    }];
    if([_hintList count] > 0)
        [_hintList removeAllObjects];
    [self findHint:0 foxVerticesList:_hintFoxVerticesList edgeList:edgeListCopy edgeIndex:0 verticesList:verticesList vertexIndex:0 noOfCutAdjacent:0 cutAdjUsed:false noOfFreezes:1 freezeUsed:false noOfFakeChickens:0 fakeChickenUsed:false toolVertex:nil lastEdge:nil weaponEnumeration:(bool)true weaponIndex:0];
    
    if (_hintList == nil) {
        CCLOG(@"No solution");
    }
    for (NSString *hintString in _hintList) {
        CCLOG(@"%@",hintString);
    }
    /* NSLog(@"Final");
     for (HintWeapon *hintWeapon in _hintList) {
     if(hintWeapon.edgeIndex != -1){
     Edge *edge = [_edges objectAtIndex:hintWeapon.edgeIndex];
     NSLog(@"CUT EDGE %d:%d %d:%d",edge.sourceVertex.cordX,edge.sourceVertex.cordY,edge.targetVertex.cordX,edge.targetVertex.cordY);
     }
     else
     NSLog(@"%@ %d:%d",hintWeapon.weapon,hintWeapon.cordX,hintWeapon.cordY);
     
     }*/
}
-(void)findHint:(int)foxVertexIndex foxVerticesList:(NSMutableArray*)foxVerticesList edgeList:(NSMutableArray*)edgeList edgeIndex:(int)edgeIndex verticesList:(NSArray*)verticesList vertexIndex:(int)vertexIndex noOfCutAdjacent:(int)cutAdjNumber cutAdjUsed:(bool)cutAdjUsed noOfFreezes:(int)noOfFreezes freezeUsed:(bool)freezeUsed noOfFakeChickens:(int)noOfFakeChickens fakeChickenUsed:(bool)fakeChickenUsed toolVertex:(Vertex*)toolVertex lastEdge:(Edge*)lastEdge weaponEnumeration:(bool)weaponEnumeration weaponIndex:(int)weaponIndex{
    
    if(foxVerticesList==nil){
        if([_hintList count] > [_currentHintSteps count] || [_hintList count] == 0){
            NSMutableArray *tempHint = [_currentHintSteps mutableCopy];
            [self setHintList:tempHint];
            
        }
        return;
    }
    for (int i=0; i<[foxVerticesList count]; i++) {
        Vertex *vertex = [foxVerticesList objectAtIndex:i];
        if ([vertex isChicken]) {
            return;
        }
    }
    for (int i=0; i<[foxVerticesList count]; i++) {
        Vertex *vertex = [foxVerticesList objectAtIndex:i];
        if ([vertex isFakeChicken]){
            [vertex setIsFakeChicken:false];
            [_chickensVerticesList removeObject:vertex];
        }
    }
    if (edgeIndex == [edgeList count] || vertexIndex == [verticesList count] || foxVertexIndex == [foxVerticesList count] || weaponIndex == 4) {
        return;
    }
    if(weaponEnumeration) {
        [self findHint:0 foxVerticesList:foxVerticesList edgeList:edgeList edgeIndex:edgeIndex verticesList:verticesList vertexIndex:0 noOfCutAdjacent:cutAdjNumber cutAdjUsed:cutAdjUsed=false noOfFreezes:noOfFreezes freezeUsed:freezeUsed=false noOfFakeChickens:noOfFakeChickens fakeChickenUsed:fakeChickenUsed=false toolVertex:toolVertex=nil lastEdge:lastEdge=nil weaponEnumeration:weaponEnumeration weaponIndex:weaponIndex+1];
    }
    if(weaponIndex == 0){
        [self findHint:0 foxVerticesList:foxVerticesList edgeList:edgeList edgeIndex:edgeIndex+1 verticesList:verticesList vertexIndex:0 noOfCutAdjacent:cutAdjNumber cutAdjUsed:cutAdjUsed=false noOfFreezes:noOfFreezes freezeUsed:freezeUsed=false noOfFakeChickens:noOfFakeChickens fakeChickenUsed:fakeChickenUsed=false toolVertex:toolVertex=nil lastEdge:lastEdge=nil weaponEnumeration:false weaponIndex:weaponIndex];
    }
    else if(weaponIndex == 1){
        if (cutAdjNumber == 0) {
            return;
        }
        [self findHint:0 foxVerticesList:foxVerticesList edgeList:edgeList edgeIndex:0 verticesList:verticesList vertexIndex:vertexIndex+1 noOfCutAdjacent:cutAdjNumber cutAdjUsed:cutAdjUsed=false noOfFreezes:noOfFreezes freezeUsed:freezeUsed=false noOfFakeChickens:noOfFakeChickens fakeChickenUsed:fakeChickenUsed=false toolVertex:toolVertex=nil lastEdge:lastEdge=nil weaponEnumeration:false weaponIndex:weaponIndex];
    }
    else if(weaponIndex == 2){
        if (noOfFakeChickens == 0) {
            return;
        }
        [self findHint:0 foxVerticesList:foxVerticesList edgeList:edgeList edgeIndex:0 verticesList:verticesList vertexIndex:vertexIndex+1 noOfCutAdjacent:cutAdjNumber cutAdjUsed:cutAdjUsed=false noOfFreezes:noOfFreezes freezeUsed:freezeUsed=false noOfFakeChickens:noOfFakeChickens fakeChickenUsed:fakeChickenUsed=false toolVertex:toolVertex=nil lastEdge:lastEdge=nil weaponEnumeration:false weaponIndex:weaponIndex];
    }
    else if(weaponIndex == 3){
        if (noOfFreezes == 0) {
            return;
        }
      
        [self findHint:foxVertexIndex+1 foxVerticesList:foxVerticesList edgeList:edgeList edgeIndex:0 verticesList:verticesList vertexIndex:0 noOfCutAdjacent:cutAdjNumber cutAdjUsed:cutAdjUsed=false noOfFreezes:noOfFreezes freezeUsed:freezeUsed=false noOfFakeChickens:noOfFakeChickens fakeChickenUsed:fakeChickenUsed=false toolVertex:toolVertex=nil lastEdge:lastEdge=nil weaponEnumeration:false weaponIndex:weaponIndex];
    }
    if(weaponIndex == 3) {
        Vertex *foxVertex = [foxVerticesList objectAtIndex:foxVertexIndex];
        if ([foxVertex hintNoFreezedTurns]>0) {
            return;
        }
        [_currentHintSteps addObject:[NSString stringWithFormat:@"Freeze fox at %@",[foxVertex keyIndex]]];
        if([_hintList count] <= [_currentHintSteps count] && [_hintList count] != 0){
            [_currentHintSteps removeLastObject];
            return;
        }
        [foxVertex setHintNoFreezedTurns:2];
        NSMutableArray *foxVerticeListCopy = [foxVerticesList mutableCopy];
        NSMutableArray *newFoxVerticesList = [self findBestFoxPaths:foxVerticeListCopy];
        NSMutableArray *edgeListCopy = [edgeList mutableCopy];
        [edgeListCopy sortUsingComparator:^NSComparisonResult(Edge *edgeA, Edge *edgeB) {
            int edgeAWeight = [edgeA weight];
            int edgeBWeight = [edgeB weight];
            if (edgeAWeight < edgeBWeight){
                return 1;
            }
            else if(edgeBWeight < edgeAWeight){
                return -1;
            }
            else{
                return 0;
            }
        }];
        [self findHint:0 foxVerticesList:newFoxVerticesList edgeList:edgeListCopy edgeIndex:0 verticesList:verticesList vertexIndex:0 noOfCutAdjacent:cutAdjNumber cutAdjUsed:cutAdjUsed=false noOfFreezes:noOfFreezes-1 freezeUsed:freezeUsed=true noOfFakeChickens:noOfFakeChickens fakeChickenUsed:fakeChickenUsed=false toolVertex:toolVertex=foxVertex lastEdge:lastEdge=nil weaponEnumeration:true weaponIndex:0];
        
    }
    else if(weaponIndex == 2) {
        Vertex *fakeChickenVertex = [verticesList objectAtIndex:vertexIndex];
        if ([foxVerticesList containsObject:fakeChickenVertex] || [fakeChickenVertex isChicken] || [fakeChickenVertex isFakeChicken]) {
            return;
        }
        [_currentHintSteps addObject:[NSString stringWithFormat:@"Fake chicken at %@",[fakeChickenVertex keyIndex]]];
        if([_hintList count] <= [_currentHintSteps count] && [_hintList count] != 0){
            [_currentHintSteps removeLastObject];
            return;
        }
        [fakeChickenVertex setIsFakeChicken:true];
        [_chickensVerticesList addObject:fakeChickenVertex];
        NSMutableArray *foxVerticeListCopy = [foxVerticesList mutableCopy];
        NSMutableArray *newFoxVerticesList = [self findBestFoxPaths:foxVerticeListCopy];
        NSMutableArray *edgeListCopy = [edgeList mutableCopy];
        [edgeListCopy sortUsingComparator:^NSComparisonResult(Edge *edgeA, Edge *edgeB) {
            int edgeAWeight = [edgeA weight];
            int edgeBWeight = [edgeB weight];
            if (edgeAWeight < edgeBWeight){
                return 1;
            }
            else if(edgeBWeight < edgeAWeight){
                return -1;
            }
            else{
                return 0;
            }
        }];
        NSMutableArray *verticesListCopy = [verticesList mutableCopy];
        [verticesListCopy removeObject:fakeChickenVertex];
        
        [self findHint:0 foxVerticesList:newFoxVerticesList edgeList: edgeListCopy edgeIndex:0 verticesList:verticesListCopy vertexIndex:0 noOfCutAdjacent:cutAdjNumber cutAdjUsed:cutAdjUsed=false noOfFreezes:noOfFreezes freezeUsed:freezeUsed=false noOfFakeChickens:noOfFakeChickens-1 fakeChickenUsed:fakeChickenUsed=true toolVertex:toolVertex=fakeChickenVertex lastEdge:lastEdge=nil weaponEnumeration:true weaponIndex:0];
        
    }
    else if(weaponIndex == 1){
        Vertex *cutAdjVertex = [verticesList objectAtIndex:vertexIndex];
        if ([foxVerticesList containsObject:cutAdjVertex] || [cutAdjVertex isChicken] || [cutAdjVertex isFakeChicken]) {
            return;
        }
        [_currentHintSteps addObject:[NSString stringWithFormat:@"Cut adjacents to %@",[cutAdjVertex keyIndex]]];
        if([_hintList count] <= [_currentHintSteps count] && [_hintList count] != 0){
            [_currentHintSteps removeLastObject];
            return;
        }
        [self simCutAdjacent:cutAdjVertex edgeList:edgeList];
        NSMutableArray *foxVerticeListCopy = [foxVerticesList mutableCopy];
        NSMutableArray *newFoxVerticesList = [self findBestFoxPaths:foxVerticeListCopy];
        NSMutableArray *edgeListCopy = [edgeList mutableCopy];
        for (Edge *edge in [cutAdjVertex adjacencyList]) {
            [edgeListCopy removeObject:edge];
        }
        [edgeListCopy sortUsingComparator:^NSComparisonResult(Edge *edgeA, Edge *edgeB) {
            int edgeAWeight = [edgeA weight];
            int edgeBWeight = [edgeB weight];
            if (edgeAWeight < edgeBWeight){
                return 1;
            }
            else if(edgeBWeight < edgeAWeight){
                return -1;
            }
            else{
                return 0;
            }
        }];
        NSMutableArray *verticesListCopy = [verticesList mutableCopy];
        [verticesListCopy removeObject:cutAdjVertex];
        [self findHint:0 foxVerticesList:newFoxVerticesList edgeList: edgeListCopy edgeIndex:0 verticesList:verticesListCopy vertexIndex:0 noOfCutAdjacent:cutAdjNumber-1 cutAdjUsed:cutAdjUsed=true noOfFreezes:noOfFreezes freezeUsed:freezeUsed=false noOfFakeChickens:noOfFakeChickens fakeChickenUsed:fakeChickenUsed=false toolVertex:toolVertex=cutAdjVertex lastEdge:lastEdge=nil weaponEnumeration:true weaponIndex:0];
        
    }
    else if(weaponIndex == 0){
        Edge *edge = [edgeList objectAtIndex:edgeIndex];
        //HintWeapon *hintWeapon = [[HintWeapon alloc]initWithWeapon:@"DefaultWeapon" edgeIndex:edgeIndex];
        [_currentHintSteps addObject:[NSString stringWithFormat:@"%@ %@",edge.sourceVertex.keyIndex,edge.targetVertex.keyIndex]];
        if (edgeIndex == 0) {
            ;
        }
        if([_hintList count] <= [_currentHintSteps count] && [_hintList count] != 0){
            /*if([foxVertex hintFreezed]){
                [foxVertex setHintFreezed:false];
            }*/
            [_currentHintSteps removeLastObject];
            return;
        }
        [edge setSimRemove:true];
        [[edge mirrorEdge]setSimRemove:true];
        NSMutableArray *foxVerticeListCopy = [foxVerticesList mutableCopy];
        NSMutableArray *newFoxVerticesList = [self findBestFoxPaths:foxVerticeListCopy];
        NSMutableArray *edgeListCopy = [edgeList mutableCopy];
        [edgeListCopy removeObject:edge];
        [edgeListCopy sortUsingComparator:^NSComparisonResult(Edge *edgeA, Edge *edgeB) {
            int edgeAWeight = [edgeA weight];
            int edgeBWeight = [edgeB weight];
            if (edgeAWeight < edgeBWeight){
                return 1;
            }
            else if(edgeBWeight < edgeAWeight){
                return -1;
            }
            else{
                return 0;
            }
        }];
        [self findHint:0 foxVerticesList:newFoxVerticesList edgeList: edgeListCopy edgeIndex:0 verticesList:verticesList vertexIndex:0 noOfCutAdjacent:cutAdjNumber cutAdjUsed:cutAdjUsed=false noOfFreezes:noOfFreezes freezeUsed:freezeUsed=true noOfFakeChickens:noOfFakeChickens fakeChickenUsed:fakeChickenUsed=false toolVertex:toolVertex lastEdge:lastEdge=edge weaponEnumeration:true weaponIndex:0];
    }
    if(lastEdge != nil){
        if(freezeUsed){
            
        }
        [lastEdge setSimRemove:false];
        [[lastEdge mirrorEdge]setSimRemove:false];
        [_currentHintSteps removeLastObject];
        
   
    }
    if(cutAdjUsed){
        [self removeSimCutAdjacent:toolVertex edgeList:edgeList];
        [_currentHintSteps removeLastObject];
        
    }
    if (fakeChickenUsed) {
        if ([toolVertex isFakeChicken]) {
            [toolVertex setIsFakeChicken:false];
            [_chickensVerticesList removeObject:toolVertex];
        }
        [_currentHintSteps removeLastObject];
    }
    if (freezeUsed) {
        [_currentHintSteps removeLastObject];
        [toolVertex setHintNoFreezedTurns:0];
    }
}
-(void)simCutAdjacent:(Vertex*)vertex edgeList:(NSArray*)edgeList{
    for (Edge *edge in [vertex adjacencyList]) {
        if ([edgeList containsObject:edge] || [edgeList containsObject:[edge mirrorEdge]]) {
            [edge setSimRemove:true];
            [[edge mirrorEdge] setSimRemove:true];
        }
    }
}
-(void)removeSimCutAdjacent:(Vertex*)vertex edgeList:(NSArray*)edgeList{
    for (Edge *edge in [vertex adjacencyList]) {
        if ([edgeList containsObject:edge] || [edgeList containsObject:[edge mirrorEdge]]) {
            [edge setSimRemove:false];
            [[edge mirrorEdge]setSimRemove:false];
        }
    }
}
-(NSMutableArray*)findBestFoxPaths:(NSMutableArray*)foxVerticesList_{
    NSMutableArray *foxesNextMovesList = [[NSMutableArray alloc]init];
    NSMutableArray *freezedFoxesList = [[NSMutableArray alloc]init];
    for (int i=0; i<[foxVerticesList_ count];i++){
        Vertex *foxVertex = [foxVerticesList_ objectAtIndex:i];
        NSArray *foxNextMoves = [self shortestVertexPaths:foxVertex foxVerticesList:foxVerticesList_];
        if ([foxVertex hintNoFreezedTurns] == 0) {
            if (foxNextMoves != nil) {
                [foxesNextMovesList addObject:foxNextMoves];
                foxNextMoves = nil;
            }
        }
        else {
            [foxVertex setHintNoFreezedTurns:[foxVertex hintNoFreezedTurns]-1];
            if (foxNextMoves != nil) {
                [freezedFoxesList addObject:foxNextMoves];
            }
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
    }else {
        
    }
    if (bestMovesList == nil &&[freezedFoxesList count]==0) {
        return nil;
    }
    combinationsList = nil;
    bestCombinationList = nil;
    for (int i=0; i<[bestMovesList count]; i++) {
        Vertex *foxVertex = [[bestMovesList objectAtIndex:i] parent];
        Vertex *nextFoxVertex = nil;
        if ([foxVertex hintNoFreezedTurns]>0) {
            nextFoxVertex = foxVertex;
            [foxVertex setHintNoFreezedTurns:foxVertex.hintNoFreezedTurns-1];
        }
        else {
            nextFoxVertex = [_verticesDictionary objectForKey:[[bestMovesList objectAtIndex:i] keyIndex]];
        }
        if ([foxVertex hintStuck]) {
            continue;
        }
        [nextFoxVertex setFinalDistance:[[bestMovesList objectAtIndex:i] finalDistance]];
        int index = (int)[foxVerticesList_ indexOfObject:foxVertex];
        [foxVerticesList_ replaceObjectAtIndex:index withObject:nextFoxVertex];
 
    }
    [foxVerticesList_ sortUsingComparator:^NSComparisonResult(Vertex *vertexA, Vertex *vertexB) {
        int vertexADist = [vertexA finalDistance];
        int vertexBDist = [vertexB finalDistance];
        if(vertexADist > vertexBDist)
            return 1;
        else if(vertexBDist > vertexADist)
            return -1;
        else
            return 0;
    }];
    if ([freezedFoxesList count] > 0) {
        for (NSMutableArray *enumFreezeFoxList in freezedFoxesList) {
            Vertex *foxVertex = [[enumFreezeFoxList objectAtIndex:0] parent];
            if (![foxVerticesList_ containsObject:foxVertex]) {
                [foxVerticesList_ addObject:foxVertex];
            }
            
        }
    }
    freezedFoxesList = nil;
    return foxVerticesList_;
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
                if (distanceWeight == 999) {
                    if (![vertex hintStuck]) {
                        [vertex setHintStuck:true];
                    }
                }
                else {
                    if ([vertex hintStuck]) {
                        [vertex setHintStuck:false];
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
-(NSArray*)shortestVertexPaths:(Vertex *)sourceVertex foxVerticesList:(NSMutableArray*)foxVerticesList_{
    if(sourceVertex == nil)
        return nil;
    
    [self estimateEdgeValues];
    NSArray *vertexAdjacentsList = [sourceVertex adjacencyList];
    if ([vertexAdjacentsList count] == 0) {
        return nil;
    }
    
    NSMutableArray *possibleMovesList = [[NSMutableArray alloc]initWithCapacity:[vertexAdjacentsList count]];
    for (int i=0; i<[vertexAdjacentsList count]; i++) {
        Edge *adjacentEdge = [vertexAdjacentsList objectAtIndex:i];
        Vertex *adjacentVertex = [adjacentEdge targetVertex];
        if ([adjacentEdge simRemove]) {
            Vertex *adjacentCopyVertex = [adjacentVertex copy];
            [adjacentCopyVertex setParent:sourceVertex];
            [adjacentCopyVertex setDistance:999];
            [adjacentCopyVertex setFinalDistance:999];
            [possibleMovesList addObject:adjacentCopyVertex];
            adjacentCopyVertex = nil;
            continue;
        }
        
        SortedVertexList *sortedChickenDistanceList = [[SortedVertexList alloc]init];
        for(int j=0;j<[_chickensVerticesList count];j++){
            NSArray *verticesList = [_verticesDictionary allValues];
            for (Vertex *vertex in verticesList) {
                [vertex setVisited:false];
                [vertex setDistance:999];
                [vertex setParent:nil];
            }
            if ([foxVerticesList_ containsObject:adjacentVertex]) {
                Vertex *adjacentCopyVertex = [adjacentVertex copy];
                [adjacentCopyVertex setParent:sourceVertex];
                [adjacentCopyVertex setFinalDistance:[adjacentCopyVertex distance]];
                [sortedChickenDistanceList addVertex:adjacentCopyVertex];
                adjacentCopyVertex = nil;
                continue;
            }
            [adjacentVertex setDistance:[adjacentEdge weight]];
            [sourceVertex setVisited:true];
            Vertex *targetVertex = [_chickensVerticesList objectAtIndex:j];
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
                    if ([edge simRemove]){
                        continue;
                    }
                    Vertex *neighbour = [edge targetVertex];
                    int distance = [sdVertex distance] + [edge weight];
                    if(distance < [neighbour distance] && ![neighbour visited] && ![foxVerticesList_ containsObject:neighbour]){
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
