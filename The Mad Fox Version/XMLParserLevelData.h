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
@class HintWeapon;
@interface XMLParserLevelData : NSObject <NSXMLParserDelegate>
{
    LevelData *_levelData;
    
    MapPoint *_mapPoint;
    
    HintWeapon *_hintWeapon;
    
    NSMutableString *_currentElementValue;
    
    CGPoint _mapPointPosition;
    
    NSMutableArray *_map;
    NSMutableArray *_hintList;
}
@property (nonatomic,retain) LevelData *levelData;
@end
