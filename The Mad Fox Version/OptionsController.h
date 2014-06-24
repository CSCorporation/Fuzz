//
//  OptionsController.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "OptionsView.h"

@interface OptionsController : CCNodeColor <OptionsDelegate> {
    
}
@property(nonatomic,retain)OptionsView *optionsView;
+ (CCScene *)scene;
-(void)musicConfiguration;
@end
