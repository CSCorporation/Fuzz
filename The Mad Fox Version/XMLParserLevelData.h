//
//  XMLParserLevelData.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/1/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LevelData;
@class MapPoint;
@interface XMLParserLevelData : NSObject <NSXMLParserDelegate>
{
    LevelData *_levelData;
    NSMutableArray *_map;
    MapPoint *_mapPoint;
    NSMutableString *_currentElementValue;
    CGPoint _mapPointPosition;
}
@property (nonatomic,retain) LevelData *levelData;
@end
