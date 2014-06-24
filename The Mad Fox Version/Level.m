//
//  LevelsList.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/9/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "Level.h"
#import "Chicken.h"
#import "Graph.h"
#import "PointUtils.h"
#import "Vertex.h"
#import "Weapon.h"
#import "Fox.h"
#import "DefaultWeapon.h"
#import "DummyChickenWeapon.h"
#import "CutAdjacentWeapon.h"
#import "FreezeFoxWeapon.h"
#import "HintWeapon.h"
#import "WeaponFactory.h"
#import "ParseLevelData.h"
#import "XMLParserLevelData.h"
#import "LevelData.h"
#import "PathLine.h"
#import "MapPoint.h"
#import "MoveUtilis.h"
#import "HintUtils.h"
@implementation Level
@synthesize points=_points,mapPointsList=_mapPointsList,chickenDictionary=_chickenDictionary,foxesDictionary=_foxesDictionary,graph = _graph,weapons=_weapons,currentWeapon=_currentWeapon,numberOfTurns,optimalNoOfTurns,observerDelegate=_observerDelegate;
-(id)initWithFilename:(NSString *)fileName{
    if(self = [super init]){
 
        self.foxesDictionary = [NSMutableDictionary dictionary];
        self.chickenDictionary = [NSMutableDictionary dictionary];
        self.points = [NSMutableArray array];
       
        ParseLevelData *parseLevel = [[ParseLevelData alloc]init];
        [parseLevel readCrosswordXml:fileName];
        LevelData *levelData = [[parseLevel levelParser]levelData];
        
        self.mapPointsList = [levelData map];
        for (int i=0; i<[_mapPointsList count]; i++) {
            MapPoint *mapPoint = [_mapPointsList objectAtIndex:i];
            NSString *mapPointIndex = [mapPoint index];
            CGPoint position = [mapPoint position];
            [[PointUtils sharedInstance] addPosition:position forKey:mapPointIndex];
        }
        Graph *tempGraph = [[Graph alloc]initGraphWithMapPointsList:[levelData map]];
        self.graph = tempGraph;
        [self fillPoints];
        tempGraph = nil;
        _moveUtilities = [[MoveUtils alloc]initWithGraph:_graph levelInfo:self];
        HintUtils *hintUtils = [[HintUtils alloc]initWithGraph:_graph levelInfo:self];
        [hintUtils findLevelHints];
        NSMutableArray *tempWeapons = [[NSMutableArray alloc]init];
        DefaultWeapon *defaultWeapon = (DefaultWeapon*)[WeaponFactory getWeapon:@"DefaultWeapon" stockNumber:0];
        DummyChickenWeapon *dummyWeapon = (DummyChickenWeapon*)[WeaponFactory getWeapon:@"DummyChickenWeapon" stockNumber:[levelData noOfFakeChickens]];
        CutAdjacentWeapon *cutAdjacentWeapon = (CutAdjacentWeapon*)[WeaponFactory getWeapon:@"CutAdjacentsWeapon" stockNumber:[levelData noOfCutAdjacents]];
        FreezeFoxWeapon *freezeWeapon = (FreezeFoxWeapon*)[WeaponFactory getWeapon:@"FreezeWeapon" stockNumber:[levelData noOfFreezes]];
        
        [dummyWeapon setGraph:_graph];
        [dummyWeapon setLevel:self];
        [cutAdjacentWeapon setGraph:_graph];
        [freezeWeapon setGraph:_graph];
        [freezeWeapon setFoxesList:_foxesDictionary];
        [tempWeapons addObjectsFromArray:[NSArray arrayWithObjects:defaultWeapon,cutAdjacentWeapon,dummyWeapon,freezeWeapon, nil]];
        self.weapons = tempWeapons;
        [self setCurrentWeapon:[_weapons objectAtIndex:0]];
        //[_graph generateHintSteps];
        [self setOptimalNoOfTurns:4];
    }
    return self;
}
-(void)moveFoxes{
    [_moveUtilities findBestFoxPaths];
    NSArray *foxVerticesList = [_graph foxVerticesList];
    for (int i=0; i<[foxVerticesList count]; i++) {
        Vertex *foxVertex = [foxVerticesList objectAtIndex:i];
        if ([foxVertex isFakeChicken]) {
            [foxVertex setIsChicken:false];
            [foxVertex setIsFakeChicken:false];
            [[_graph chickenVerticesList] removeObject:foxVertex];
            [_chickenDictionary removeObjectForKey:[foxVertex keyIndex]];
        }
    }
    [_observerDelegate moveFoxes];
    
}

