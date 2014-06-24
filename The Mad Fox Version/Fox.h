//
//  Fox.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/11/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Level;
@interface Fox : NSObject
{
    Level *_level;
}
@property (nonatomic,retain) NSString *keyIndex;
@property (nonatomic,assign) CGPoint position;
@property (nonatomic,retain) NSString* fileName;
@property (nonatomic,assign) float rotation;
@property (nonatomic,retain) Level *level;
@property (nonatomic,retain) NSMutableArray *positions;
@property (nonatomic,assign) bool stuck;
@property (nonatomic,assign) int noOfTurnsFreezed;
@property (nonatomic,assign) bool currentlyFrozen;
-(id)initWithImage:(NSString *)fileNameArg atPoint:(CGPoint)beginPoint withRotation:(float)rotationArg keyIndex:(NSString*)keyIndexArg;
@end
