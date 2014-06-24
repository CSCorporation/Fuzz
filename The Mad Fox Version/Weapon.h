//
//  Weapon.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/22/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Vertex;
@class Edge;
@class Graph;
@interface Weapon : NSObject

-(id)initWithStockNumber:(int)stockNumberArg;
-(int)cutEdge:(Edge*)edge;
-(bool)weaponAction:(Vertex*)vertex;
@property (nonatomic,assign) int stockNumber;
@property (nonatomic,retain) Graph *graph;
@end
