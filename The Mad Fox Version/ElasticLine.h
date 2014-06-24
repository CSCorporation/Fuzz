//
//  ElasticLine.h
//  cocos2d3test
//
//  Created by Aleksandar Angelov on 6/18/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@interface ElasticLine : CCNode
{
    NSMutableArray *_segmentList;
}
+ (instancetype)ropeWithSegments:(int)segments objectA:(CCNode *)objectA posA:(CGPoint)posA objectB:(CCNode *)objectB posB:(CGPoint)posB;
- (instancetype)initWithSegments:(int)segments objectA:(CCNode *)objectA posA:(CGPoint)posA objectB:(CCNode *)objectB posB:(CGPoint)posB;
@property(nonatomic,retain) NSMutableArray *segmentList;
@end
