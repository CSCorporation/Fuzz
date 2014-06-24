//
//  XMLParserLevelData.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/1/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "XMLParserLevelData.h"
#import "LevelData.h"
#import "MapPoint.h"
@implementation XMLParserLevelData
@synthesize levelData=_levelData;
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"LevelData"]){
        LevelData *tempLevelData = [[LevelData alloc]init];
        [self setLevelData:tempLevelData];
        
    }
    else if([elementName isEqualToString:@"Map"]){
        _map = [[NSMutableArray alloc]init];
    }
    else if([elementName isEqualToString:@"MapPoint"]){
        _mapPoint = [[MapPoint alloc]init];
        NSString *index = [attributeDict objectForKey:@"index"];
        bool isChicken = [[attributeDict objectForKey:@"chicken"] boolValue];
        bool isFox = [[attributeDict objectForKey:@"fox"] boolValue];
        [_mapPoint setIndex:index];
        [_mapPoint setChicken:isChicken];
        [_mapPoint setFox:isFox];
        
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!_currentElementValue) {
        _currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else {
        [_currentElementValue appendString:string];
    }
    
}
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    NSString* value = [_currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([elementName isEqualToString:@"LevelData"]) {
        
        _currentElementValue = nil;
        return;
    }
    else if([elementName isEqualToString:@"CutAdjacents"]){
        
        [_levelData setNoOfCutAdjacents:[value intValue]];
        
    }else if([elementName isEqualToString:@"FakeChicken"]){
        
        [_levelData setNoOfFakeChickens:[value intValue]];
        
    }
    else if([elementName isEqualToString:@"FreezeFox"]){
        
        [_levelData setNoOfFreezes:[value intValue]];
        
    }
    else if([elementName isEqualToString:@"Neighbours"]){
        NSMutableArray *neighbours = [[NSMutableArray alloc]initWithCapacity:[value length]];
        NSArray *indices = [value componentsSeparatedByString:@","];
        for(int i=0;i<[indices count];i++){
            [neighbours addObject:indices[i]];
        }
        [_mapPoint setNeighboursList:neighbours];
        neighbours = nil;
        
    }
    else if([elementName isEqualToString:@"Position"]){
        NSArray *position = [value componentsSeparatedByString:@","];
        [_mapPoint setPosition:CGPointMake([position[0] floatValue],[position[1] floatValue])];
    }
    else if([elementName isEqualToString:@"MapPoint"]){
        [_map addObject:_mapPoint];
        _mapPoint = nil;
    }
    else if([elementName isEqualToString:@"Map"]){
        [_levelData setMap:_map];
    }
    
    _currentElementValue = nil;
}

@end
