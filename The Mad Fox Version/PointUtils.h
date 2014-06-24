//
//  PointUtils.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 11/10/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"
@interface PointUtils : NSObject{
    NSMutableDictionary *_pointsDictionary;
    CGSize _winSize;
}
+(PointUtils*)sharedInstance;
-(void)addPosition:(CGPoint)point forKey:(NSString*)key;
-(CGPoint)positionForKey:(NSString*)key;
-(NSString*)keyForPosition:(CGPoint)point;
-(void)removeAllPositions;
@property(nonatomic,retain) NSMutableDictionary *pointsDictionary;
@property(nonatomic,assign) CGSize winSize;
@end
