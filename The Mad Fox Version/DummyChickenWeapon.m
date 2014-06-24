//
//  DummyChickenWeapon.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/22/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "DummyChickenWeapon.h"
#import "Vertex.h"
#import "Graph.h"
#import "Chicken.h"
#import "PointUtils.h"
#import "Level.h"
@implementation DummyChickenWeapon
@synthesize level=_level;
-(id)initWithStockNumber:(int)stockNumberArg{
    if(self = [super initWithStockNumber:stockNumberArg]){
        [self setStockNumber:stockNumberArg];
    }
    return self;
}
-(bool)weaponAction:(Vertex *)vertex{
    if([vertex isChicken] || [vertex isFox] || [self stockNumber] == 0)
        return false;
    [vertex setIsFakeChicken:true];
    Graph *graph = [self graph];
    NSArray *chickenList = [[_level chickenDictionary] allValues];
    CGPoint chickenPoint = [[PointUtils sharedInstance]positionForKey:[vertex keyIndex]];
    Chicken *chicken = [[Chicken alloc]initWithImageFilename:@"fake_bird.png" atPoint:chickenPoint keyIndex:[NSString stringWithFormat:@"chickenKeyIndex%d",(int)[chickenList count]]];
    [chicken setIsDummyChicken:true];
    [[graph chickenVerticesList]addObject:vertex];
    [[_level chickenDictionary]setObject:chicken forKey:[vertex keyIndex]];
    [self setStockNumber:[self stockNumber]-1];
    return true;
}
@end
