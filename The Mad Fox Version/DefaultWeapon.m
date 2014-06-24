//
//  DefaultWeapon.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/23/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "DefaultWeapon.h"
#import "Edge.h"
#import "Graph.h"
@implementation DefaultWeapon
-(int)cutEdge:(Edge *)edge{
    Graph *graph = [self graph];
    return [graph removeEdge:edge];
}
@end
