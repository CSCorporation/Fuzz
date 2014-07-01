//
//  ElasticLine.m
//  cocos2d3test
//
//  Created by Aleksandar Angelov on 6/18/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

#import "ElasticLine.h"

@implementation ElasticLine
@synthesize segmentList=_segmentList;
+ (instancetype)ropeWithSegments:(int)segments objectA:(CCNode *)objectA posA:(CGPoint)posA objectB:(CCNode *)objectB posB:(CGPoint)posB
{
    return([[ElasticLine alloc] initWithSegments:segments objectA:objectA posA:posA objectB:objectB posB:posB]);
}

- (instancetype)initWithSegments:(int)segments objectA:(CCNode *)objectA posA:(CGPoint)posA objectB:(CCNode *)objectB posB:(CGPoint)posB
{
    self = [super init];
    if (!self) return(nil);
    objectB = nil;
    NSAssert(segments > 1, @"Rope must have at least two segments");
    
    
    self.segmentList = [NSMutableArray array];
    CGPoint directionVector = ccpNormalize(ccpSub(posB, posA));
    CGPoint currentPos = posA;
    float segmentLength = ccpDistance(posA, posB) / segments;
    CGPoint segmentVector = ccpMult(directionVector, segmentLength);
    float adjacentSide = fabsf(posA.x-posB.x);
    float oppositeSide = fabsf(posA.y-posB.y);
    float tan = oppositeSide/adjacentSide;
    float angle = CC_RADIANS_TO_DEGREES(atanf(tan));
    angle = [self angle:angle directionVector:directionVector];
    NSAssert(segmentLength > 0, @"Segment length must be greater then zero");
    //
    CCNode* previousNode = objectA;
    if (!previousNode)
    {
        previousNode = [CCNode node];
        previousNode.position = posA;
        previousNode.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:1 andCenter:CGPointZero];
        previousNode.physicsBody.type = CCPhysicsBodyTypeStatic;
        [self addChild:previousNode];
    }
    CCNode *firstBlobLineSegment = nil,*middleBlobLineSegment=nil;
    CGSize firstPathLineSize = CGSizeZero;
    CGPoint jointAnchor = ccpSub(posA, previousNode.position);
    int middleElementIndex = segments/2;
    for (int i = 0; i < segments; i ++)
    {

        CGPoint segmentPos = ccpAdd(currentPos, ccpMult(segmentVector, 0.5));

        CCNode *blobLineSegment = [CCNode node];
        blobLineSegment.position = segmentPos;
        
        CCSprite *pathSprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"pathLine%d.png",i+1]];
        pathSprite.rotation = angle;
        [blobLineSegment addChild:pathSprite];
        if (i == 0) {
            firstBlobLineSegment = blobLineSegment;
            firstPathLineSize = pathSprite.boundingBox.size;
        }
        if (i == middleElementIndex) {
            middleBlobLineSegment = blobLineSegment;
        }
        
        pathSprite.scaleX = (segmentLength+3)/ pathSprite.contentSize.width;
         
        
        blobLineSegment.physicsBody = [CCPhysicsBody bodyWithPillFrom:ccpMult(segmentVector, -0.5)
                                                               to:ccpMult(segmentVector, 0.5)
                                                     cornerRadius:0];
        blobLineSegment.physicsBody.mass = 1;
        blobLineSegment.physicsBody.collisionCategories = @[@"rope"];
        blobLineSegment.physicsBody.collisionMask = @[@"sphere",@"villain"];
        blobLineSegment.physicsBody.collisionGroup = self;
        blobLineSegment.physicsBody.affectedByGravity = false;
        
        [_segmentList addObject:pathSprite];
        [self addChild:blobLineSegment];
      //  float distance = segmentLength/2;
        
        [CCPhysicsJoint connectedPivotJointWithBodyA:previousNode.physicsBody bodyB:blobLineSegment.physicsBody anchorA:jointAnchor];
        if (i == segments-1) {
        //    CCSprite *firstPathSprite = [[firstBlobLineSegment children]objectAtIndex:0];
            CCNode *springNode = [CCNode node];
            float springNodePosX=0.f;
            float springNodePosY=0.f;
            if (posA.x==posB.x) {
                springNodePosX = previousNode.position.x - 30;
                springNodePosY = blobLineSegment.position.y-pathSprite.boundingBox.size.height/2+ccpDistance(posB, posA)/2;
            }
            else if(posA.y==posB.y) {
                springNodePosX = blobLineSegment.position.x+pathSprite.boundingBox.size.width/2-ccpDistance(posB, posA)/2;
                springNodePosY = previousNode.position.y + 30;
            }
            else {
                springNodePosX = blobLineSegment.position.x+pathSprite.boundingBox.size.width/2-ccpDistance(posB, posA)/2;
                springNodePosY = previousNode.position.y + 30;
            }
            springNode.position = ccp(springNodePosX, springNodePosY);
            springNode.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:1 andCenter:CGPointZero];
            springNode.physicsBody.type = CCPhysicsBodyTypeStatic;
            springNode.physicsBody.collisionMask = @[];
            springNode.physicsBody.collisionCategories = @[];
            [self addChild:springNode];
    
            float distancex = segmentLength/2;
            float distancey = fabs(springNode.position.y - blobLineSegment.position.y);
            float restLength = sqrtf(distancex*distancex+distancey*distancey);
            [CCPhysicsJoint connectedSpringJointWithBodyA:blobLineSegment.physicsBody bodyB:springNode.physicsBody anchorA:ccp(0,0) anchorB:springNode.anchorPointInPoints restLength:5 stiffness:30 damping:15];
            [CCPhysicsJoint connectedSpringJointWithBodyA:firstBlobLineSegment.physicsBody bodyB:springNode.physicsBody anchorA:ccp(0, 0) anchorB:springNode.anchorPointInPoints restLength:5 stiffness:30 damping:15];
            restLength = 30;
            CGPoint anchorA = ccp(0, 0);
            if (segments%2==0) {
                anchorA = ccp(-[middleBlobLineSegment.children[0] boundingBox].size.width/2, 0);
            }
            [CCPhysicsJoint connectedSpringJointWithBodyA:middleBlobLineSegment.physicsBody bodyB:springNode.physicsBody anchorA:anchorA anchorB:springNode.anchorPointInPoints restLength:restLength stiffness:30 damping:15];
            
        }
        
        
        

        //[CCPhysicsJoint connectedSpringJointWithBodyA:baseSegment.physicsBody bodyB:springNode.physicsBody anchorA:ccp(0,0) anchorB:springNode.anchorPointInPoints restLength:restLength stiffness:30 damping:10];
        
        previousNode = blobLineSegment;
        currentPos = ccpAdd(currentPos, segmentVector);
        jointAnchor = ccpMult(segmentVector, 0.5);
 
    }
    if (!objectB)
    {
        objectB = [CCNode node];
        objectB.position = posB;
        objectB.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:1 andCenter:CGPointZero];
        objectB.physicsBody.type = CCPhysicsBodyTypeStatic;
        [self addChild:objectB];
    }
    [CCPhysicsJoint connectedPivotJointWithBodyA:previousNode.physicsBody bodyB:objectB.physicsBody anchorA:jointAnchor];
    //[self setContentSize:contentSize];
    NSLog(@"%f %f",self.boundingBox.size.width,self.boundingBox.size.height);
    
    // done
    return(self);
}
-(float)angle:(float)angle directionVector:(CGPoint)directionVector{
    if (directionVector.x < 0) {
        angle += 180.f;
    }
    if ((directionVector.x < 0 && directionVector.y<0) || (directionVector.x>0 && directionVector.y>0)) {
        angle*=-1;
    }
    return angle;
}
- (void)dealloc
{
    CCLOG(@"A rope was deallocated");
    // clean up code goes here, should there be any
    
}
@end
