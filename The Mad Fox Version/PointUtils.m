//
//  PointUtils.m
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/10/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "PointUtils.h"
#import "cocos2d.h"
#import "Constants.h"
@implementation PointUtils
@synthesize pointsDictionary=_pointsDictionary,winSize=_winSize;
static PointUtils *_shared = NULL;
 
+(PointUtils*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
        [_shared setPointsDictionary:[NSMutableDictionary dictionary]];
        [_shared setWinSize:[[CCDirector sharedDirector] viewSize]];
    });
    return _shared;
}
-(void)addPosition:(CGPoint)point forKey:(NSString*)key{
    point = [self getActualPoint:point];
    Position *position = [[Position alloc]initWithCordX:point.x cordY:point.y];
    [_pointsDictionary setObject:position forKey:key];
    position = nil;
}
-(CGPoint)positionForKey:(NSString *)key{
    Position *position = [_pointsDictionary objectForKey:key];
    CGPoint point = ccp(position.x,position.y);
    return point;
}
-(NSString*)keyForPosition:(CGPoint)point{
    Position *position = [self getPositionForPoint:point];
    NSArray *keys = [_pointsDictionary allKeysForObject:position];
    return keys[0];
}
-(void)removeAllPositions{
    [_pointsDictionary removeAllObjects];
}
-(CGPoint)getActualPoint:(CGPoint)point{
    float pointXRatio = point.x/1024;
    float pointYRatio = point.y/640;
    point = ccp(_winSize.width*pointXRatio, _winSize.height*pointYRatio);
    return point;
}
-(Position*)getPositionForPoint:(CGPoint)point{
    NSArray *positionsList = [_pointsDictionary allValues];
    for (Position *position in positionsList) {
        if (position.x == point.x && position.y == point.y) {
            return position;
        }
    }
    return nil;
}
@end
