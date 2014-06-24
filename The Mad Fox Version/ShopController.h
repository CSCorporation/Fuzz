//
//  ShopController.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/16/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ShopView.h"
#import "MenuController.h"

@interface ShopController : CCNodeColor <ShopDelegate> {
    ShopView* _view;

}
+ (CCScene *)scene;
@end
