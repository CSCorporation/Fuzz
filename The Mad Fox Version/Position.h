//
//  Position.h
//  The Mad Fox Version
//
//  Created by Aleksandar Angelov on 5/27/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject
@property(nonatomic,assign) float x;
@property(nonatomic,assign) float y;
-(id)initWithCordX:(int)x_ cordY:(int)y_;
@end
