//
//  LineView.h
//  TheMadFox-LevelBuilder
//
//  Created by Aleksandar Angelov on 3/26/14.
//  Copyright (c) 2014 Aleksandar Angelov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface LineView : CCNode {
    
}
@property(nonatomic,assign) CGPoint fromPoint;
@property(nonatomic,assign) CGPoint toPoint;
-(id)initWithPoints: (CGPoint)startPoint endPoint:(CGPoint)endPoint;
@end