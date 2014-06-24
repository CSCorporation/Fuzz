//
//  MoveUtilities.h
//  The Mad Fox Version
//
//  Created by Aleksandar Angelov on 5/28/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Graph;
@class Level;
@interface MoveUtils : NSObject
{
    NSMutableDictionary *_verticesDictionary;
    NSMutableDictionary *_chickenDictionary;
    NSMutableDictionary *_foxesDictionary;
    
    NSMutableArray *_edges;
    NSMutableArray *_foxVerticesList;
    NSMutableArray *_chickenVerticesList;
    
}
-(id)initWithGraph:(Graph*)graph_ levelInfo:(Level*)level_;
-(void)findBestFoxPaths;
@end
