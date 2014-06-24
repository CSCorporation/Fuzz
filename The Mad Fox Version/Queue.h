//
//  Queue.h
//  Graph
//
//  Created by Aleksandar Angelov on 11/9/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject
{
    NSMutableArray* _array;
}
- (void)enqueue:(id)anObject;
- (id)dequeue;
- (void)clear;

@property (nonatomic, readonly) int size;
@end
