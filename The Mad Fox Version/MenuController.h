//
//  MenuController.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuView.h"

@interface MenuController : CCNodeColor <MenuDelegate>{
    
}
@property(nonatomic,retain)MenuView *menuView;
+ (CCScene *)scene;
@end
