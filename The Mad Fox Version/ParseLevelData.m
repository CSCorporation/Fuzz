//
//  ParseLevelData.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/1/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "ParseLevelData.h"
#import "XMLParserLevelData.h"
@implementation ParseLevelData
@synthesize levelParser=_levelParser;
-(void)readCrosswordXml:(NSString *)filename{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:filename ofType:@"xml"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filepath];
    if (!fileExists) {
        NSLog(@"File does not exist!");
    }
    NSData* data = [NSData dataWithContentsOfFile:filepath];
    [self doParseLevelData:data];
}
- (void) doParseLevelData:(NSData *)data {
    
    // create and init NSXMLParser object
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    
    // create and init our delegate
    XMLParserLevelData *tempXmlParser = [[XMLParserLevelData alloc]init];
    [self setLevelParser:tempXmlParser];
   
    
    [nsXmlParser setDelegate:_levelParser];

    BOOL success = [nsXmlParser parse];
    
    if (!success) {
        NSLog(@"Error parsing document!");
    }
   
    
}

@end