-(bool)freedom{
    NSArray *foxesList = [_foxesDictionary allValues];
    for (Fox *fox in foxesList) {
        if(![fox stuck])
            return false;
    }
    return true;
}
-(void)fillPoints{
    
    self.points = [_graph pathPoints];
    NSMutableArray *foxVerticesList = [_graph foxVerticesList];
    for (int i=0;i<[foxVerticesList count];i++){
        Vertex *vertex = [foxVerticesList objectAtIndex:i];
        CGPoint foxPoint = [[PointUtils sharedInstance] positionForKey:[vertex keyIndex]];
        Fox *fox = [[Fox alloc] initWithImage:@"fox.png" atPoint:foxPoint withRotation:180 keyIndex:[NSString stringWithFormat:@"foxKeyIndex%d",i]];
        [fox setLevel:self];
        [_foxesDictionary setObject:fox forKey:[vertex keyIndex]];
    }
    NSMutableArray *chickenVerticesList = [_graph chickenVerticesList];
    for (int i=0; i<[chickenVerticesList count]; i++) {
        Vertex *vertex = [chickenVerticesList objectAtIndex:i];
        CGPoint chickenPoint = [[PointUtils sharedInstance]positionForKey:[vertex keyIndex]];
        Chicken *chicken = [[Chicken alloc]initWithImageFilename:@"chicken.png" atPoint:chickenPoint keyIndex:[NSString stringWithFormat:@"chickenKeyIndex%d",i]];
        [_chickenDictionary setObject:chicken forKey:[vertex keyIndex]];
        chicken = nil;
    }
}
-(void)removePathEdge:(PathLine *)pathLine{
    int edgeIndex = 0;
    for (int i=0;i<[_points count];i++) {
        PathLine *tempPathLine = [_points objectAtIndex:i];
        if([tempPathLine isEqual:pathLine]){
            edgeIndex = i;
            [_points removeObject:pathLine];
            break;
        }
    }
    [self setNumberOfTurns:numberOfTurns+1];
    [_graph removeEdgeWithIndex:edgeIndex];
    [_observerDelegate removePathFromModel:edgeIndex];
    
}
-(void)specialWeaponAction:(CGPoint)point{
    NSString *keyIndex = [[PointUtils sharedInstance]keyForPosition:point];
    Vertex *selectedVertex = [[_graph verticesDictionary]objectForKey:keyIndex];
    bool success = [_currentWeapon weaponAction:selectedVertex];
    if ([_currentWeapon isKindOfClass:[CutAdjacentWeapon class]]) {
        if(success){
            [self setNumberOfTurns:numberOfTurns+1];
            [_observerDelegate cutAdjacentPaths:[[_weapons objectAtIndex:1] adjacentIndices]];
        }
    }
    else if([_currentWeapon isKindOfClass:[DummyChickenWeapon class]]){
        if(success){
            [self setNumberOfTurns:numberOfTurns+1];
            [_observerDelegate putDummyChicken];
        }
    }
    else if([_currentWeapon isKindOfClass:[FreezeFoxWeapon class]]){
        if(success){
            [self setNumberOfTurns:numberOfTurns+1];
            [_observerDelegate freezeFox];
        }
    }
}
-(void)generateHints{
   /* PathLine *path = [_graph hint:[[_graph foxVerticesList]objectAtIndex:0]];
     CGPoint start = [path startPoint];
     CGPoint end = [path endPoint];
     NSLog(@"HINT: CUT FROM %f:%f TO %f:%f",start.x,start.y,end.x,end.y);*/
//    NSMutableArray *hintList = [_graph hintList];
//    for (NSString *hint in hintList) {
//        NSLog(@"%@",hint);
//    }
//    [_observerDelegate showHints:hintList];
}
-(void)changeWeapon:(int)index{
    [self setCurrentWeapon:[_weapons objectAtIndex:index]];
}
@end
