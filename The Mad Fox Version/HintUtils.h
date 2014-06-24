//
//  HintUtils.h
//  The Mad Fox Version
//
//  Created by Aleksandar Angelov on 6/2/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Graph;
@class Level;
@interface HintUtils : NSObject
{
    NSMutableDictionary *_verticesDictionary;
    NSMutableArray *_edges;
    NSMutableArray *_chickensVerticesList;
    NSMutableArray *_foxVerticesList;
    NSMutableArray *_frozenFoxesList;;
    NSMutableArray *_hintList;
    NSMutableArray *_usedEdges;
    NSMutableArray *_currentHintSteps;
}
@property(nonatomic,retain)NSMutableArray *hintList;
-(id)initWithGraph:(Graph*)graph_ levelInfo:(Level*)level_;
-(void)findLevelHints;
@end
