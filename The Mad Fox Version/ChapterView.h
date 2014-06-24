//
//  ChapterView.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/19/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@protocol ChapterDelegate
-(void)back;
-(void)loadChapter;
@end
@interface ChapterView : CCNode {
    id<ChapterDelegate> _delegate;
}
-(id)initWithDelegate:(id<ChapterDelegate>) delegateArg;
@property (nonatomic,retain) id<ChapterDelegate> delegate;
@end
