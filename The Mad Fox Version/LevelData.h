//
//  LevelData.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/1/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LevelData : NSObject
@property (nonatomic,assign) int noOfCutAdjacents;
@property (nonatomic,assign) int noOfFakeChickens;
@property (nonatomic,assign) int noOfFreezes;
@property (nonatomic,retain) NSMutableArray *map;
@property (nonatomic,retain) NSMutableArray *hintList;
@end
