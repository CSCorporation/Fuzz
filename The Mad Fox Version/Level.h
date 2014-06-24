//
//  LevelsList.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/9/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PointUtils.h"
@class PathLine;
@class Fox;
@class Chicken;
@class Graph;
@class Vertex;
@class Weapon;
@class MoveUtils;
@protocol ModelDelegate;
@interface Level : NSObject
{
    id<ModelDelegate> _observerDelegate;
    
    NSMutableArray *_points;
    NSMutableArray *_positionList;
    NSMutableArray *_mapPointsList;
    NSMutableArray *_weapons;
    
    NSMutableDictionary *_foxesDictionary;
    NSMutableDictionary *_chickenDictionary;
    
    Graph *_graph;
    
    Weapon *_currentWeapon;
    
    MoveUtils *_moveUtilities;
    
}
-(id)initWithFilename:(NSString*)fileName;
-(void)moveFoxes;
-(void)removePathEdge:(PathLine*)pathLine;
-(void)specialWeaponAction:(CGPoint)point;
-(void)generateHints;
-(void)changeWeapon:(int)index;
-(bool)freedom;
@property (nonatomic,retain) id<ModelDelegate> observerDelegate;
@property (nonatomic,retain) NSMutableDictionary *foxesDictionary;
@property (nonatomic,retain) NSMutableDictionary *chickenDictionary;
@property (nonatomic,retain) NSMutableArray *points;
@property (nonatomic,retain) NSMutableArray *mapPointsList;
@property (nonatomic,retain) NSMutableArray *weapons;
@property (nonatomic,retain) Weapon *currentWeapon;
@property (nonatomic,retain) Graph *graph;
@property (nonatomic,assign) int numberOfTurns;
@property (nonatomic,assign) int optimalNoOfTurns;
@end
@protocol ModelDelegate

-(void)moveFoxes;
-(void)showHints:(NSMutableArray*)hintList;
-(void)removePathFromModel:(int)index;
-(void)cutAdjacentPaths:(NSMutableArray*)indices;
-(void)putDummyChicken;
-(void)freezeFox;
@end
