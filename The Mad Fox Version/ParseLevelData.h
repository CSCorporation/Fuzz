//
//  ParseLevelData.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/1/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMLParserLevelData;
@interface ParseLevelData : NSObject
{
    XMLParserLevelData *_levelParser;
}
-(void)readCrosswordXml:(NSString*)filename;
@property (nonatomic,retain) XMLParserLevelData *levelParser;
@end
