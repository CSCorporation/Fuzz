//
//  OptionsView.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@protocol OptionsDelegate
-(void)musicConfiguration;
-(void)goBack;
@end

@interface OptionsView : CCNode {
    id<OptionsDelegate> _delegate;
}
-(id)initWithDelegate:(id<OptionsDelegate>) delegateArg;
@property (nonatomic,retain) id<OptionsDelegate> delegate;

@end
