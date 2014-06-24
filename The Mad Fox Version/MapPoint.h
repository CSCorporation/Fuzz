//
//  MapPoint.h
//  The Mad Fox Version
//
//  Created by Aleksandar Angelov on 5/26/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapPoint : NSObject
@property(nonatomic,retain) NSString *index;
@property(nonatomic,assign) CGPoint position;
@property(nonatomic,assign) bool chicken;
@property(nonatomic,assign) bool fox;
@property(nonatomic,retain) NSMutableArray *neighboursList;
@end
