//
//  LineView.m
//  TheMadFox-LevelBuilder
//
//  Created by Aleksandar Angelov on 3/26/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

#import "LineView.h"
#import "CCDrawingPrimitives.h"
#define IS_IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@implementation LineView
@synthesize fromPoint=_fromPoint,toPoint=_toPoint;
-(id)initWithPoints: (CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    if(self = [super init]){
        _fromPoint = startPoint;
        _toPoint = endPoint;
        
        float dist = ccpDistance(startPoint, endPoint);
        CCSprite *line = [CCSprite spriteWithImageNamed:@"line.png"];
        [line setAnchorPoint:ccp(0.0f, 0.5f)];
        [line setPosition:startPoint];
        [line setScaleX:dist / line.boundingBox.size.width];
        CGPoint firstVector = ccpSub(endPoint, startPoint);
        CGFloat firstRotateAngle = -ccpToAngle(firstVector);
        CGFloat previousTouch = CC_RADIANS_TO_DEGREES(firstRotateAngle);
        
        [line setRotation:previousTouch];
        [self addChild:line];

    }
	return self;
    
}
@end
