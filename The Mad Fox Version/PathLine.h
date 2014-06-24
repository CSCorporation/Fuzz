//
//  PathLine.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/16/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathLine : NSObject
@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGPoint endPoint;
-(id)initWithPoints:(CGPoint)startPointArg endPoint:(CGPoint)endPointArg;
@end
