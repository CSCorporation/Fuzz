//
//  Chicken.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 10/21/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chicken : NSObject

-(id)initWithImageFilename:(NSString*)filenameArg atPoint:(CGPoint)positionArg keyIndex:(NSString*)keyIndexArg;
@property (nonatomic,retain) NSString *filename;
@property (nonatomic,assign) CGPoint position;
@property (nonatomic,retain) NSString *keyIndex;
@property (nonatomic,assign) bool isDummyChicken;
@end
