//
//  Queue.m
//  Graph
//
//  Created by Aleksandar Angelov on 11/9/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import "Queue.h"

@implementation Queue
@synthesize size;
- (id)init
{
	if( self=[super init] )
	{
		_array = [[NSMutableArray alloc] init];
		size = 0;
	}
	return self;
}



- (void)enqueue:(id)anObject
{
	[_array addObject:anObject];
	size = (int)_array.count;
}
- (id)dequeue
{
	id obj = nil;
	if(_array.count > 0)
	{
		obj = [_array objectAtIndex:0];
		[_array removeObjectAtIndex:0];
		size = (int)_array.count;
	}
	return obj;
}

- (void)clear
{
	[_array removeAllObjects];
	size = 0;
}


@end
